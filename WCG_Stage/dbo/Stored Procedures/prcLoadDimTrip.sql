CREATE PROCEDURE [dbo].[prcLoadDimTrip]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-04-2019
-- Reason				:	Truncates and Reloads DimTrip
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimTrip] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:	
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT

AS

/* Truncate DimTrip */
TRUNCATE TABLE WCG_DW.dbo.DimTrip

/* Insert Unknown Row */
SET IDENTITY_INSERT WCG_DW.dbo.DimTrip ON

INSERT INTO WCG_DW.dbo.DimTrip
(TripKey,Route,FromToCamera,RegistrationNo,EndTime,StartTime,TripDuration,TotalDistance,AverageSpeed,SpeedSectionCount,PreviousEndTime,TurnaroundHours,SpeedingFlag,FatiqueFlag,TurnaroundFlag)
VALUES (-1, 'Unknown', 'Unknown', 'Unknown', NULL, NULL, 0, 0, 0, 0, NULL, 0,'No', 'No', 'No')

SET IDENTITY_INSERT WCG_DW.dbo.DimTrip OFF

/* Calculate Trips */
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
 		f.SightingDateKey > 20181130
	AND f.CameraKey <> -1					
	AND c.IsMobileCamera = 'No'
	AND (
		v.VehicleCategoryCode = 'C'
	OR	v.VehicleUsageCode = '02')
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
	,CameraKey
	,VehicleTypeKey
FROM SightingsCTE s
WHERE 
	RowSequence = 1															
)

,CTE0 AS (
/* Get Previous and Next fields in the trip seqence  */
SELECT
	 s.SightingDatetime											AS SightingDateTime
	,s.RegistrationNo											AS RegistrationNo
	,Route														AS Route
	,TravelDirection											AS TravelDirection
	,CameraLocation												AS CameraLocation
	,RouteSequence												AS RouteSequence
	,SightingRecordId											AS SightingRecordId
	,CameraID													AS CameraId
	,LaneID														AS LaneId
	,ROW_NUMBER() OVER (
					PARTITION BY s.RegistrationNo 
					ORDER BY s.SightingDatetime
	)															AS TripSequence
	,LAG(Route) OVER (
					PARTITION BY s.RegistrationNo 
					ORDER BY s.SightingDatetime
	)															AS PreviousRoute
	,LEAD(Route) OVER (
					PARTITION BY s.RegistrationNo 
					ORDER BY s.SightingDatetime
	)															AS NextRoute
	,LAG(CAST(s.SightingDatetime AS DATETIME))
		OVER (
			PARTITION BY s.RegistrationNo 
			ORDER BY s.SightingDatetime
	)															AS PreviousDateTime
	,LEAD(CAST(s.SightingDatetime AS DATETIME)) 
		OVER (
			PARTITION BY s.RegistrationNo
			ORDER BY s.SightingDatetime
	)															AS NextDateTime
FROM SightingsFilteredCTE s WITH (NOLOCK) 
)

,CTE1 AS (
/* Determine Start and End of each trip */
	SELECT
		 SightingDateTime
		,RegistrationNo
		,Route
		,CameraLocation
		,RouteSequence
		,NextRoute
		,PreviousRoute
		,SightingRecordId
		,CameraId
		,LaneId
		,CASE
			WHEN 
				[Route] <> ISNULL(PreviousRoute,'') 
			OR	DATEDIFF(HOUR,SightingDateTime,PreviousDateTime) > 24
			THEN 'Start'	-- If the current route is not the same as the previous route or the previous sighting datetime was more than 24 hours ago then its the start of the trip											
			WHEN 
				[Route] <> ISNULL(NextRoute,'')
			OR	DATEDIFF(HOUR,SightingDateTime,NextDateTime) > 24
			THEN 'End'		-- If the next route is not the same as the current route or the next sighting datetime is more than 24 hours hence then its the end of the current trip	
			ELSE NULL		-- else its between the start and end 
		END AS StartEnd
	FROM CTE0
)

 ,CTE2 AS (
 /* 
	1. Eliminate in between camera sightings 
	2. Define Trip ID as the Concatenated Registration No, Route, and Sighting Date and time of the start
*/
SELECT 
	 SightingDateTime
	,RegistrationNo
	,Route
	,CameraLocation
	,RouteSequence
	,SightingRecordId
	,CameraId
	,LaneId
	,StartEnd
	,CONCAT(
		RegistrationNo,'-',Route,'-',
		FORMAT(
		CASE
		WHEN 
			StartEnd = 'END' AND LAG(StartEnd) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime) = 'Start' 
			THEN LAG(SightingDateTime) OVER (PARTITION BY RegistrationNo ORDER BY SightingDateTime)
		ELSE SightingDateTime
	END,'yyyyMMddHHmm'))	AS TripID 
