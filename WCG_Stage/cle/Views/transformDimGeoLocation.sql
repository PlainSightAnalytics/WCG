






CREATE VIEW [cle].[transformDimGeoLocation] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	18-06-2016
-- Reason				:	Transform view for GeoLocation
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-01-2019
-- Reason				:	Added validation for GPS Co-ordinates
--------------------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT
	 CAST(YCoord AS NUMERIC(19,2))		AS [LongitudeRange]
	,CAST(XCoord AS NUMERIC(19,2))		AS [LatitudeRange]
	,CAST(MAX(YCoord) AS NUMERIC(19,5))	AS [Longitude]
	,CAST(MAX(XCoord) AS NUMERIC(19,5))	AS [Latitude]
	,DeltaLogKey							AS [DeltaLogKey]
FROM [WCG_Stage].[cle].Sightings
GROUP BY
	 CAST(YCoord AS NUMERIC(19,2))
	,CAST(XCoord AS NUMERIC(19,2))
	,DeltaLogKey
HAVING
--     CAST(YCoord AS NUMERIC(19,2)) <> 0 and CAST(XCoord AS NUMERIC(19,2))  <> 0
	CAST(YCoord AS NUMERIC(19,2)) BETWEEN 10 AND 40
AND	CAST(XCoord AS NUMERIC(19,2)) BETWEEN -40 AND -10









