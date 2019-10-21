

CREATE PROCEDURE [dbo].[prcLoadFactAlerts]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	18-06-2016
-- Reason				:	Load FactAlert
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	uspLoadFactAlerts -1, 1001
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   Trevor Howe
-- Modified On			:   13-07-2019
-- Reason				:   Added new key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT

AS

DECLARE @RowCountInsert INT

/* Load DimAlertType */
EXEC [dbo].[prcLoadDimAlertType] @AuditKey, @DeltaLogKey

/* Load DimVehicle */
EXEC [dbo].[prcLoadDimVehicleAlerts] @AuditKey, @DeltaLogKey

/* Load Fact Table */
INSERT INTO [WCG_DW].[dbo].[FactAlerts] (
	 AlertTypeKey
	,CameraKey
	,GeoLocationKey
	,OperationsDateKey
	,TrafficCentreKey
	,UpdatedDateKey
	,UpdatedTimeKey
	,VehicleKey
	,AlertRecordId
	,AlertStatus
	,SourceAlertID
	,SourceSystem
	,SpeedClassCode
	,VehicleCategory
	,VehicleCategoryCode
	,VehicleUsage
	,VehicleUsageCode
	,AverageSpeed
	,DurationAlert
	,DurationPrimary
	,SpeedLimit
	,InsertAuditKey
	,UpdateAuditKey
	,DeltaLogKey
)
SELECT
	 AlertTypeKey
	,CameraKey
	,GeoLocationKey
	,OperationsDateKey
	,TrafficCentreKey
	,UpdatedDateKey
	,UpdatedTimeKey
	,VehicleKey
	,AlertRecordId
	,AlertStatus
	,SourceAlertID
	,SourceSystem
	,SpeedClassCode
	,VehicleCategory
	,VehicleCategoryCode
	,VehicleUsage
	,VehicleUsageCode
	,AverageSpeed
	,DurationAlert
	,DurationPrimary
	,SpeedLimit
	,@AuditKey
	,@AuditKey
	,@DeltaLogKey
FROM WCG_Stage.dbo.LoadFactAlerts
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
;