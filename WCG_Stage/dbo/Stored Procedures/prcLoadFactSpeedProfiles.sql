
CREATE PROCEDURE [dbo].[prcLoadFactSpeedProfiles]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	05-07-2019
-- Reason				:	Loads Speed Profiles from latest Sightings data
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadFactSpeedProfiles] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------


@AuditKey					INT = -1,
@PreviousSightingDateKey	INT OUTPUT

AS

/* Get Last Sighting Date Loaded */
DECLARE @LatestSightingDateKey AS INT
SELECT @LatestSightingDateKey = ISNULL(MAX(SightingDateKey),19000101) FROM WCG_DW.dbo.FactSpeedProfiles

/* Delete the last stored sighting date - will be reloaded below in case of partial days */
DELETE FROM WCG_DW.dbo.FactSpeedProfiles
WHERE SightingDateKey = @LatestSightingDateKey 

/* CTE to get Sightings Data on or after the latest sighting date loaded in FactSpeedProfiles */
;WITH SightingsCTE AS (
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
	,c.CameraKey
	,y.VehicleTypeKey
	,ROW_NUMBER() OVER (PARTITION BY v.RegistrationNo,f.SightingDateKey, f.SightingTimeKey ORDER BY f.SightingDateKey, f.SightingTimeKey) as RowSequence
FROM WCG_DW.dbo.FactSightings		f WITH (NOLOCK) 
LEFT JOIN WCG_DW.dbo.DimVehicle		v WITH (NOLOCK)  ON f.VehicleKey = v.VehicleKey
LEFT JOIN WCG_DW.dbo.DimVehicleType y WITH (NOLOCK)  ON v.VehicleCategoryCode = y.VehicleCategoryCode AND v.VehicleUsageCode = y.VehicleUsageCode
LEFT JOIN WCG_DW.dbo.DimCamera		c WITH (NOLOCK)  ON f.CameraKey = c.CameraKey
LEFT JOIN WCG_DW.dbo.DimDate		d WITH (NOLOCK)  ON f.SightingDateKey = d.DateKey
LEFT JOIN WCG_DW.dbo.DimTime		t WITH (NOLOCK)  ON f.SightingTimeKey = t.TimeKey
WHERE 
	f.CameraKey <> -1					
AND c.IsMobileCamera = 'No'
AND f.SightingDateKey >= @LatestSightingDateKey
)

/* Eliminate Duplicates - Same vehicle at same date and time */
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
	,CameraKey
	,VehicleTypeKey
FROM SightingsCTE s
WHERE 
	RowSequence = 1															
)

/* Get Previous Values and Calculate Duration between Cameras */
,CTE0 AS (
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
	,CameraKey
	,VehicleTypeKey
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
	,SightingRecordId
	,TravelDirection
	,RouteSequence
	,CameraID
	,SiteID
	,LaneID
	,VehicleCategory
	,VehicleUsage
	,CameraKey
	,VehicleTypeKey
	,PreviousSightingDateTime
	,PreviousCamera
	,PreviousRoute
	,PreviousRouteSequence
	,Duration
	,CameraToCamera
	,FORMAT(SightingDateTime,'yyyyMMdd') AS SightingDateKey
	,ctc.Distance
	,ctc.Time
	,ctc.Distance / cte0.duration * 60 AS AverageSpeed
	,CEILING(ctc.Distance / cte0.duration * 60)  AS SpeedRounded
	FROM CTE0
	LEFT JOIN  WCG_Stage.man.CameraToCamera ctc ON CTE0.CameraToCamera = ctc.FromToCamera
	WHERE Route = PreviousRoute AND RouteSequence > PreviousRouteSequence
)

/* Write to Fact Table */
INSERT INTO WCG_DW.dbo.FactSpeedProfiles
(SightingDateKey, CameraKey, VehicleTypeKey, SpeedProfileBucketKey, AverageSpeed, MaximumSpeed, MinimumSpeed, VehicleCount, InsertAuditKey, UpdateAuditKey)

SELECT 
	 SightingDateKey					AS [SightingDateKey]
	,ISNULL(CameraKey,-1)				AS [CameraKey]
	,ISNULL(VehicleTypeKey,-1)			AS [VehicleTypeKey]
	,ISNULL(SpeedProfileBucketKey,-1)	AS [SpeedProfileBucketKey]					
	,CAST(AVG(SpeedRounded) AS INT)  	AS [AverageSpeed]
	,MAX(SpeedRounded)					AS [MaximumSpeed]
	,MIN(SpeedRounded)					AS [MinimumSpeed]
	,COUNT(1)							AS [VehicleCount]
	,@AuditKey							AS [InsertAuditKey]
	,@AuditKey							AS [UpdateAuditKey]
FROM CTE1
LEFT JOIN WCG_DW.dbo.DimSpeedProfileBucket s WITH (NOLOCK) ON CTE1.SpeedRounded BETWEEN s.FromSpeed AND s.ToSpeed
GROUP BY 
	 SightingDateKey
	,CameraKey
	,VehicleTypeKey
	,SpeedProfileBucketKey

SET @PreviousSightingDateKey = @LatestSightingDateKey






