CREATE VIEW [itis].[transformDimShift] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	21-10-2018
-- Reason				:	Transform view for DimShift
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 CAST(ISNULL(st.DurationHours,0) AS NUMERIC(5,2))					AS DurationHours
	,st.EndTime															AS EndTime
	,ISNULL(st.IsOffDuty,'Yes')											AS IsOffDuty
	,CAST(CASE
		WHEN user_shift_key = 'true' THEN 'Yes'
		ELSE 'No'
	END AS VARCHAR(3))													AS IsUserShift
	,CAST(ISNULL(u.[User],'Unknown') AS VARCHAR(50))					AS Officer						
	,CAST(ISNULL(r.RosterGroup,'Unknown') AS VARCHAR(50))				AS RosterGroup
	,CAST(ISNULL(r.RosterGroupPPI,'Unknown') AS VARCHAR(100))			AS RosterGroupPPI
	,CAST(ISNULL(r.RosterGroupReportsTo,'Unknown')  AS VARCHAR(100))	AS RosterGroupReportsTo
	,CAST(ISNULL(r.RosterGroupSPI,'Unknown')  AS VARCHAR(100))			AS RosterGroupSPI
	,CAST(ISNULL(r.RosterStatus,'Unknown') AS VARCHAR(50))				AS RosterStatus
	,ISNULL(w.RosterWeek,'Unknown')										AS RosterWeek
	,CAST(ISNULL(s.display,'Unknown') AS VARCHAR(100))					AS Shift
	,CAST(
		ISNULL(s.date,
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
		w.WeekStartDate)) AS DATE)										AS [ShiftDate]
	,s.id																AS ShiftID
	,ISNULL(t.ShiftTime,'Unknown')										AS ShiftTime
	,ISNULL(t.ShiftTimeSort,0)											AS ShiftTimeSort
	,st.StartTime														AS StartTime
	,ISNULL(w.UserRole,'Unknown')										AS UserRole
	,CAST(ISNULL(s.week_day_display,'') AS VARCHAR(10))					AS WeekDay
	,w.WeekEndDate														AS WeekEndDate
	,w.WeekStartDate													AS WeekStartDate
	,s.DeltaLogKey														AS DeltaLogKey
FROM WCG_Stage.itis.[shift] s WITH (NOLOCK)
LEFT JOIN WCG_Stage.itis.transformDimShiftTime st ON s.shift_time_id = st.ShiftTimeGUID
LEFT JOIN WCG_Stage.itis.transformDimUser u WITH (NOLOCK) ON s.user_id = u.UserID
LEFT JOIN WCG_Stage.itis.transformDimRoster r WITH (NOLOCK) ON s.roster_id = r.RosterGUID
LEFT JOIN WCG_Stage.itis.transformDimShiftWeek w WITH (NOLOCK) ON s.shift_week_id = w.ShiftWeekGUID AND w.RowSequence = 1
LEFT JOIN WCG_Stage.itis.transformDimShiftTime t WITH (NOLOCK) ON s.shift_time_id = t.ShiftTimeGUID