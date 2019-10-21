
--USE [WCG_Stage]
--GO

--/****** Object:  View [cle].[transformDimTrip]    Script Date: 2/18/2019 3:58:19 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO










CREATE VIEW [cle].[transformDimTripFreight]  AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   2019-02-18
-- Reason               :   Transform view for DimTrip for Freight
-- Modified By          :
-- Modified ON          :
-- Reason               :
------------------------------------------------------------------------------------------

WITH CameraCTE AS (
/* Distances between each camera on the same route */
SELECT 'RH02' AS FromCameraID,'BW02' AS ToCameraId,32.871 AS TotalDistance UNION ALL
SELECT 'AD02' AS FromCameraID,'HP02' AS ToCameraId,71.71 AS TotalDistance UNION ALL
SELECT 'AD02' AS FromCameraID,'KP02' AS ToCameraId,78.21 AS TotalDistance UNION ALL
SELECT 'RH02' AS FromCameraID,'KP02' AS ToCameraId,39.371 AS TotalDistance UNION ALL
SELECT 'AD02' AS FromCameraID,'LK02' AS ToCameraId,140.623 AS TotalDistance UNION ALL
SELECT 'RH02' AS FromCameraID,'LK02' AS ToCameraId,101.784 AS TotalDistance UNION ALL
SELECT 'AD02' AS FromCameraID,'DK02' AS ToCameraId,202.706 AS TotalDistance UNION ALL
SELECT 'RH02' AS FromCameraID,'DK02' AS ToCameraId,163.867 AS TotalDistance UNION ALL
SELECT 'AD02' AS FromCameraID,'LB02' AS ToCameraId,268.706 AS TotalDistance UNION ALL
SELECT 'RH02' AS FromCameraID,'LB02' AS ToCameraId,229.926 AS TotalDistance UNION ALL
SELECT 'AD02' AS FromCameraID,'BA02' AS ToCameraId,278.696 AS TotalDistance UNION ALL
SELECT 'RH02' AS FromCameraID,'BA02' AS ToCameraId,239.857 AS TotalDistance UNION ALL
SELECT 'AD02' AS FromCameraID,'QR02' AS ToCameraId,333.643 AS TotalDistance UNION ALL
SELECT 'RH02' AS FromCameraID,'QR02' AS ToCameraId,294.804 AS TotalDistance UNION ALL
SELECT 'AD02' AS FromCameraID,'PK02' AS ToCameraId,350.843 AS TotalDistance UNION ALL
SELECT 'RH02' AS FromCameraID,'PK02' AS ToCameraId,312.004 AS TotalDistance UNION ALL
SELECT 'BW02' AS FromCameraID,'KP02' AS ToCameraId,6.5 AS TotalDistance UNION ALL
SELECT 'HP02' AS FromCameraID,'KP02' AS ToCameraId,6.75 AS TotalDistance UNION ALL
SELECT 'BW02' AS FromCameraID,'LK02' AS ToCameraId,68.913 AS TotalDistance UNION ALL
SELECT 'HP02' AS FromCameraID,'LK02' AS ToCameraId,68.913 AS TotalDistance UNION ALL
SELECT 'BW02' AS FromCameraID,'DK02' AS ToCameraId,130.996 AS TotalDistance UNION ALL
SELECT 'HP02' AS FromCameraID,'DK02' AS ToCameraId,130.996 AS TotalDistance UNION ALL
SELECT 'BW02' AS FromCameraID,'LB02' AS ToCameraId,197.055 AS TotalDistance UNION ALL
SELECT 'HP02' AS FromCameraID,'LB02' AS ToCameraId,197.055 AS TotalDistance UNION ALL
SELECT 'BW02' AS FromCameraID,'BA02' AS ToCameraId,206.986 AS TotalDistance UNION ALL
SELECT 'HP02' AS FromCameraID,'BA02' AS ToCameraId,206.986 AS TotalDistance UNION ALL
SELECT 'BW02' AS FromCameraID,'QR02' AS ToCameraId,261.933 AS TotalDistance UNION ALL
SELECT 'HP02' AS FromCameraID,'QR02' AS ToCameraId,261.933 AS TotalDistance UNION ALL
SELECT 'BW02' AS FromCameraID,'PK02' AS ToCameraId,279.133 AS TotalDistance UNION ALL
SELECT 'HP02' AS FromCameraID,'PK02' AS ToCameraId,279.133 AS TotalDistance UNION ALL
SELECT 'KP02' AS FromCameraID,'LK02' AS ToCameraId,62.413 AS TotalDistance UNION ALL
SELECT 'KP02' AS FromCameraID,'DK02' AS ToCameraId,124.496 AS TotalDistance UNION ALL
SELECT 'KP02' AS FromCameraID,'LB02' AS ToCameraId,190.555 AS TotalDistance UNION ALL
SELECT 'KP02' AS FromCameraID,'BA02' AS ToCameraId,200.486 AS TotalDistance UNION ALL
SELECT 'KP02' AS FromCameraID,'QR02' AS ToCameraId,255.433 AS TotalDistance UNION ALL
SELECT 'KP02' AS FromCameraID,'PK02' AS ToCameraId,272.633 AS TotalDistance UNION ALL
SELECT 'LK02' AS FromCameraID,'DK02' AS ToCameraId,62.083 AS TotalDistance UNION ALL
SELECT 'LK02' AS FromCameraID,'LB02' AS ToCameraId,128.142 AS TotalDistance UNION ALL
SELECT 'LK02' AS FromCameraID,'BA02' AS ToCameraId,138.073 AS TotalDistance UNION ALL
SELECT 'LK02' AS FromCameraID,'QR02' AS ToCameraId,193.02 AS TotalDistance UNION ALL
SELECT 'LK02' AS FromCameraID,'PK02' AS ToCameraId,210.22 AS TotalDistance UNION ALL
SELECT 'DK02' AS FromCameraID,'LB02' AS ToCameraId,66.059 AS TotalDistance UNION ALL
SELECT 'DK02' AS FromCameraID,'BA02' AS ToCameraId,75.99 AS TotalDistance UNION ALL
SELECT 'DK02' AS FromCameraID,'QR02' AS ToCameraId,130.937 AS TotalDistance UNION ALL
SELECT 'DK02' AS FromCameraID,'PK02' AS ToCameraId,148.137 AS TotalDistance UNION ALL
SELECT 'LB02' AS FromCameraID,'BA02' AS ToCameraId,9.931 AS TotalDistance UNION ALL
SELECT 'LB02' AS FromCameraID,'QR02' AS ToCameraId,64.878 AS TotalDistance UNION ALL
SELECT 'LB02' AS FromCameraID,'PK02' AS ToCameraId,82.078 AS TotalDistance UNION ALL
SELECT 'BA02' AS FromCameraID,'QR02' AS ToCameraId,54.947 AS TotalDistance UNION ALL
SELECT 'BA02' AS FromCameraID,'PK02' AS ToCameraId,72.147 AS TotalDistance UNION ALL
SELECT 'QR02' AS FromCameraID,'PK02' AS ToCameraId,17.2 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'QR01' AS ToCameraId,17.2 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'BA01' AS ToCameraId,72.142 AS TotalDistance UNION ALL
SELECT 'QR01' AS FromCameraID,'BA01' AS ToCameraId,54.947 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'LB01' AS ToCameraId,82.078 AS TotalDistance UNION ALL
SELECT 'QR01' AS FromCameraID,'LB01' AS ToCameraId,64.878 AS TotalDistance UNION ALL
SELECT 'BA01' AS FromCameraID,'LB01' AS ToCameraId,9.31 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'DK01' AS ToCameraId,148.137 AS TotalDistance UNION ALL
SELECT 'QR01' AS FromCameraID,'DK01' AS ToCameraId,75.99 AS TotalDistance UNION ALL
SELECT 'BA01' AS FromCameraID,'DK01' AS ToCameraId,75.99 AS TotalDistance UNION ALL
SELECT 'LB01' AS FromCameraID,'DK01' AS ToCameraId,66.059 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'LG01' AS ToCameraId,210.22 AS TotalDistance UNION ALL
SELECT 'QR01' AS FromCameraID,'LG01' AS ToCameraId,193.02 AS TotalDistance UNION ALL
SELECT 'BA01' AS FromCameraID,'LG01' AS ToCameraId,138.073 AS TotalDistance UNION ALL
SELECT 'LB01' AS FromCameraID,'LG01' AS ToCameraId,128.142 AS TotalDistance UNION ALL
SELECT 'DK01' AS FromCameraID,'LG01' AS ToCameraId,62.083 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'KP01' AS ToCameraId,272.633 AS TotalDistance UNION ALL
SELECT 'QR01' AS FromCameraID,'KP01' AS ToCameraId,255.433 AS TotalDistance UNION ALL
SELECT 'BA01' AS FromCameraID,'KP01' AS ToCameraId,200.486 AS TotalDistance UNION ALL
SELECT 'LB01' AS FromCameraID,'KP01' AS ToCameraId,190.555 AS TotalDistance UNION ALL
SELECT 'DK01' AS FromCameraID,'KP01' AS ToCameraId,124.496 AS TotalDistance UNION ALL
SELECT 'LG01' AS FromCameraID,'KP01' AS ToCameraId,62.413 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'BW01' AS ToCameraId,279.133 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'HP01' AS ToCameraId,279.133 AS TotalDistance UNION ALL
SELECT 'QR01' AS FromCameraID,'HP01' AS ToCameraId,261.933 AS TotalDistance UNION ALL
SELECT 'QR01' AS FromCameraID,'BW01' AS ToCameraId,261.933 AS TotalDistance UNION ALL
SELECT 'BA01' AS FromCameraID,'BW01' AS ToCameraId,206.986 AS TotalDistance UNION ALL
SELECT 'BA01' AS FromCameraID,'HP01' AS ToCameraId,206.986 AS TotalDistance UNION ALL
SELECT 'LB01' AS FromCameraID,'HP01' AS ToCameraId,197.055 AS TotalDistance UNION ALL
SELECT 'LB01' AS FromCameraID,'BW01' AS ToCameraId,197.055 AS TotalDistance UNION ALL
SELECT 'DK01' AS FromCameraID,'BW01' AS ToCameraId,130.996 AS TotalDistance UNION ALL
SELECT 'DK01' AS FromCameraID,'HP01' AS ToCameraId,130.996 AS TotalDistance UNION ALL
SELECT 'LG01' AS FromCameraID,'HP01' AS ToCameraId,68.913 AS TotalDistance UNION ALL
SELECT 'LG01' AS FromCameraID,'BW01' AS ToCameraId,68.913 AS TotalDistance UNION ALL
SELECT 'KP01' AS FromCameraID,'BW01' AS ToCameraId,6.5 AS TotalDistance UNION ALL
SELECT 'KP01' AS FromCameraID,'HP01' AS ToCameraId,6.5 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'AD01' AS ToCameraId,350.843 AS TotalDistance UNION ALL
SELECT 'PK01' AS FromCameraID,'RH01' AS ToCameraId,312.004 AS TotalDistance UNION ALL
SELECT 'QR01' AS FromCameraID,'RH01' AS ToCameraId,294.804 AS TotalDistance UNION ALL
SELECT 'QR01' AS FromCameraID,'AD01' AS ToCameraId,333.643 AS TotalDistance UNION ALL
SELECT 'BA01' AS FromCameraID,'AD01' AS ToCameraId,278.696 AS TotalDistance UNION ALL
SELECT 'BA01' AS FromCameraID,'RH01' AS ToCameraId,239.857 AS TotalDistance UNION ALL
SELECT 'LB01' AS FromCameraID,'RH01' AS ToCameraId,229.926 AS TotalDistance UNION ALL
SELECT 'LB01' AS FromCameraID,'AD01' AS ToCameraId,268.765 AS TotalDistance UNION ALL
SELECT 'DK01' AS FromCameraID,'AD01' AS ToCameraId,202.706 AS TotalDistance UNION ALL
SELECT 'DK01' AS FromCameraID,'RH01' AS ToCameraId,163.867 AS TotalDistance UNION ALL
SELECT 'LG01' AS FromCameraID,'RH01' AS ToCameraId,101.784 AS TotalDistance UNION ALL
SELECT 'LG01' AS FromCameraID,'AD01' AS ToCameraId,140.623 AS TotalDistance UNION ALL
SELECT 'KP01' AS FromCameraID,'RH01' AS ToCameraId,39.371 AS TotalDistance UNION ALL
SELECT 'KP01' AS FromCameraID,'AD01' AS ToCameraId,78.21 AS TotalDistance UNION ALL
SELECT 'BW01' AS FromCameraID,'RH01' AS ToCameraId,32.871 AS TotalDistance UNION ALL
SELECT 'HP01' AS FromCameraID,'RH01' AS ToCameraId,39.621 AS TotalDistance UNION ALL
SELECT 'BW01' AS FromCameraID,'AD01' AS ToCameraId,78.066 AS TotalDistance UNION ALL
SELECT 'HP01' AS FromCameraID,'AD01' AS ToCameraId,71.71 AS TotalDistance UNION ALL
SELECT 'HK02' AS FromCameraID,'SB02' AS ToCameraId,21.898 AS TotalDistance UNION ALL
SELECT 'HK02' AS FromCameraID,'EK03' AS ToCameraId,35.734 AS TotalDistance UNION ALL
SELECT 'SB02' AS FromCameraID,'EK03' AS ToCameraId,6.918 AS TotalDistance UNION ALL
SELECT 'EK01' AS FromCameraID,'SB01' AS ToCameraId,6.98 AS TotalDistance UNION ALL
SELECT 'EK02' AS FromCameraID,'SB01' AS ToCameraId,6.98 AS TotalDistance UNION ALL
SELECT 'EK01' AS FromCameraID,'HH01' AS ToCameraId,28.811 AS TotalDistance UNION ALL
SELECT 'EK02' AS FromCameraID,'HH01' AS ToCameraId,28.811 AS TotalDistance UNION ALL
SELECT 'SB01' AS FromCameraID,'HH01' AS ToCameraId,21.893 AS TotalDistance UNION ALL
SELECT 'WK02' AS FromCameraID,'BF02' AS ToCameraId,20.178 AS TotalDistance UNION ALL
SELECT 'WK02' AS FromCameraID,'YF02' AS ToCameraId,35.203 AS TotalDistance UNION ALL
SELECT 'BF02' AS FromCameraID,'YF02' AS ToCameraId,15.025 AS TotalDistance UNION ALL
SELECT 'WK02' AS FromCameraID,'GK02' AS ToCameraId,57.398 AS TotalDistance UNION ALL
SELECT 'BF02' AS FromCameraID,'GK02' AS ToCameraId,37.22 AS TotalDistance UNION ALL
SELECT 'YF02' AS FromCameraID,'GK02' AS ToCameraId,22.195 AS TotalDistance UNION ALL
SELECT 'GK01' AS FromCameraID,'YF01' AS ToCameraId,22.195 AS TotalDistance UNION ALL
SELECT 'GK01' AS FromCameraID,'BF01' AS ToCameraId,37.22 AS TotalDistance UNION ALL
SELECT 'YF01' AS FromCameraID,'BF01' AS ToCameraId,15.025 AS TotalDistance UNION ALL
SELECT 'GK01' AS FromCameraID,'WK01' AS ToCameraId,57.398 AS TotalDistance UNION ALL
SELECT 'YF01' AS FromCameraID,'WK01' AS ToCameraId,35.203 AS TotalDistance UNION ALL
SELECT 'BF01' AS FromCameraID,'WK01' AS ToCameraId,20.178 AS TotalDistance
)

