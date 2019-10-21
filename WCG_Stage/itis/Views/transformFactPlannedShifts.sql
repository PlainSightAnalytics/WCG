

CREATE VIEW [itis].[transformFactPlannedShifts] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14-05-2018
-- Reason				:	Transform view for FactPlannedShifts
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	25-08-2018
-- Reason				:	Changes to joins to reduce nulls
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	06-04-2019
-- Reason				:	Fixed Date cast error on column WeekStartDate on RosterCTE 
--							Previous Definition - CAST(substring(display,1,10)) as Date)
--------------------------------------------------------------------------------------------------------------------------------------

WITH ShiftTimeCTE AS (
SELECT
	id,
	traffic_centre_id,
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

SELECT 
     CAST(ISNULL(s.acknowledged_display,'No') AS VARCHAR(3))	AS [IsAcknowledged]
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
	,s.date
	,sr.WeekStartDate
	,s.id														AS [ShiftGUID]
	,shift_time_id												AS [ShiftTimeGUID]
	,shift_week_id												AS [ShiftWeekGUID]
	,COALESCE(
		st.traffic_centre_id										
		,sr.traffic_centre_id										
		,swr.traffic_centre_id)									AS [TrafficCentreGUID]
	,ISNULL(s.user_id,sw.user_id)								AS [UserGUID]
	,s.DeltaLogKey
FROM WCG_Stage.itis.[shift] s WITH (NOLOCK)
LEFT JOIN ShiftTimeCTE st ON s.shift_time_id = st.id AND st.RowNumber = 1
LEFT JOIN ShiftWeekCTE sw on s.shift_week_id = sw.id AND sw.RowNumber = 1
LEFT JOIN RosterCTE sr on s.roster_id = sr.id AND sr.RowNumber = 1
LEFT JOIN RosterCTE swr on sw.roster_id = swr.id AND swr.RowNumber = 1
--WHERE Deltalogkey = 35766

