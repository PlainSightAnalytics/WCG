









CREATE VIEW [itis].[transformFactShiftActivities] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-10-2018
-- Reason				:	Transform view for FactShiftActivities
----------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
----------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	12-12-2019
-- Reason				:	Fixed conversion issues with start and end time (time field contains text characters)
----------------------------------------------------------------------------------------------------------------------------------------


WITH ShiftCTE AS (
SELECT
	 s.id																AS id
	,s.display															AS display
	,CAST(
		ISNULL(date,
		DATEADD(
		DAY,
		CASE 
			WHEN s.week_day_key = 'Monday' THEN 0
			WHEN s.week_day_key = 'Tuesday' THEN 1
			WHEN s.week_day_key = 'Wednesday' THEN 2
			WHEN s.week_day_key = 'Thursday' THEN 3
			WHEN s.week_day_key = 'Friday' THEN 4
			WHEN s.week_day_key = 'Saturday' THEN 5
			WHEN s.week_day_key = 'Sunday' THEN 6
			ELSE 0
		END,
		rw.monday_date)) AS DATE)										AS [ShiftDate]
	,t.start_time														AS start_time
	,ROW_NUMBER() OVER (PARTITION BY s.id ORDER BY s.updated_at DESC)	AS RowSequence
FROM itis.shift s WITH (NOLOCK)
LEFT JOIN itis.shift_time t WITH (NOLOCK) ON s.shift_time_id = t.id
LEFT JOIN itis.roster r WITH (NOLOCK) on s.roster_id = r.id
LEFT JOIN itis.roster_week rw WITH (NOLOCK) ON r.roster_week_id = rw.id
)

,TimeCTE AS (
SELECT
	 CAST(a.comments AS VARCHAR(100))					AS ActivityComment
	,CASE
		--WHEN a.end_time like '%Nan%' THEN NULL
		WHEN ISDATE(a.end_time) = 0 THEN NULL
		ELSE CAST(a.end_time AS TIME)
	END													AS ActivityEndTime
	,CASE
		--WHEN a.start_time LIKE '%Nan%' THEN NULL
		WHEN ISDATE(a.start_time) = 0 THEN NULL
		ELSE CAST(a.start_time AS TIME)							
	END													AS ActivityStartTime
	,CAST(ISNULL(a.adhoc_display,'No') AS VARCHAR(3))	AS IsAdhocActivity
	,CAST(a.gps_latitude AS NUMERIC(19,2))				AS Latitude
	,CAST(a.gps_longitude AS NUMERIC(19,2))				AS Longitude
	,CAST(a.other_location AS VARCHAR(50))				AS OtherLocation
	,CAST(a.activity_type_key AS VARCHAR(10))			AS ShiftActivityCode
	,s.ShiftDate										AS ShiftDate
	,CAST(
		CASE
			WHEN s.start_time < '06:00' 
				THEN DATEADD(d,-1,s.ShiftDate)
			ELSE ShiftDate
		END AS DATE)									AS OperationsDate
	,a.shift_id											AS ShiftID
	,a.location_id										AS ShiftLocationID
	,a.task_description_id								AS ShiftTaskID
	,ISNULL(a.traffic_centre_id,u.traffic_centre_id)	AS TrafficCentreID
	,a.id												AS UniqueID
	,a.user_id											AS UserID
	,a.DeltaLogKey										AS DeltaLogKey
	,a.start
FROM itis.activity a WITH (NOLOCK)	
LEFT JOIN itis.[user] u WITH (NOLOCK) ON a.user_Id = u.id
LEFT JOIN ShiftCTE s ON a.shift_id = s.id AND s.RowSequence = 1
)

SELECT
	 ActivityComment
	,ActivityEndTime
	,ActivityStartTime
	,IsAdhocActivity
	,Latitude
	,Longitude
	,OtherLocation
	,ShiftActivityCode
	,ShiftDate
	,OperationsDate
	,ShiftID
	,ShiftLocationID
	,ShiftTaskID
	,TrafficCentreID
	,UniqueID
	,UserID
	,DeltaLogKey
	,start
	,CASE
		WHEN ActivityEndTime IS NULL OR ActivityStartTime IS NULL THEN 0.00
		WHEN ActivityStartTime < ActivityEndTime THEN DATEDIFF(HOUR,ActivityStartTime,ActivityEndTime) 
		ELSE DATEDIFF(HOUR,ActivityStartTime,DATEADD(d,1,CAST(ActivityEndTime AS DATETIME)))
	END AS DurationHours
FROM TimeCTE



