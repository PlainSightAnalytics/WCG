


CREATE VIEW [itis].[transformFactShiftOutcomes] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14-10-2018
-- Reason				:	Transform view for Fact
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
----------------------------------------------------------------------------------------------------------------------------------------

WITH CriticalOutcomeCTE AS (
SELECT 
	id	
	,shift_statistic_id	
	,outcome_type_display	
	,outcome_type_key	
	,[order]	
	,[description]	
	,updated_at	
	,system_populated_outcome_display	
	,started_filling_in_display	
	,VehicleCount	
	,VehicleType
	,DeltaLogKey
FROM (
		SELECT 
			id
			,shift_statistic_id
			,outcome_type_display
			,outcome_type_key
			,[order]
			,[description]
			,updated_at
			,system_populated_outcome_display
			,started_filling_in_display
			,bus_stopped
			,hmv_stopped
			,ldv_stopped
			,lmv_stopped
			,midibus_stopped
			,minibus_stopped
			,motorcycle_stopped
			,mpv_stopped
			,other_stopped
			,DeltaLogKey
FROM itis.critical_outcome WITH (NOLOCK)) p  
UNPIVOT  
   (VehicleCount FOR VehicleType IN   
      (bus_stopped, hmv_stopped, ldv_stopped, lmv_stopped, midibus_stopped, minibus_stopped, motorcycle_stopped, mpv_stopped, other_stopped)  
)AS unpvt
)

,ShiftStatisticCTE AS (
SELECT
	id
	,shift_id
	,traffic_centre_id
	,inspector_id
	,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS RowSequence
FROM itis.shift_statistic WITH (NOLOCK)
)

,ShiftCTE AS (
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
	,user_id															AS user_id
	,ROW_NUMBER() OVER (PARTITION BY s.id ORDER BY s.updated_at DESC)	AS RowSequence
FROM itis.shift s WITH (NOLOCK)
LEFT JOIN itis.shift_time t WITH (NOLOCK) ON s.shift_time_id = t.id
LEFT JOIN itis.roster r WITH (NOLOCK) on s.roster_id = r.id
LEFT JOIN itis.roster_week rw WITH (NOLOCK) ON r.roster_week_id = rw.id
)

SELECT
	 CAST(UPPER(REPLACE(VehicleType,'_stopped','')) AS VARCHAR(30))				AS VehicleType
	,CAST(o.[description] AS VARCHAR(50))										AS CriticalOutcomeMetric	
	,CAST(o.[order] AS VARCHAR(10))												AS CriticalOutcomeMetricCode
	,CAST(o.outcome_type_display AS VARCHAR(10))								AS CriticalOutcomeType
	,CAST(o.outcome_type_key AS VARCHAR(10))									AS CriticalOutcomeTypeCode	
	,CAST(ISNULL(o.system_populated_outcome_display,'No') AS VARCHAR(3))		AS IsSystemPopulated
	,CAST(ISNULL(o.started_filling_in_display,'No') AS VARCHAR(3))				AS IsStartedFillingIn
	,CAST(
		CASE
			WHEN s.start_time < '06:00' 
				THEN DATEADD(d,-1,s.ShiftDate)
			ELSE ShiftDate
		END AS DATE)															AS OperationsDate
	,s.ShiftDate																AS ShiftDate
	,s.id																		AS ShiftID
	,ISNULL(
		ss.traffic_centre_id
		,u.traffic_centre_id)													AS TrafficCentreID
	,o.id																		AS UniqueId
	,ss.inspector_id															AS UserID
	,o.VehicleCount																AS VehicleCount
	,o.DeltaLogKey																AS DeltaLogKey			
FROM CriticalOutcomeCTE o	
LEFT JOIN ShiftStatisticCTE ss ON o.shift_statistic_id = ss.id AND ss.RowSequence = 1
LEFT JOIN ShiftCTE s ON ss.shift_id = s.id AND s.RowSequence = 1	
LEFT JOIN itis.[user] u WITH (NOLOCK) ON s.user_Id = u.id
LEFT JOIN itis.[traffic_centre] utc WITH (NOLOCK) ON u.traffic_centre_id = utc.id

