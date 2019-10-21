CREATE PROCEDURE [dbo].[prcLoadFactShiftOutcomes]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	28-10-2018
-- Reason				:	Load FactShiftOutcomes using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactShiftOutcomes -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
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
	 CriticalOutcomeTypeKey
	,OperationsDateKey
	,ShiftDateKey
	,ShiftKey
	,TrafficCentreKey
	,UserKey
	,IsStartedFillingIn
	,UniqueID
	,VehicleCount
	,DeltaLogKey
FROM [dbo].[LoadFactShiftOutcomes] conf
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactShiftOutcomes fact
USING conf
ON (fact.[UniqueID] = conf.[UniqueID] AND fact.CriticalOutcomeTypeKey = conf.CriticalOutcomeTypeKey)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 CriticalOutcomeTypeKey
	,OperationsDateKey
	,ShiftDateKey
	,ShiftKey
	,TrafficCentreKey
	,UserKey
	,IsStartedFillingIn
	,UniqueID
	,VehicleCount
	,DeltaLogKey
	,[InsertAuditKey]
	,[UpdateAuditKey]
			)
	VALUES (
	 conf.CriticalOutcomeTypeKey
	,conf.OperationsDateKey
	,conf.ShiftDateKey
	,conf.ShiftKey
	,conf.TrafficCentreKey
	,conf.UserKey
	,conf.IsStartedFillingIn
	,conf.UniqueID
	,conf.VehicleCount
	,conf.DeltaLogKey
	,@AuditKey
	,@AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */

			 fact.CriticalOutcomeTypeKey		= conf.CriticalOutcomeTypeKey
			,fact.OperationsDateKey				= conf.OperationsDateKey
			,fact.ShiftDateKey					= conf.ShiftDateKey
			,fact.ShiftKey						= conf.ShiftKey
			,fact.TrafficCentreKey				= conf.TrafficCentreKey
			,fact.UserKey						= conf.UserKey
			,fact.IsStartedFillingIn			= conf.IsStartedFillingIn
			,fact.UniqueID						= conf.UniqueID
			,fact.VehicleCount					= conf.VehicleCount	
			,fact.DeltaLogKey					= conf.DeltaLogKey

			/* Update System Fields */
			,fact.UpdateAuditKey			= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.[dbo].[LoadFactShiftOutcomes] WHERE DeltaLogKey = @DeltaLogKey

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






