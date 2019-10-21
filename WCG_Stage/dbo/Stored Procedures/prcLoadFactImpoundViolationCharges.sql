CREATE PROCEDURE [dbo].[prcLoadFactImpoundViolationCharges]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-02-2018
-- Reason				:	Load FactImpoundViolationCharges using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactImpoundViolationCharges -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	15-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
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
	 [CreateDateKey]
	,[DriverKey]
	,[ImpoundInstructionKey]
	,[ImpoundJourneyUserKey]
	,[OperationsDateKey]
	,[PoundFacilityKey]
	,[TrafficCentreKey]
	,[VehicleKey]
	,[ViolationChargeKey]	
	,[UniqueID]
	,[DeltaLogKey]
FROM [dbo].[LoadFactImpoundViolationCharges] conf
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactImpoundViolationCharges fact
USING conf
ON (fact.[UniqueId] = conf.[UniqueId])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 [CreateDateKey]
	,[DriverKey]
	,[ImpoundInstructionKey]
	,[ImpoundJourneyUserKey]
	,[OperationsDateKey]
	,[PoundFacilityKey]
	,[TrafficCentreKey]
	,[VehicleKey]
	,[ViolationChargeKey]
	,[UniqueID]
	,[DeltaLogKey]
	,[InsertAuditKey]
	,[UpdateAuditKey]
			)
	VALUES (
	 conf.[CreateDateKey]
	,conf.[DriverKey]
	,conf.[ImpoundInstructionKey]
	,conf.[ImpoundJourneyUserKey]
	,conf.[OperationsDateKey]
	,conf.[PoundFacilityKey]
	,conf.[TrafficCentreKey]
	,conf.[VehicleKey]
	,conf.[ViolationChargeKey]
	,conf.[UniqueID]
	,conf.[DeltaLogKey]
	,@AuditKey
	,@AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			 fact.[CreateDateKey]			= conf.[CreateDateKey]
			,fact.[DriverKey]				= conf.[DriverKey]
			,fact.[ImpoundInstructionKey]	= conf.[ImpoundInstructionKey]
			,fact.[ImpoundJourneyUserKey]	= conf.[ImpoundJourneyUserKey]
			,fact.[OperationsDateKey]		= conf.[OperationsDateKey]
			,fact.[PoundFacilityKey]		= conf.[PoundFacilityKey]
			,fact.[TrafficCentreKey]		= conf.[TrafficCentreKey]
			,fact.[VehicleKey]				= conf.[VehicleKey]			
			,fact.[ViolationChargeKey]		= conf.[ViolationChargeKey]	
			/* Update System Fields */
			,fact.UpdateAuditKey			= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.[dbo].[LoadFactImpoundViolationCharges] WHERE DeltaLogKey = @DeltaLogKey

/* Update Delta Log */
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	RowCountUpdate = @RowCountUpdate,
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey






	



;



;
;
;






