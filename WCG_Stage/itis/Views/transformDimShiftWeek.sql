



CREATE VIEW [itis].[transformDimShiftWeek] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-05-2018
-- Reason				:	Transform view for ShiftWeek
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	CAST(
		CASE
			WHEN w.user_week_key = 'true' THEN 'Yes'
			ELSE 'No'
		END AS VARCHAR(3))											AS IsUserWeek
	,CAST(ISNULL(r.display,'Unknown') AS VARCHAR(50))				AS RosterWeek
	,CAST(ISNULL(w.display,'Unknown') AS VARCHAR(50))				AS ShiftWeek
	,w.id															AS ShiftWeekGUID
	,CAST(ISNULL(u.display,'Unknown') AS VARCHAR(50))				AS [User]
	,CAST(ISNULL(w.user_role_display,'Unknown') AS VARCHAR(30))		AS UserRole
	,CAST(r.monday_date	AS DATE)									AS WeekEndDate
	,CAST(r.sunday_date AS DATE)									AS WeekStartDate
	,w.DeltaLogKey													AS DeltaLogKey
	,ROW_NUMBER() OVER (PARTITION BY w.id ORDER BY w.updated_at)	AS RowSequence
FROM itis.shift_week w WITH (NOLOCK)
LEFT JOIN itis.roster_week r WITH (NOLOCK) ON w.roster_week_id = r.id
LEFT JOIN itis.[user] u WITH (NOLOCK) ON w.[user_id] = u.id













