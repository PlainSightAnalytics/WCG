CREATE PROCEDURE [dbo].[prcLoadDimScript]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-12-2019
-- Reason				:	Performs SCD Logic for DimScript using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimScript] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT

AS

SET FMTONLY OFF
SET NOCOUNT ON

DECLARE
@RowCountInsert INT,
@RowCountUpdate INT,
@RowCountExtract INT

DECLARE @RowCounts TABLE
(mergeAction varchar(10));

WITH conf AS (
SELECT
	 ScriptName
	,ParentScriptName
	,ScriptOrder
	,IsParentScript
FROM WCG_STAGE.meta.transformDimScript
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimScript dim
USING  conf
ON (dim.ScriptName = conf.ScriptName)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			IsParentScript, ParentScriptName, ScriptName, ScriptOrder, InsertAuditKey, UpdateAuditKey
			)
	VALUES (
			conf.IsParentScript, conf.ParentScriptName, conf.ScriptName, ScriptOrder, @AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.IsParentScript	<> conf.IsParentScript
		OR dim.ParentScriptName <> conf.ParentScriptName
		OR dim.ScriptOrder		<> conf.ScriptOrder
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.IsParentScript		= conf.IsParentScript,
			dim.ParentScriptName	= conf.ParentScriptName,
			dim.ScriptOrder			= conf.ScriptOrder,
			/* Update System Fields */
			dim.UpdateAuditKey = @AuditKey,
			dim.RowIsInferred = 'N',
			dim.RowChangeReason = 
				CASE 
					WHEN dim.RowIsInferred = 'Y' THEN 'Inferred Member Arrived'
					ELSE 'SCD Type 1 Change'
				END
OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.meta.transformDimScript



;
;
;
;