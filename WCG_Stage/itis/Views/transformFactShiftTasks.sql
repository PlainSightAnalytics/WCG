








CREATE VIEW [itis].[transformFactShiftTasks] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14-10-2018
-- Reason				:	Transform view for Fact
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
----------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	10-09-2019
-- Reason				:	Fixed Bug with start and end time caused by NAN value from Journey
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
	 CAST(ISNULL(t.adhoc_display,'No')	AS VARCHAR(3))	AS [IsAdhocTask]
	,s.ShiftDate										AS [ShiftDate]
	,CAST(
		CASE
			WHEN s.start_time < '06:00' 
				THEN DATEADD(d,-1,s.ShiftDate)
			ELSE ShiftDate
		END AS DATE)									AS [OperationsDate]
	,u.traffic_centre_id								AS [TrafficCentreID]
	,t.id												AS [UniqueId]
	,t.location_id										AS [ShiftLocationID]
	,CAST(other_location AS VARCHAR(50))				AS [OtherLocation]
	,t.shift_id											AS [ShiftID]
	,t.task_description_id								AS [ShiftTaskID]
	,CASE
		WHEN ISDATE(t.end_time) = 0 THEN NULL
		ELSE CAST(REPLACE(t.end_time,'h',':') AS TIME)
	END													AS [TaskEndTime]
	,CASE
		WHEN ISDATE(t.start_time) = 0 THEN NULL
		ELSE CAST(REPLACE(t.start_time ,'h',':')AS TIME)
	END													AS [TaskStartTime]
	,t.user_id											AS [UserID]
	,d.measure											AS [Measure]
	,d.period											AS [Period]
	,t.DeltaLogKey										AS [DeltaLOgKey]
from itis.task t WITH (NOLOCK)		
LEFT JOIN itis.[user] u WITH (NOLOCK) ON t.user_Id = u.id
LEFT JOIN itis.[task_description] d  WITH (NOLOCK) ON t.task_description_id = d.id
LEFT JOIN ShiftCTE s ON t.shift_id = s.id AND s.RowSequence = 1
)

,DurationCTE AS (
SELECT
	 [IsAdhocTask]
	,[ShiftDate]
	,[OperationsDate]
	,[TrafficCentreID]
	,[UniqueId]
	,[ShiftLocationID]
	,[OtherLocation]
	,[ShiftID]
	,[ShiftTaskID]
	,[TaskEndTime]
	,[TaskStartTime]
	,[UserID]
	,[Measure]
	,[Period]
	,[DeltaLogKey]
	,CASE
		WHEN TaskEndTime IS NULL OR TaskStartTime IS NULL THEN 0.00
		WHEN TaskStartTime < TaskEndTime THEN DATEDIFF(HOUR,TaskStartTime,TaskEndTime) 
		ELSE DATEDIFF(HOUR,TaskStartTime,DATEADD(d,1,cast(TaskEndTime AS DATETIME)))
	END AS DurationHours
FROM TimeCTE
)

SELECT
	 [IsAdhocTask]
	,[ShiftDate]
	,[OperationsDate]
	,[TrafficCentreID]
	,[UniqueId]
	,[ShiftLocationID]
	,[OtherLocation]
	,[ShiftID]
	,[ShiftTaskID]
	,[TaskEndTime]
	,[TaskStartTime]
	,[UserID]
	,[DurationHours]
	,CASE
		WHEN [Period] like '%hour%' AND Measure IS NOT NULL THEN DurationHours * Measure
		ELSE 0
	END AS TaskTarget
	,[DeltaLogKey]
FROM DurationCTE






