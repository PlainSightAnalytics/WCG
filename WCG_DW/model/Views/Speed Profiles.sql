CREATE VIEW [model].[Speed Profiles]

AS

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   17-04-2019
-- Reason               :   Calculate Speed Profiles from Sightings
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

WITH SightingsCTE AS (
SELECT
	 v.RegistrationNo 
	,CAST(d.FullDate AS DATETIME) + CAST(t.FullTime AS DATETIME) AS SightingDateTime
	,CameraLocation
	,Route
	,SightingRecordId
	,TravelDirection
	,RouteSequence
	,c.CameraID
	,c.SiteID
	,c.LaneID
	,v.VehicleCategory
	,v.VehicleUsage
	,ROW_NUMBER() OVER (PARTITION BY v.RegistrationNo,f.SightingDateKey, f.SightingTimeKey ORDER BY f.SightingDateKey, f.SightingTimeKey) as RowSequence
FROM WCG_DW.dbo.FactSightings	f WITH (NOLOCK) 
LEFT JOIN WCG_DW.dbo.DimVehicle v WITH (NOLOCK)  ON f.VehicleKey = v.VehicleKey
LEFT JOIN WCG_DW.dbo.DimCamera	c WITH (NOLOCK)  ON f.CameraKey = c.CameraKey
LEFT JOIN WCG_DW.dbo.DimDate	d WITH (NOLOCK)  ON f.SightingDateKey = d.DateKey
LEFT JOIN WCG_DW.dbo.DimTime	t WITH (NOLOCK)  ON f.SightingTimeKey = t.TimeKey
WHERE 
	f.CameraKey <> -1					
AND c.IsMobileCamera = 'No'
)

,SightingsFilteredCTE AS (
SELECT
	 RegistrationNo
	,SightingDateTime
	,CameraLocation
	,Route
	,SightingRecordId
	,TravelDirection
	,RouteSequence
	,CameraID
	,SiteID
	,LaneID
	,VehicleCategory
	,VehicleUsage
FROM SightingsCTE s
WHERE 
	RowSequence = 1															
)

,CTE0 AS (
SELECT 
*
,LAG(SightingDateTime) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime) AS PreviousSightingDateTime
,LAG(CameraLocation) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime) AS PreviousCamera
,LAG(Route) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime) AS PreviousRoute
,CAST(DATEDIFF(MINUTE,LAG(SightingDateTime) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime),SightingDateTime) AS NUMERIC(11,2)) AS Duration
,CONCAT(LAG(CameraLocation) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime), ' to ', CameraLocation) AS CameraToCamera
FROM SightingsFilteredCTE
)

,CTE1 AS (
SELECT
cte0.*
,ctc.Distance
,ctc.Time
,ctc.Distance / cte0.duration * 60 AS AverageSpeed
,CEILING(ctc.Distance / cte0.duration * 60)  AS SpeedRounded
FROM CTE0
INNER JOIN  WCG_Stage.man.CameraToCamera ctc ON CTE0.CameraToCamera = ctc.FromToCamera
)

,SpeedBucketCTE AS (
SELECT 0 AS FromSpeed,  10 AS ToSpeed, '0-10 Km/h'	AS SpeedBucket UNION 
SELECT 11, 20, '11-20 Km/h' UNION 
SELECT 21, 30, '21-30 Km/h'	UNION 
SELECT 31, 40, '31-40 Km/h'	UNION 
SELECT 41, 50, '41-50 Km/h'	UNION 
SELECT 51, 60, '51-60 Km/h'	UNION 
SELECT 61, 70, '61-70 Km/h'	UNION 
SELECT 71, 80, '71-80 Km/h'	UNION 
SELECT 81, 90, '81-90 Km/h'	UNION 
SELECT 91, 100, '91-100 Km/h'	UNION 
SELECT 101, 110, '101-110 Km/h'	UNION 
SELECT 111, 120, '111 - 120 Km/h'	UNION 
SELECT 121, 130, '121-130 Km/h'	UNION 
SELECT 131, 140, '131-140 Km/h'	UNION 
SELECT 141, 150, '141-150 Km/h'	UNION 
SELECT 151, 160, '151-160 Km/h' UNION
SELECT 161, 9999999, 'Over 160 Km/h'
)

SELECT 
	CAST(SightingDateTime AS DATE)		AS [Sighting Date]
	,Route								AS [Route]
	,CameraLocation						AS [Camera]
	,VehicleCategory					AS [Vehicle Category]
	,VehicleUsage						AS [Vehicle Usage]
	,s.SpeedBucket						AS [Speed Bucket]
	,s.FromSpeed						AS [Speed Bucket Sort Order]
	,COUNT(1)							AS [VehicleCount]
FROM CTE1
LEFT JOIN SpeedBucketCTE s ON CTE1.SpeedRounded BETWEEN s.FromSpeed AND s.ToSpeed
GROUP BY 
CAST(SightingDateTime AS DATE),
Route,
CameraLocation,
VehicleCategory,
VehicleUsage,
s.SpeedBucket,
s.FromSpeed
