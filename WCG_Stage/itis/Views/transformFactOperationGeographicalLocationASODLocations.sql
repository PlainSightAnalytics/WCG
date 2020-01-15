
CREATE VIEW [itis].[transformFactOperationGeographicalLocationASODLocations] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	16-12-2019
-- Reason				:	Transform view for FactOperationGeographicalLocation for ASOD Location Operations
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

WITH ExcludedOperations AS (
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
	 o.operation_id											AS OperationId
	,c.Latitude												AS Latitude
	,c.Longitude											AS Longitude	
	,o.ID													AS UniqueId
	,o.DeltaLogKey											AS DeltaLogKey
FROM itis.operation_asod_road_section_join o WITH (NOLOCK)
LEFT JOIN CameraLocationCTE c ON SUBSTRING(asod_name,1,CHARINDEX('-',asod_name)-2) = c.[CameraLocation]
LEFT JOIN ExcludedOperations e ON o.ID = e.operation_id
WHERE e.operation_id IS NULL