,CTE0 AS (
/* Get all sightings from fixed cameras */
SELECT
	 d4.FullDate												AS FullDate
	,d2.FullTime												AS FullTime
	,d3.RegistrationNo											AS RegistrationNo
	,d1.Route													AS Route
	,d1.TravelDirection											AS TravelDirection
	,d1.CameraLocation											AS CameraLocation
	,d1.RouteSequence											AS RouteSequence
	,d1.CameraID												AS CameraId
	,ROW_NUMBER() OVER (
					PARTITION BY d3.RegistrationNo 
					ORDER BY d4.FullDate, d2.FullTime
	)															AS TripSequence
	,CASE
		--WHEN RouteSequence = LAG(RouteSequence) OVER(PARTITION BY d3.RegistrationNo ORDER BY d4.FullDate, d2.FullTime) + 1 THEN NULL
		--WHEN d1.TravelDirection = LAG(d1.TravelDirection) OVER(PARTITION BY d3.RegistrationNo ORDER BY d4.FullDate, d2.FullTime)
		--	AND	RouteSequence > LAG(RouteSequence) OVER(PARTITION BY d3.RegistrationNo ORDER BY d4.FullDate, d2.FullTime) + 1 THEN NULL
		--WHEN d1.TravelDirection = LAG(d1.TravelDirection) OVER(PARTITION BY d3.RegistrationNo ORDER BY d4.FullDate, d2.FullTime)
		--	AND	RouteSequence = LAG(RouteSequence) OVER(PARTITION BY d3.RegistrationNo ORDER BY d4.FullDate, d2.FullTime) THEN NULL
		WHEN -- Added 2018-02-19 (Start)
			DATEDIFF(
					HOUR,
					LAG(CAST(FullDate AS DATETIME) + CAST(FullTime AS DATETIME))  OVER(PARTITION BY d3.RegistrationNo ORDER BY d4.FullDate, d2.FullTime),
					CAST(FullDate AS DATETIME) + CAST(FullTime AS DATETIME)
				) > 24
		THEN
			CONCAT(
				RegistrationNo,'-',
				Route,'-',
				CAST(f.DateKey AS VARCHAR(8)),'-',
				CAST(f.TimeKey AS VARCHAR(4))
			)
		WHEN 
			Route = LAG(Route) OVER(PARTITION BY d3.RegistrationNo ORDER BY d4.FullDate, d2.FullTime)
		AND TravelDirection = LAG(TravelDirection) OVER(PARTITION BY d3.RegistrationNo ORDER BY d4.FullDate, d2.FullTime)
		AND RouteSequence > LAG(RouteSequence) OVER(PARTITION BY d3.RegistrationNo ORDER BY d4.FullDate, d2.FullTime)
		THEN NULL -- Added 2019-02-19 (End)
		ELSE 
			CONCAT(
				RegistrationNo,'-',
				Route,'-',
				CAST(f.DateKey AS VARCHAR(8)),'-',
				CAST(f.TimeKey AS VARCHAR(4))
			)							
	END															AS TripIdentification
	,LAG(Route) OVER (
					PARTITION BY d3.RegistrationNo 
					ORDER BY d4.FullDate, d2.FullTime
	)															AS PreviousRoute
	,LEAD(Route) OVER (
					PARTITION BY d3.RegistrationNo 
					ORDER BY d4.FullDate, d2.FullTime
	)															AS NextRoute
	,LAG(CAST(FullDate AS DATETIME) + CAST(FullTime AS DATETIME)) 
		OVER (
			PARTITION BY d3.RegistrationNo 
			ORDER BY d4.FullDate, d2.FullTime
	)															AS PreviousDateTime
	,LEAD(CAST(FullDate AS DATETIME) + CAST(FullTime AS DATETIME)) 
		OVER (
			PARTITION BY d3.RegistrationNo
			ORDER BY d4.FullDate, d2.FullTime
	)															AS NextDateTime
	,CAST(FullDate AS DATETIME) + CAST(FullTime AS DATETIME)	AS CurrentDateTime
FROM WCG_DW.dbo.FactFreightTracking f WITH (NOLOCK) 
LEFT JOIN WCG_DW.dbo.DimCamera d1 WITH (NOLOCK) ON f.CameraKey = d1.CameraKey
LEFT JOIN WCG_DW.dbo.DimTime d2 WITH (NOLOCK) ON f.TimeKey = d2.TimeKey
LEFT JOIN WCG_DW.dbo.DimVehicle d3 WITH (NOLOCK) ON f.VehicleKey = d3.VehicleKey
LEFT JOIN WCG_DW.dbo.DimDate d4 WITH (NOLOCK) ON f.DateKey = d4.DateKey
WHERE 
	f.Event = 'Sighting'
AND d1.CameraLocation <> 'Mobile'
)

