
CREATE PROCEDURE [dbo].[prcLoadFactSightings]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	18-06-2016
-- Reason				:	Load FactAlert
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	prcLoadFactSightings -1, 1002
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT

AS

DECLARE @RowCountInsert INT

/* Load DimCVehicle */
EXEC [dbo].[prcLoadDimVehicleSightings] @AuditKey, @DeltaLogKey

/* Load DimGeoLocation */
EXEC [dbo].[prcLoadDimGeoLocation] @AuditKey, @DeltaLogKey

/* Load Fact Table */
INSERT INTO [WCG_DW].[dbo].[FactSightings] (
	 [CameraKey]
	,[GeoLocationKey]
	,[OperationsDateKey]
	,[SightingDateKey]
	,[SightingTimeKey]
	,[TrafficCentreKey]
	,[VehicleKey]
	,[PartyKey]
	,[SightingRecordId]
	,[InsertAuditKey]
	,[UpdateAuditKey]
	,[DeltaLogKey]
)
SELECT
	 [CameraKey]
	,[GeoLocationKey]
	,[OperationsDateKey]
	,[SightingDateKey]
	,[SightingTimeKey]
	,[TrafficCentreKey]
	,[VehicleKey]
	,[PartyKey]
	,[SightingRecordId]
	,@AuditKey
	,@AuditKey
	,@DeltaLogKey
FROM WCG_Stage.dbo.LoadFactSightings
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
