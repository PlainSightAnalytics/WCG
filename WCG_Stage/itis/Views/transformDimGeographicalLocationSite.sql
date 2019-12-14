
CREATE VIEW [itis].[transformDimGeographicalLocationSite] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	30-11-2019
-- Reason				:	Transform view for DimGeographicalLocation from itis.site
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(location_name AS VARCHAR(50))								AS LocationName
	,CAST(ISNULL(location_type_display,'Unknown') AS VARCHAR(20))	AS LocationType
	,CAST('SITE' AS VARCHAR(20))									AS Source
	,CAST(gps_location_latitude AS NUMERIC(11,2))					AS [LatitudeRange]
	,CAST(gps_location_longitude AS NUMERIC(11,2))					AS [LongitudeRange]
	,CAST(gps_location_latitude AS NUMERIC(11,6))					AS [Latitude]
	,CAST(gps_location_longitude AS NUMERIC(11,6))					AS [Longitude]
	,ROW_NUMBER() OVER (PARTITION BY 
							gps_location_latitude, 
							gps_location_longitude
						ORDER BY updated_at DESC)					AS [RowSequence]
	,DeltaLogKey
FROM [WCG_Stage].[itis].[site]
WHERE SUBSTRING(gps_location_latitude,4,1) ='.'
AND SUBSTRING(gps_location_longitude,3,1) = '.'