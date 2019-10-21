CREATE PROCEDURE [dbo].[prcLoadDimCriticalOutcomeType]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	28-10-2018
-- Reason				:	Performs SCD Logic for DimCriticalOutcomeType using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimCriticalOutcomeType] -1
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
SELECT DISTINCT
	 VehicleType
	,CriticalOutcomeMetric
	,CriticalOutcomeMetricCode
	,CriticalOutcomeType
	,CriticalOutcomeTypeCode
	,IsSystemPopulated
	,DeltaLogKey
FROM WCG_STAGE.itis.transformFactShiftOutcomes
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimCriticalOutcomeType dim
USING conf
ON (dim.CriticalOutcomeTypeCode = conf.CriticalOutcomeTypeCode AND dim.CriticalOutcomeMetricCode = conf.CriticalOutcomeMetricCode AND dim.VehicleType = conf.VehicleType AND dim.IsSystemPopulated = conf.IsSystemPopulated)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 VehicleType
		,CriticalOutcomeMetric
		,CriticalOutcomeMetricCode
		,CriticalOutcomeType
		,CriticalOutcomeTypeCode
		,IsSystemPopulated
		,DeltaLogKey
		,InsertAuditKey
		,UpdateAuditKey
			)
	VALUES (
		 conf.VehicleType
		,conf.CriticalOutcomeMetric
		,conf.CriticalOutcomeMetricCode
		,conf.CriticalOutcomeType
		,conf.CriticalOutcomeTypeCode
		,conf.IsSystemPopulated
		,@DeltaLogKey
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.CriticalOutcomeMetric		<> conf.CriticalOutcomeMetric	
		OR dim.CriticalOutcomeType			<> conf.CriticalOutcomeType

		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.CriticalOutcomeMetric		= conf.CriticalOutcomeMetric,	
			dim.CriticalOutcomeType			= conf.CriticalOutcomeType,
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformFactShiftOutcomes WHERE DeltaLogKey = @DeltaLogKey

