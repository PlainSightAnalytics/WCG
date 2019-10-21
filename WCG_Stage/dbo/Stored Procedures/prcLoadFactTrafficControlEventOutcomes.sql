


CREATE PROCEDURE [dbo].[prcLoadFactTrafficControlEventOutcomes]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	07-05-2018
-- Reason				:	Load FactTrafficControlEventOutcomes
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactTrafficControlEventOutcomes -1, 16623
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT

AS

DECLARE
@RowCountInsert INT

/* Delete existing Alert/Event type combinations */
;WITH cte AS (
SELECT
	UniqueChargeID
	,UniqueSection56FormID
FROM WCG_Stage.dbo.LoadFactTrafficControlEventOutcomes WITH (NOLOCK)
WHERE DeltaLogKey = @DeltaLogKey
)

DELETE f
FROM WCG_DW.dbo.FactTrafficControlEventOutcomes f
INNER JOIN cte ON f.UniqueChargeID = cte.UniqueChargeID AND f.UniqueSection56FormID = cte.UniqueSection56FormID

INSERT INTO WCG_DW.dbo.FactTrafficControlEventOutcomes (
	 DeviceKey
	,DriverKey
	,MagistratesCourtKey
	,OpenDateKey
	,OpenTimeKey
	,OperationsDateKey
	,Section56FormKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UpdatedDateKey
	,UpdatedTimeKey
	,UserKey
	,VehicleKey
	,VehicleTypeKey
	,ViolationChargeKey
	,UniqueChargeID
	,UniqueSection56FormID
	,ChargeAmount
	,InsertAuditKey
	,UpdateAuditKey
	,DeltaLogKey
)
SELECT
	 DeviceKey
	,DriverKey
	,MagistratesCourtKey
	,OpenDateKey
	,OpenTimeKey
	,OperationsDateKey
	,Section56FormKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UpdatedDateKey
	,UpdatedTimeKey
	,UserKey
	,VehicleKey
	,VehicleTypeKey
	,ViolationChargeKey
	,UniqueChargeID
	,UniqueSection56FormID
	,ChargeAmount
	,@AuditKey
	,@AuditKey
	,@DeltaLogKey
FROM WCG_Stage.dbo.LoadFactTrafficControlEventOutcomes WITH (NOLOCK)
WHERE DeltaLogKey = @DeltaLogKey

/* Store Inserted Rows */
SELECT @RowCountInsert = @@ROWCOUNT

/* Update Delta Log */
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey







	



;



;
;
;
;


