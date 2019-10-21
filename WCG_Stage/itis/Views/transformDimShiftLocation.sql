CREATE VIEW [itis].[transformDimShiftLocation] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-10-2018
-- Reason				:	Transform view for DimShiftLocation
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 CAST(ISNULL(s.gps_location_latitude,0) AS NUMERIC(19,2))				AS Latitude
	,CAST(ISNULL(s.location_type_display,'Unknown') AS VARCHAR(20))			AS LocationType
	,CAST(ISNULL(s.gps_location_longitude,0) AS NUMERIC(19,2))				AS Longitude
	,CAST(ISNULL(s.road_number,'Unknown') AS VARCHAR(10))					AS RoadNumber
	,CAST(ISNULL(s.location_name,'Unknown') AS VARCHAR(50))					AS ShiftLocation
	,s.id																	AS ShiftLocationID
	,CAST(ISNULL(t.TrafficCentre,'Unknown') AS VARCHAR(50))					AS TrafficCentre
	,s.DeltaLogKey															AS DeltaLogKey
FROM itis.site s
LEFT JOIN itis.transformDimTrafficCentre t ON s.traffic_centre_id = t.TrafficCentreId
