
CREATE VIEW [model].[_Alerts] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   12 Jul 2019 2:55:43 PM
-- Reason               :   Semantic View for dbo.FactAlerts
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [AlertTypeKey] AS [AlertTypeKey]
	,[CameraKey] AS [CameraKey]
	,[GeoLocationKey] AS [GeoLocationKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[UpdatedDateKey] AS [UpdatedDateKey]
	,[UpdatedTimeKey] AS [UpdatedTimeKey]
	,[VehicleKey] AS [VehicleKey]
	,[AlertRecordID] AS [Alert Record ID]
	,[AlertStatus] AS [Alert Status]
	,[SourceAlertID] AS [Source Alert ID]
	,[SourceSystem] AS [Source System]
	,[SpeedClassCode] AS [Speed Class Code]
	,[VehicleCategory] AS [Vehicle Category]
	,[VehicleCategoryCode] AS [Vehicle Category Code]
	,[VehicleUsage] AS [Vehicle Usage]
	,[VehicleUsageCode] AS [Vehicle Usage Code]
	,[AverageSpeed] AS [_AverageSpeed]
	,[DurationAlert] AS [_DurationAlert]
	,[DurationPrimary] AS [_DurationPrimary]
	,[SpeedLimit] AS [_SpeedLimit]
FROM WCG_DW.dbo.FactAlerts WITH (NOLOCK)
