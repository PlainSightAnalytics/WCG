
CREATE VIEW [model].[_Sightings Summary] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactSightingsSummary
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [CameraKey] AS [CameraKey]
	,[GeoLocationKey] AS [GeoLocationKey]
	,[HourKey] AS [HourKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[SightingDateKey] AS [SightingDateKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[VehicleTypeKey] AS [VehicleTypeKey]
	,[SightingsCount] AS [_SightingsCount]
	,[VehicleCountDay] AS [_VehicleCountDay]
	,[VehicleCountDayCamera] AS [_VehicleCountDayCamera]
	,[VehicleCountDayRegion] AS [_VehicleCountDayRegion]
	,[VehicleCountDayTrafficCentre] AS [_VehicleCountDayTrafficCentre]
	,[VehicleCountDayTrafficCentreHour] AS [_VehicleCountDayTrafficCentreHour]
	,[VehicleCountDayTrafficCentreShift] AS [_VehicleCountDayTrafficCentreShift]
	,[DeltaLogKey] AS [DeltaLogKey]
FROM WCG_DW.dbo.FactSightingsSummary WITH (NOLOCK)
