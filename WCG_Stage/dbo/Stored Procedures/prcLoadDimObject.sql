CREATE PROCEDURE [dbo].[prcLoadDimObject]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-12-2019
-- Reason				:	Performs SCD Logic for DimObject using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimObject] -1
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

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimObject dim
USING WCG_Stage.meta.transformDimObject conf
ON (dim.ObjectFullName = conf.ObjectFullName)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 CreateDateTime
			,LastModifiedDateTime
			,ObjectFullName
			,ObjectLocation
			,ObjectName
			,ObjectType
			,ObjectTypeOrder
			,ParentObject
			,ParentObjectOrder
			,SchemaName
			,InsertAuditKey
			,UpdateAuditKey
			)
	VALUES (
			 conf.CreateDateTime
			,conf.LastModifiedDateTime
			,conf.ObjectFullName
			,conf.ObjectLocation
			,conf.ObjectName
			,conf.ObjectType
			,conf.ObjectTypeOrder
			,conf.ParentObject
			,conf.ParentObjectOrder
			,conf.SchemaName
			,@AuditKey
			,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.CreateDateTime		<> conf.CreateDateTime
		OR dim.LastModifiedDateTime	<> conf.LastModifiedDateTime
		OR dim.ObjectLocation		<> conf.ObjectLocation
		OR dim.ObjectName			<> conf.ObjectName
		OR dim.ObjectType			<> conf.ObjectType
		OR dim.ObjectTypeOrder		<> conf.ObjectTypeOrder
		OR dim.ParentObject			<> conf.ParentObject
		OR dim.ParentObjectOrder	<> conf.ParentObjectOrder
		OR dim.SchemaName			<> conf.SchemaName
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
		/* Update Type 1 Fields */
		dim.CreateDateTime			= conf.CreateDateTime,
		dim.LastModifiedDateTime	= conf.LastModifiedDateTime,
		dim.ObjectLocation			= conf.ObjectLocation,
		dim.ObjectName				= conf.ObjectName,
		dim.ObjectType				= conf.ObjectType,
		dim.ObjectTypeOrder			= conf.ObjectTypeOrder,
		dim.ParentObject			= conf.ParentObject,
		dim.ParentObjectOrder		= conf.ParentObjectOrder,
		dim.SchemaName				= conf.SchemaName,
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.meta.transformDimObject



;
;
;
;