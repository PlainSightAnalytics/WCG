CREATE PROCEDURE [dbo].[prcLoadDimShiftActivityType]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-10-2018
-- Reason				:	Performs SCD Logic for DimShiftActivityType using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimShiftActivityType] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT

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
	 ShiftActivityTypeCode
	,ShiftActivityType
	,DeltaLogKey
FROM WCG_STAGE.itis.transformDimShiftActivityType
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimShiftActivityType dim
USING conf
ON (dim.ShiftActivityTypeCode = conf.ShiftActivityTypeCode)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 ShiftActivityTypeCode
		,ShiftActivityType
		,DeltaLogKey
		,InsertAuditKey
		,UpdateAuditKey
			)
	VALUES (
		 conf.ShiftActivityTypeCode
		,conf.ShiftActivityType
		,@DeltaLogKey
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.ShiftActivityType		<> conf.ShiftActivityType	

		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.ShiftActivityType		= conf.ShiftActivityType,	
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimShiftActivityType

