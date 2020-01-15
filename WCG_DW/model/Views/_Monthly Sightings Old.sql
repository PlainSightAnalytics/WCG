


CREATE VIEW [model].[_Monthly Sightings Old] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   22-10-2019
-- Reason               :   Monthly Sightings with Speed Profiles
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

/* CTE to get Sightings Data on or after the latest sighting date loaded in FactSpeedProfiles */
WITH SightingsCTE AS (
SELECT
	 v.RegistrationNo 
	,CAST(d.FullDate AS DATETIME) + CAST(t.FullTime AS DATETIME) AS SightingDateTime
	,CameraLocation
	,Route
	,TravelDirection
	,RouteSequence
	,f.CameraKey
	,f.TrafficCentreKey
	,ROW_NUMBER() OVER (PARTITION BY v.RegistrationNo,f.SightingDateKey, f.SightingTimeKey ORDER BY f.SightingDateKey, f.SightingTimeKey) as RowSequence
FROM WCG_DW.dbo.FactSightings		f WITH (NOLOCK) 
LEFT JOIN WCG_DW.dbo.DimVehicle		v WITH (NOLOCK)  ON f.VehicleKey = v.VehicleKey
LEFT JOIN WCG_DW.dbo.DimCamera		c WITH (NOLOCK)  ON f.CameraKey = c.CameraKey
LEFT JOIN WCG_DW.dbo.DimDate		d WITH (NOLOCK)  ON f.SightingDateKey = d.DateKey
LEFT JOIN WCG_DW.dbo.DimTime		t WITH (NOLOCK)  ON f.SightingTimeKey = t.TimeKey
WHERE 
	SightingRecordId <> 0
)

/* Eliminate Duplicates - Same vehicle at same date and time */
,SightingsFilteredCTE AS (
SELECT
	 RegistrationNo
	,SightingDateTime
	,CameraLocation
	,Route
	,TravelDirection
	,RouteSequence
	,CameraKey
	,TrafficCentreKey
FROM SightingsCTE s
WHERE 
	RowSequence = 1															
)

/* Get Previous Values and Calculate Duration between Cameras */
,CTE0 AS (
SELECT 
	 RegistrationNo
	,SightingDateTime
	,FORMAT(SightingDateTime,'yyyyMM') AS SightingMonthKey
	,CameraLocation
	,Route
	,TravelDirection
	,RouteSequence
	,CameraKey
	,TrafficCentreKey
	,LAG(SightingDateTime) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime) AS PreviousSightingDateTime
	,LAG(CameraLocation) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime) AS PreviousCamera
	,LAG(Route) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime) AS PreviousRoute
	,LAG(RouteSequence) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime) AS PreviousRouteSequence
	,CAST(DATEDIFF(MINUTE,LAG(SightingDateTime) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime),SightingDateTime) AS NUMERIC(11,2)) AS Duration
	,CONCAT(LAG(CameraLocation) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime), ' to ', CameraLocation) AS CameraToCamera
	FROM SightingsFilteredCTE
)

/* Calculate Average Speed */
,CTE1 AS (
SELECT
	 RegistrationNo
	,SightingDateTime
	,CameraLocation
	,Route
	,TravelDirection
	,RouteSequence
	,CameraKey
	,TrafficCentreKey
	,PreviousSightingDateTime
	,PreviousCamera
	,PreviousRoute
	,PreviousRouteSequence
	,Duration
	,CameraToCamera
	,SightingMonthKey
	,ctc.Distance
	,ctc.Time
	,ctc.Distance / cte0.duration * 60 AS AverageSpeed
	,CEILING(ctc.Distance / cte0.duration * 60)  AS SpeedRounded
	FROM CTE0
	LEFT JOIN  WCG_Stage.man.CameraToCamera ctc ON CTE0.CameraToCamera = ctc.FromToCamera
)


SELECT 
	 SightingMonthKey
	,CameraKey
	,ISNULL(SpeedProfileBucketKey,-1) AS SpeedProfileBucketKey
	,COUNT(DISTINCT RegistrationNo) AS VehicleCount
	,GROUPING(SightingMonthKey) AS MonthGroup
	,GROUPING(CameraKey) AS CameraGroup
	,GROUPING(SpeedProfileBucketKey) AS SpeedProfileGroup
FROM CTE1
LEFT JOIN WCG_DW.dbo.DimSpeedProfileBucket s WITH (NOLOCK) ON CTE1.SpeedRounded BETWEEN s.FromSpeed AND s.ToSpeed
GROUP BY 
	 SightingMonthKey
	,CameraKey
	,SpeedProfileBucketKey
	WITH ROLLUP