,CTE1 AS (
/* Determine Start and End of each trip */
	SELECT
		 FullDate
		,FullTime
		,RegistrationNo
		,Route
		,CameraLocation
		,RouteSequence
		,CameraId
		,TripIdentification
		,NextRoute
		,PreviousRoute
		,CASE
			WHEN ROW_NUMBER() OVER (Partition by RegistrationNo ORDER BY FullDate, FullTime) = 1 THEN 'Start'	-- First in Sequence - Start first route
			WHEN TripIdentification IS NOT NULL THEN 'Start'													-- Added 2019-02-19
			WHEN [Route] <> ISNULL(PreviousRoute,'') THEN 'Start'												-- Route not the same as previous rows route - start new route
			WHEN [Route] <> ISNULL(NextRoute,'') THEN 'End'														-- Route not the same as next rows route - end current route
			WHEN [Route] = NextRoute AND DATEDIFF(HOUR,CurrentDateTime,NextDateTime) > 24 THEN 'End'			-- Route is the same as next rows route but more than 24 hours have elapsed - End current route
			WHEN [Route] = PreviousRoute AND DATEDIFF(HOUR,PreviousDateTime,CurrentDateTime) > 24 THEN 'Start'	-- route is the same as previous rows route but more than 24 hours have elapsed - Start new route
		END AS StartEnd
	FROM CTE0
)

 ,CTE2 AS (
 /* Eliminate in between camera sightings */
SELECT 
	 ISNULL(TripIdentification,LAG(TripIdentification) OVER (PARTITION BY RegistrationNo ORDER BY FullDate, FullTime)) AS TripID
	,CAST(FullDate AS DateTIME) + CAST(FullTime AS DATETIME) AS TripDateTime
	,RegistrationNo
	,Route
	,CameraLocation
	,CameraId
	,RouteSequence
	,StartEnd
FROM CTE1
WHERE StartEnd IS NOT NULL
)


