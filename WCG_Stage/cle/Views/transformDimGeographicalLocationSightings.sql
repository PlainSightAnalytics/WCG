
CREATE VIEW [cle].[transformDimGeographicalLocationSightings] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	30-11-2019
-- Reason				:	Transform view for DimGeographicalLocation from man.Sightings
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST('Unnamed Location' AS VARCHAR(50))						AS LocationName
	,CAST('Mobile' AS VARCHAR(20))									AS LocationType
	,CAST('CLE' AS VARCHAR(20))										AS Source
	,CAST([XCoord] AS NUMERIC(11,2))								AS [LatitudeRange]
	,CAST(YCoord AS NUMERIC(11,2))									AS [LongitudeRange]
	,CAST(XCoord AS NUMERIC(11,6))									AS [Latitude]
	,CAST(YCoord AS NUMERIC(11,6))									AS [Longitude]
	,ROW_NUMBER() OVER (PARTITION BY 
							[XCoord], 
							YCoord
						ORDER BY SightingRecordId DESC)					AS [RowSequence]
	,DeltaLogKey
FROM [WCG_Stage].[cle].Sightings
WHERE
	CAST(YCoord AS NUMERIC(19,2)) BETWEEN 10 AND 40
AND	CAST(XCoord AS NUMERIC(19,2)) BETWEEN -40 AND -10
AND ISNUMERIC(CameraId) = 0