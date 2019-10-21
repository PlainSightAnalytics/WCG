
CREATE VIEW [model].[_Traffic Control Events] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactTrafficControlEvents
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [AlertTypeKey] AS [AlertTypeKey]
	,[DeviceKey] AS [DeviceKey]
	,[DriverKey] AS [DriverKey]
	,[MagistratesCourtKey] AS [MagistratesCourtKey]
	,[OpenDateKey] AS [OpenDateKey]
	,[OpenTimeKey] AS [OpenTimeKey]
	,[OperationKey] AS [OperationKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[TrafficControlEventKey] AS [TrafficControlEventKey]
	,[UpdatedDateKey] AS [UpdatedDateKey]
	,[UpdatedTimeKey] AS [UpdatedTimeKey]
	,[UserKey] AS [UserKey]
	,[VehicleKey] AS [VehicleKey]
	,[VehicleTypeKey] AS [VehicleTypeKey]
	,[UniqueAlertID] AS [Unique Alert ID]
	,[UniqueEventID] AS [Unique Event ID]
	,[DeltaLogKey] AS [DeltaLogKey]
FROM WCG_DW.dbo.FactTrafficControlEvents WITH (NOLOCK)