FROM CTE1
WHERE StartEnd IS NOT NULL
)


,CTE3 AS (
/* Get start and end values for SightingDateTime, Route Sequence and CameraLocation */
	SELECT 
		 RegistrationNo
		,Route
		,StartEnd
		,FIRST_VALUE(SightingDateTime) OVER (PARTITION BY TripID ORDER BY SightingDateTime) AS StartTime
		,FIRST_VALUE(SightingDateTime) OVER (PARTITION BY TripID ORDER BY SightingDateTime DESC) AS EndTime
		,FIRST_VALUE(cte2.RouteSequence) OVER (PARTITION BY TripID ORDER BY SightingDateTime) AS StartRouteSequence
		,FIRST_VALUE(cte2.RouteSequence) OVER (PARTITION BY TripID ORDER BY SightingDateTime DESC) AS EndRouteSequence
		,FIRST_VALUE(cte2.CameraLocation) OVER (PARTITION BY TripID ORDER BY SightingDateTime) AS StartCamera
		,FIRST_VALUE(cte2.CameraLocation) OVER (PARTITION BY TripID ORDER BY SightingDateTime DESC) AS EndCamera
		,FIRST_VALUE(cte2.SightingRecordId) OVER (PARTITION BY TripID ORDER BY SightingDateTime) AS StartSightingRecordId
		,FIRST_VALUE(cte2.SightingRecordId) OVER (PARTITION BY TripID ORDER BY SightingDateTime DESC) AS EndSightingRecordId
		,FIRST_VALUE(cte2.CameraId) OVER (PARTITION BY TripID ORDER BY SightingDateTime) AS StartCameraId
		,FIRST_VALUE(cte2.CameraId) OVER (PARTITION BY TripID ORDER BY SightingDateTime DESC) AS EndCameraId
		,FIRST_VALUE(cte2.LaneId) OVER (PARTITION BY TripID ORDER BY SightingDateTime) AS StartLaneId
		,FIRST_VALUE(cte2.LaneId) OVER (PARTITION BY TripID ORDER BY SightingDateTime DESC) AS EndLaneId

FROM CTE2
)


,CTE4 AS (
/* Deduplicate by taking only "Start" rows and bring in the distance between the start and the end cameras */
	SELECT 
		 cte3.RegistrationNo					AS RegistrationNo
		,cte3.Route								AS Route
		,cte3.StartTime							AS StartTime
		,cte3.EndTime							AS EndTime
		,StartCamera							AS StartCamera
		,EndCamera								AS EndCamera
		,StartSightingRecordId					AS StartSightingRecordId
		,EndSightingRecordId					AS EndSightingRecordId
		,StartCameraId							AS StartCameraId
		,EndCameraId							AS EndCameraId
		,StartLaneId							AS StartLaneId
		,EndLaneId								AS EndLaneId
		,CAST(c.Distance AS NUMERIC(11,3))		AS TotalDistance
		,EndRouteSequence - StartRouteSequence	AS SpeedSectionCount
	FROM CTE3 
	LEFT JOIN WCG_Stage.man.CameraToCamera c ON c.FromToCamera = CASE WHEN StartCamera = EndCamera THEN StartCamera ELSE CONCAT(StartCamera, ' to ', EndCamera) END
	WHERE StartEnd = 'Start'
)

