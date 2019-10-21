





CREATE VIEW [itis].[transformFactShiftTimes] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	21-10-2018
-- Reason				:	Transform view for FactPlannedShifts
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	06-04-2019
-- Reason				:	Fixed Date cast error on column WeekStartDate on RosterCTE 
--							Previous Definition - CAST(substring(display,1,10)) as Date)
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
----------------------------------------------------------------------------------------------------------------------------------------

WITH ShiftTimeCTE AS (
SELECT
	id,
	traffic_centre_id,
	CAST(
		CASE
			WHEN ISDATE(start_time) = 0 THEN '00:00:00'
			ELSE start_time
		END AS DATETIME) AS start_time,
	CAST(
		CASE
			WHEN end_time = '24:00' THEN '1900-01-02 00:00:00'
			WHEN ISDATE(end_time) = 0 THEN '00:00:00'
			ELSE 
				CASE
					WHEN CAST(start_time AS DATETIME) > CAST(end_time AS DATETIME) THEN DATEADD(d,1,end_time)
					ELSE end_time
				END
		END AS DATETIME) AS end_time,
	ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS RowNumber
FROM itis.shift_time
)

,ShiftWeekCTE AS (
SELECT
	id,
	roster_id,
	user_id,
	ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS RowNumber
FROM itis.shift_week
)

,RosterCTE AS (
SELECT
	 id
	,CAST(ISNULL(monday_date,substring(display,1,10)) as Date) AS WeekStartDate
	,traffic_centre_id
	,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS RowNumber
FROM itis.roster
)

,ShiftTimesCTE AS (
SELECT 
	CAST(
		DATEDIFF(MINUTE,st.start_time,st.end_time) / 60.00 
		AS NUMERIC(5,2))										AS [DurationHours]
    ,CAST(ISNULL(s.acknowledged_display,'No') AS VARCHAR(3))	AS [IsAcknowledged]
	,CAST(ISNULL(s.archived_display,'No') AS VARCHAR(3))		AS [IsArchived]
	,CAST(ISNULL(s.deleted_display,'No') AS VARCHAR(3))			AS [IsDeleted]
	,CASE
		WHEN user_shift_key = 'true' THEN 'Yes'
		ELSE 'No'
	END															AS [IsUserShift]
	,ISNULL(s.roster_id,sw.roster_id)							AS [RosterGUID]
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
		sr.WeekStartDate)) AS DATE)								AS [ShiftDate]
	,s.id														AS [ShiftGUID]
	,shift_time_id												AS [ShiftTimeGUID]
	,shift_week_id												AS [ShiftWeekGUID]
	,COALESCE(
		st.traffic_centre_id										
		,sr.traffic_centre_id										
		,swr.traffic_centre_id)									AS [TrafficCentreGUID]
	,ISNULL(s.user_id,sw.user_id)								AS [UserGUID]
	,st.start_time												AS [start_time]
	,s.DeltaLogKey												AS [DeltaLogKey]
FROM WCG_Stage.itis.[shift] s WITH (NOLOCK)
LEFT JOIN ShiftTimeCTE st ON s.shift_time_id = st.id AND st.RowNumber = 1
LEFT JOIN ShiftWeekCTE sw on s.shift_week_id = sw.id AND sw.RowNumber = 1
LEFT JOIN RosterCTE sr on s.roster_id = sr.id AND sr.RowNumber = 1
LEFT JOIN RosterCTE swr on sw.roster_id = swr.id AND swr.RowNumber = 1
)

SELECT
	 [DurationHours]											AS [DurationHours]
	,[IsAcknowledged]											AS [IsAcknowledged]
	,[IsArchived]												AS [IsArchived]
	,[IsDeleted]												AS [IsDeleted]
	,[IsUserShift]												AS [IsUserShift]
	,[RosterGUID]												AS [RosterGUID]
	,[ShiftDate]												AS [ShiftDate]
	,CAST(
		CASE
			WHEN start_time < '06:00' 
				THEN DATEADD(d,-1,ShiftDate)
			ELSE ShiftDate
		END AS DATE)											AS [OperationsDate]
	,[ShiftGUID]												AS [ShiftGUID]
	,[ShiftTimeGUID]											AS [ShiftTimeGUID]
	,[ShiftWeekGUID]											AS [ShiftWeekGUID]
	,[TrafficCentreGUID]										AS [TrafficCentreGUID]
	,[UserGUID]													AS [UserGUID]
	,[DeltaLogKey]												AS [DeltaLogKey]
FROM ShiftTimesCTE

