
CREATE VIEW [itis].[transformFactOperationGeographicalLocationMultipleLocations] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	16-12-2019
-- Reason				:	Transform view for FactOperationGeographicalLocation for Multiple Location Operations
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

WITH ExcludedOperations AS (
	SELECT DISTINCT operation_id
	FROM itis.operation_asod_road_section_join
)

SELECT 
	 o.operation_id											AS OperationId
	,CASE
		WHEN SUBSTRING(gps_location_latitude,4,1) ='.' 
			THEN CAST(s.gps_location_latitude AS NUMERIC(11,6))	
		ELSE NULL
	END														AS Latitude
	,CASE
		WHEN SUBSTRING(gps_location_longitude,3,1) = '.'
			THEN CAST(s.gps_location_longitude AS NUMERIC(11,6))
		ELSE NULL
	END														AS Longitude	
	,o.ID													AS UniqueId
	,o.DeltaLogKey											AS DeltaLogKey
FROM itis.operation_location_join o WITH (NOLOCK)
LEFT JOIN itis.site s WITH (NOLOCK) ON o.site_id = s.id
LEFT JOIN ExcludedOperations e ON o.ID = e.operation_id
WHERE e.operation_id IS NULL