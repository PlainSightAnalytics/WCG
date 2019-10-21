
CREATE VIEW [model].[_Sightings] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactSightings
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [CameraKey] AS [CameraKey]
	,[GeoLocationKey] AS [GeoLocationKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[SightingDateKey] AS [SightingDateKey]
	,[SightingTimeKey] AS [SightingTimeKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[VehicleKey] AS [VehicleKey]
	,[PartyKey] AS [PartyKey]
	,[SightingRecordId] AS [Sighting Record Id]
FROM WCG_DW.dbo.FactSightings WITH (NOLOCK)