,CTE5 AS (
/*	1. Concatenate Camera Locations to define FromToCamera
	2. Calculate Trip Duration in Minutes (using DATEDIFF between Start time and end time
	3. Calculate Average Speed (Distance / Minutes * 60)
	4. Get Previous Trips End Time
	5. Calculate Turnaround hours (using DATEDIFF between previous trips end time and current trips start time
	6. Get the distance of the previous Trip
	7. Calculate the number of speedsections in the route
	8. Fetch the name of the last camera in the previous trip and concatenate with first camera in the current trip to get a from to name
*/
	SELECT
		 RegistrationNo						AS RegistrationNo
		,Route								AS Route
		,StartTime							AS StartTime
		,EndTime							AS EndTime
		,CASE
			WHEN StartCamera = EndCamera THEN StartCamera
			ELSE CONCAT(StartCamera,' to ', EndCamera)
		END									AS FromToCamera
		,DATEDIFF(MINUTE,StartTime,EndTime) AS TripDuration
		,TotalDistance						AS TotalDistance
		,CASE
			WHEN DATEDIFF(MINUTE,StartTime,EndTime)  = 0 
				THEN 0
			ElSE 
				TotalDistance / 
				DATEDIFF(MINUTE,StartTime,EndTime) 
				* 60
		END									AS AverageSpeed
		,LAG(EndTime) 
			OVER (
				PARTITION BY RegistrationNo 
				ORDER BY StartTime)			AS PreviousEndTime
		,DATEDIFF(
			HOUR, 
			LAG(EndTime) 
				OVER (
					PARTITION BY RegistrationNo 
					ORDER BY StartTime
				)
			, StartTime
		)									AS TurnaroundHours
		,LAG(TotalDistance) 
			OVER (
				PARTITION BY RegistrationNo 
				ORDER BY StartTime
		)									AS PreviousDistance 
		,SpeedSectionCount
		,CASE
			WHEN StartCamera = LAG(EndCamera) OVER (PARTITION BY RegistrationNo ORDER BY StartTime) THEN StartCamera
			WHEN LAG(EndCamera) OVER (PARTITION BY RegistrationNo ORDER BY StartTime) IS NULL THEN StartCamera
			ELSE CONCAT(LAG(EndCamera) OVER (PARTITION BY RegistrationNo ORDER BY StartTime), ' to ',StartCamera)
		END									AS LastCameraToStartCamera
		,StartSightingRecordId				AS StartSightingRecordId
		,EndSightingRecordId				AS EndSightingRecordId
		,StartCameraId						AS StartCameraId
		,EndCameraId						AS EndCameraId
		,StartLaneId						AS StartLaneId
		,EndLaneId							AS EndLaneId
	FROM CTE4
	WHERE SpeedSectionCount > 0
)

,CTE6 AS (
/* Get expected times and durations from end camera of previous trip to the start camera of the current trip */
	SELECT 
		 Route											AS Route
		,CTE5.FromToCamera								AS FromToCamera
		,RegistrationNo									AS RegistrationNo
		,StartTime										AS StartTime
		,EndTime										AS EndTime
		,TripDuration									AS TripDuration
		,TotalDistance									AS TotalDistance
		,AverageSpeed									AS AverageSpeed
		,SpeedSectionCount								AS SpeedSectionCount
		,PreviousEndTime								AS PreviousEndTime
		,PreviousDistance								AS PreviousDistance
		,TurnaroundHours								AS TurnaroundHours
		,LastCameraToStartCamera						AS FromToCameraPrevious
		,c.Distance										AS PreviousEndtoCurrentStartDistance
		,c.Time											AS PreviousEndtoCurrentStartExpectedDuration
		,DATEDIFF(MINUTE,PreviousEndTime, StartTime)	AS PreviousEndtoCurrentStartActualDuration
		,CASE
			WHEN  DATEDIFF(MINUTE,PreviousEndTime,StartTime)  = 0 
				THEN 0
			ElSE 
				CAST(c.Distance AS NUMERIC(11,2)) / 
				DATEDIFF(MINUTE,PreviousEndTime,StartTime) 
				* 60
		END										AS ImpliedSpeed
		,StartSightingRecordId							AS StartSightingRecordId
		,EndSightingRecordId							AS EndSightingRecordId
		,StartCameraId									AS StartCameraId
		,EndCameraId									AS EndCameraId
		,StartLaneId									AS StartLaneId
		,EndLaneId										AS EndLaneId
	FROM CTE5
	LEFT JOIN WCG_Stage.man.CameraToCamera c ON cte5.LastCameraToStartCamera = c.FromToCamera
)


