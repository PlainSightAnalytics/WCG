


CREATE VIEW [itis].[transformDimGeographicalLocationEvent] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	30-11-2019
-- Reason				:	Transform view for DimGeographicalLocation from itis.event
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(ISNULL(location_name,'Unnamed Location') AS VARCHAR(50))	AS LocationName
	,CAST('Event' AS VARCHAR(20))									AS LocationType
	,CAST('EVENT' AS VARCHAR(20))									AS Source
	,CAST(gps_location_latitude AS NUMERIC(11,2))					AS [LatitudeRange]
	,CAST(gps_location_longitude AS NUMERIC(11,2))					AS [LongitudeRange]
	,CAST(gps_location_latitude AS NUMERIC(11,2))					AS [Latitude]
	,CAST(gps_location_longitude AS NUMERIC(11,2))					AS [Longitude]
--	,CAST(ROUND(gps_location_latitude,2) AS NUMERIC(11,2))			AS [Latitude]
--	,CAST(ROUND(gps_location_longitude,2) AS NUMERIC(11,2))			AS [Longitude]
	,ROW_NUMBER() OVER (PARTITION BY 
							CAST(gps_location_latitude AS NUMERIC(11,2)), 
							CAST(gps_location_longitude AS NUMERIC(11,2))
							--CAST(ROUND(gps_location_latitude,2) AS NUMERIC(11,2)), 
							--CAST(ROUND(gps_location_longitude,2) AS NUMERIC(11,2))
						ORDER BY updated_at DESC)					AS [RowSequence]
	,DeltaLogKey
FROM [WCG_Stage].[itis].[event]
WHERE gps_location_latitude IS NOT NULL
AND CAST(gps_location_latitude AS NUMERIC(19,2)) BETWEEN 10 AND 40
AND	CAST(gps_location_latitude AS NUMERIC(19,2)) BETWEEN -40 AND -10