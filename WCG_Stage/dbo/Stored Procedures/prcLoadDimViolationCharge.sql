
CREATE PROCEDURE [dbo].[prcLoadDimViolationCharge]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-05-2018
-- Reason				:	Performs SCD Logic for DimViolationCharge using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimViolationCharge] -1
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
	 [ChargeAmount]
	,[ChargeCategory]
	,[ChargeCategoryOrder]
	,[ChargeCode]
	,[ChargeDescription]
	,[ChargeGUID]
	,[ChargeSubCategory]
	,[ChargeSubCategoryOrder]
	,[RegulationNumber]
FROM WCG_STAGE.itis.transformDimViolationCharge
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimViolationCharge dim
USING conf
ON (dim.[ChargeGUID] = conf.[ChargeGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 [ChargeAmount]
		,[ChargeCategory]
		,[ChargeCategoryOrder]
		,[ChargeCode]
		,[ChargeDescription]
		,[ChargeGUID]
		,[ChargeSubCategory]
		,[ChargeSubCategoryOrder]
		,[RegulationNumber]
		,[InsertAuditKey]
		,[UpdateAuditKey]
	)
	VALUES (
		 conf.[ChargeAmount]
		,conf.[ChargeCategory]
		,conf.[ChargeCategoryOrder]
		,conf.[ChargeCode]
		,conf.[ChargeDescription]
		,conf.[ChargeGUID]
		,conf.[ChargeSubCategory]
		,conf.[ChargeSubCategoryOrder]
		,conf.[RegulationNumber]
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[ChargeAmount]				<> conf.[ChargeAmount]
		OR dim.[ChargeCategory]				<> conf.[ChargeCategory]
		OR dim.[ChargeCategoryOrder]		<> conf.[ChargeCategoryOrder]
		OR dim.[ChargeCode]					<> conf.[ChargeCode]
		OR dim.[ChargeDescription]			<> conf.[ChargeDescription]
		OR dim.[ChargeSubCategory]			<> conf.[ChargeSubCategory]
		OR dim.[ChargeSubCategoryOrder]		<> conf.[ChargeSubCategoryOrder]
		OR dim.[RegulationNumber]			<> conf.[RegulationNumber]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[ChargeAmount]				= conf.[ChargeAmount],
			dim.[ChargeCategory]			= conf.[ChargeCategory],
			dim.[ChargeCategoryOrder]		= conf.[ChargeCategoryOrder],
			dim.[ChargeCode]				= conf.[ChargeCode],
			dim.[ChargeDescription]			= conf.[ChargeDescription],
			dim.[ChargeSubCategory]			= conf.[ChargeSubCategory],
			dim.[ChargeSubCategoryOrder]	= conf.[ChargeSubCategoryOrder],
			dim.[RegulationNumber]			= conf.[RegulationNumber],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimViolationCharge




;
;
;

;
;