,CTE7 AS (
/* Calculate flags */
SELECT 
	 Route									AS Route
	,CAST(FromToCamera AS VARCHAR(100))		AS FromToCamera
	,RegistrationNo							AS RegistrationNo
	,StartTime								AS StartTime
	,EndTime								AS EndTime
	,TripDuration							AS TripDuration
	,CAST(TotalDistance AS NUMERIC(11,3))	AS TotalDistance
	,CAST(AverageSpeed AS NUMERIC(11,6))	AS AverageSpeed
	,SpeedSectionCount						AS SpeedSectionCount
	,PreviousEndTime						AS PreviousEndTime
	,TurnaroundHours						AS TurnaroundHours
	,FromToCameraPrevious
	,PreviousEndtoCurrentStartDistance
	,PreviousEndtoCurrentStartExpectedDuration
	,PreviousEndtoCurrentStartActualDuration
	,ImpliedSpeed
	,CASE	
		WHEN TotalDistance > 250 AND AverageSpeed > 100 THEN 'Yes'
		ELSE 'No'
	END										AS SpeedingFlag
	,CASE
		WHEN TotalDistance > 250 AND AverageSpeed BETWEEN 90 AND 100 THEN 'Yes'
		ELSE 'No'
	END										AS FatiqueFlag
	,CASE
		WHEN ISNULL(PreviousDistance,0) > 250 AND TotalDistance > 250 AND ISNULL(TurnaroundHours,0) BETWEEN 6 and 24 THEN 'Yes' 
		ELSE 'No'
	END										AS TurnaroundFlag
	,CASE
		WHEN ImpliedSpeed > 120 THEN 'Yes'
		ELSE 'No'
	END										AS CameraToCameraFlag
	,StartSightingRecordId					AS StartSightingRecordId
	,EndSightingRecordId					AS EndSightingRecordId
	,StartCameraId							AS StartCameraId
	,EndCameraId							AS EndCameraId
	,StartLaneId							AS StartLaneId
	,EndLaneId								AS EndLaneId
FROM CTE6
)

/* Insert Trip Rows */
INSERT INTO WCG_DW.dbo.DimTrip
(Route,FromToCamera,RegistrationNo,EndTime,StartTime,TripDuration,TotalDistance,AverageSpeed,SpeedSectionCount,PreviousEndTime,TurnaroundHours, SpeedingFlag,FatiqueFlag,TurnaroundFlag)
SELECT
Route,FromToCamera,RegistrationNo,EndTime,StartTime,TripDuration,TotalDistance,AverageSpeed,SpeedSectionCount,PreviousEndTime,TurnaroundHours, SpeedingFlag,FatiqueFlag,TurnaroundFlag
FROM CTE7

/* Return Data 
SELECT 
	Route
	,FromToCamera
	,RegistrationNo
	,StartTime
	,EndTime
	,TripDuration
	,TotalDistance
	,AverageSpeed
	,SpeedSectionCount
	,PreviousEndTime
	,TurnaroundHours
	,SpeedingFlag
	,FatiqueFlag
	,TurnaroundFlag
FROM CTE7*/