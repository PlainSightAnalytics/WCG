



CREATE VIEW [model].[_Alerts Summary] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.FactAlertsSummary
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	15-07-2019
-- Reason               :	Added new column for Operations Day (OperationsDateKey)
------------------------------------------------------------------------------------------

SELECT 
	 [AlertDateKey] AS [AlertDateKey]
	,[AlertTypeKey] AS [AlertTypeKey]
	,[CameraKey] AS [CameraKey]
	,[GeoLocationKey] AS [GeoLocationKey]
	,[HourKey] AS [HourKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[VehicleTypeKey] AS [VehicleTypeKey]
	,[AlertsCount] AS [_AlertsCount]
	,[AverageSpeed] AS [_AverageSpeed]
	,[MaximumSpeed] AS [_MaximumSpeed]
	,[VehicleCountDay] AS [_VehicleCountDay]
	,[VehicleCountDayCamera] AS [_VehicleCountDayCamera]
	,[VehicleCountDayRegion] AS [_VehicleCountDayRegion]
	,[VehicleCountDayTrafficCentre] AS [_VehicleCountDayTrafficCentre]
	,[VehicleCountDayTrafficCentreHour] AS [_VehicleCountDayTrafficCentreHour]
	,[VehicleCountDayTrafficCentreShift] AS [_VehicleCountDayTrafficCentreShift]
	,[DeltaLogKey] AS [DeltaLogKey]
FROM WCG_DW.dbo.FactAlertsSummary WITH (NOLOCK)