,CTE3 AS (
/* Determine start and end fields */
	SELECT 
		 RegistrationNo
		,Route
		,StartEnd
		,FIRST_VALUE(TripDateTime) OVER (PARTITION BY TripID ORDER BY TripDateTime) AS StartTime
		,FIRST_VALUE(TripDateTime) OVER (PARTITION BY TripID ORDER BY TripDateTime DESC) AS EndTime
		,FIRST_VALUE(cte2.RouteSequence) OVER (PARTITION BY TripID ORDER BY TripDateTime) AS StartRouteSequence
		,FIRST_VALUE(cte2.RouteSequence) OVER (PARTITION BY TripID ORDER BY TripDateTime DESC) AS EndRouteSequence
		,FIRST_VALUE(cte2.CameraLocation) OVER (PARTITION BY TripID ORDER BY TripDateTime) AS StartCamera
		,FIRST_VALUE(cte2.CameraLocation) OVER (PARTITION BY TripID ORDER BY TripDateTime DESC) AS EndCamera
		,FIRST_VALUE(cte2.CameraID) OVER (PARTITION BY TripID ORDER BY TripDateTime) AS StartCameraID
		,FIRST_VALUE(cte2.CameraID) OVER (PARTITION BY TripID ORDER BY TripDateTime DESC) AS EndCameraID
FROM CTE2
)

