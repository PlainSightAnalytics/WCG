CREATE VIEW [itis].[transformFactOperationGeographicalLocationSingleLocation] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	16-12-2019
-- Reason				:	Transform view for FactOperationGeographicalLocation for Single Location Operations
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------


WITH ExcludedOperations AS (
	SELECT DISTINCT operation_id
	FROM itis.operation_asod_road_section_join
	UNION ALL
	SELECT DISTINCT operation_id
	FROM itis.operation_location_join
)

,CameraLocationCTE AS (
	SELECT 
		CASE
			WHEN [Camera Location] = 'Leeu-Gamka' THEN 'Leeu Gamka'
			WHEN [Camera Location] = 'Beaufort West - North' THEN 'Beaufort West'
			ELSE [Camera Location]
		END AS CameraLocation
		,Latitude
		,Longitude
	FROM man.CameraLocations
)

SELECT 
	 o.ID													AS OperationId
	,COALESCE(
		CASE
			WHEN SUBSTRING(gps_location_latitude,4,1) ='.' 
				THEN CAST(s.gps_location_latitude AS NUMERIC(11,6))	
			ELSE NULL
		END
		,c.Latitude)											AS Latitude
	,COALESCE(
		CASE
			WHEN SUBSTRING(gps_location_longitude,3,1) = '.'
				THEN CAST(s.gps_location_longitude AS NUMERIC(11,6))
			ELSE NULL
		END
		,c.Longitude)										AS Longitude	
	,o.ID													AS UniqueId
	,o.DeltaLogKey											AS DeltaLogKey
FROM itis.operation o WITH (NOLOCK)
LEFT JOIN itis.site s WITH (NOLOCK) ON o.location_id = s.id
left JOIN itis.asod_road_section a WITH (NOLOCK) ON o.asod_road_section_id = a.id
LEFT JOIN CameraLocationCTE c ON SUBSTRING(a.name,1,CHARINDEX('-',a.name)-2) = c.[CameraLocation]
LEFT JOIN ExcludedOperations e ON o.ID = e.operation_id
WHERE e.operation_id IS NULL