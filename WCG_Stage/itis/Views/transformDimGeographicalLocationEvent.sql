

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
	,CAST(gps_location_latitude AS NUMERIC(11,6))					AS [Latitude]
	,CAST(gps_location_longitude AS NUMERIC(11,6))					AS [Longitude]
	,ROW_NUMBER() OVER (PARTITION BY 
							CAST(gps_location_latitude AS NUMERIC(11,6)), 
							CAST(gps_location_longitude AS NUMERIC(11,6))
						ORDER BY updated_at DESC)					AS [RowSequence]
	,DeltaLogKey
FROM [WCG_Stage].[itis].[event]
WHERE gps_location_latitude IS NOT NULL