,CTE4 AS (
/* Deduplicate by taking only "Start" rows */
	SELECT 
		 cte3.RegistrationNo					AS RegistrationNO
		,cte3.Route								AS Route
		,cte3.StartTime							AS StartTime
		,cte3.EndTime							AS EndTime
		,StartCamera							AS StartCamera
		,EndCamera								AS EndCamera
		,c.TotalDistance						AS TotalDistance
		,EndRouteSequence - StartRouteSequence	AS SpeedSectionCount
	FROM CTE3 
	LEFT JOIN CameraCTE c ON c.FromCameraID = StartCameraID AND c.ToCameraId = EndCameraID 
	WHERE StartEnd = 'Start'
)


,CTE5 AS (
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
	FROM CTE4
)

,CTE6 AS (
/* Set Flags for Fatique, Speeding and Fast Turnaround */
	SELECT 
		 Route						AS Route
		,FromToCamera				AS FromToCamera
		,RegistrationNo				AS RegistrationNo
		,StartTime					AS StartTime
		,EndTime					AS EndTime
		,TripDuration				AS TripDuration
		,TotalDistance				AS TotalDistance
		,AverageSpeed				AS AverageSpeed
		,SpeedSectionCount			AS SpeedSectionCount
		,PreviousEndTime			AS PreviousEndTime
		,TurnaroundHours			AS TurnaroundHours
		,CASE	
			WHEN TotalDistance > 250 AND AverageSpeed > 100 THEN 'Yes'
			ELSE 'No'
		END							AS SpeedingFlag
		,CASE
			WHEN TotalDistance > 250 AND AverageSpeed BETWEEN 90 AND 100 THEN 'Yes'
			ELSE 'No'
		END							AS FatiqueFlag
		,CASE
			WHEN ISNULL(PreviousDistance,0) > 250 AND TotalDistance > 250 AND ISNULL(TurnaroundHours,0) BETWEEN 6 and 24 THEN 'Yes' 
			ELSE 'No'
		END							AS TurnaroundFlag
	FROM CTE5
)

/* Final Data */
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
	,SpeedingFlag							AS SpeedingFlag
	,FatiqueFlag							AS FatiqueFlag
	,TurnaroundFlag							AS TurnaroundFlag
FROM CTE6




