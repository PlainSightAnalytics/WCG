

CREATE VIEW [itis].[transformDimShiftTime] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-05-2018
-- Reason				:	Transform view for ShiftTime
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

WITH ConvertedCTE AS (
SELECT
	id
	,CAST(
		CASE
			WHEN ISDATE(start_time) = 0 THEN '00:00:00'
			ELSE start_time
		END AS DATETIME) AS start_time
	,CAST(
		CASE
			WHEN end_time = '24:00' THEN '1900-01-02 00:00:00'
			WHEN ISDATE(end_time) = 0 THEN '00:00:00'
			ELSE 
				CASE
					WHEN CAST(start_time AS DATETIME) > CAST(end_time AS DATETIME) THEN DATEADD(d,1,end_time)
					ELSE end_time
				END
		END AS DATETIME) AS end_time
FROM WCG_Stage.itis.shift_time
)

,DurationCTE AS (
	SELECT 
		[id]									AS ShiftTimeID
		,DATEDIFF(MINUTE,start_time,end_time)	AS DurationMinutes
 	FROM ConvertedCTE
)

SELECT
	 CAST(ISNULL(cte.DurationMinutes,0) AS NUMERIC(11,2))/60.0	AS DurationHours
	,CAST(
		CASE
			WHEN ISDATE(s.[end_time]) = 0 THEN '00:00'
			ELSE s.[end_time]
		END AS TIME)											AS EndTime
	,CAST(s.[off_duty_display] AS VARCHAR(3))					AS IsOffDuty
	,CAST(s.[display] AS VARCHAR(30))							AS ShiftTime
	,s.id														AS ShiftTimeGUID
	,CAST(s.[index] AS INT)										AS ShiftTimeSort
	,CAST(
		CASE
			WHEN ISDATE(s.[start_time]) = 0 THEN '00:00'
			ELSE s.[start_time]
		END AS TIME)											AS StartTime
	,CAST(t.display AS VARCHAR(50))								AS TrafficCentre
FROM [WCG_Stage].[itis].[shift_time] s WITH (NOLOCK)
LEFT JOIN DurationCTE cte ON cte.ShiftTimeID = s.[id]
LEFT JOIN WCG_Stage.itis.traffic_centre t WITH (NOLOCK) ON s.traffic_centre_id = t.id













