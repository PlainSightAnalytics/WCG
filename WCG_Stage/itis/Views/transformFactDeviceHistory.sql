



CREATE VIEW [itis].[transformFactDeviceHistory] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	15-11-2019
-- Reason				:	Transform view for FactDeviceHistory from itis.last_known_location
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
----------------------------------------------------------------------------------------------------------------------------------------

--WITH OperationCTE AS (
--SELECT
--	 id																		AS OperationID
--	,CAST(
--		CAST(actual_operation_start_time AS DATETIMEOFFSET) 
--			AT TIME ZONE 'South Africa Standard Time' 
--		AS DATETIME)														AS actual_operation_start_time
--	,CAST(
--		CAST(actual_operation_stop_time AS DATETIMEOFFSET) 
--			AT TIME ZONE 'South Africa Standard Time' 
--		AS DATETIME)														AS actual_operation_stop_time
--	,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC)			AS RowSequence
--FROM itis.[operation]
--WHERE 	
--	actual_operation_start_time IS NOT NULL
--	AND actual_operation_stop_time IS NOT NULL

--)

--,OperationAssignmentCTE AS (
--SELECT
--	 a.user_id																AS UserID
--	,a.operation_id															AS OperationID
--	,c.actual_operation_start_time											AS OperationStartDateTime
--	,c.actual_operation_stop_time											AS OperationStopDateTime
--	,ROW_NUMBER() OVER (PARTITION BY a.user_id, a.operation_id ORDER BY a.updated_at DESC) AS RowSequence
--FROM WCG_Stage.itis.[officials_involved_in_operation] a WITH (NOLOCK)
--INNER JOIN OperationCTE c ON a.operation_id = c.OperationID 
--WHERE 
--	a.user_id IS NOT NULL
--AND c.RowSequence = 1
--)

--,ShiftCTE AS (
--SELECT 
--	 i.user_id																AS UserID
--	,i.id																	AS ShiftID
--	,CAST(s.ShiftDate AS DATETIME) + CAST(s.StartTime AS DATETIME)			AS ShiftStartDateTime
--	,CAST(s.ShiftDate AS DATETIME) + CAST(s.EndTime AS DATETIME)			AS ShiftEndDateTime
--	,ROW_NUMBER() OVER (
--					PARTITION BY 
--						i.user_id, 
--						i.id 
--					ORDER BY s.ShiftDate, s.EndTime)						AS RowSequence
--FROM WCG_Stage.itis.shift i
--LEFT JOIN WCG_Stage.itis.transformDimShift s on i.id = s.shiftID
--WHERE 
--	s.IsOffDuty = 'No'
--AND i.user_id IS NOT NULL
--)

WITH OperationAssignmentDWCTE AS (
SELECT
	 d2.UserID																AS UserID
	,d1.OperationID															AS OperationID
	,d1.ActualStartTime														AS OperationStartDateTime
	,d1.ActualStopTime														AS OperationStopDateTime
FROM WCG_DW.dbo.FactOperationAssignments f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimOperation		d1 WITH (NOLOCK) ON f.OperationKey = d1.OperationKey
LEFT JOIN WCG_DW.dbo.DimUser			d2 WITH (NOLOCK) ON f.UserKey = d2.UserKey
WHERE 
	f.OperationKey <> -1
AND f.UserKey <> -1
)

,ShiftDWCTE AS (
SELECT 
	 d2.UserID																AS UserID
	,d1.ShiftID																AS ShiftID
	,CAST(d1.ShiftDate AS DATETIME) + CAST(d1.StartTime	AS DATETIME)		AS ShiftStartDateTime
	,CAST(d1.ShiftDate AS DATETIME) + CAST(d1.EndTime AS DATETIME)			AS ShiftEndDateTime
FROM WCG_DW.dbo.FactShiftTimes f	WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimShift d1	WITH (NOLOCK) ON f.ShiftKey = d1.ShiftKey
LEFT JOIN WCG_DW.dbo.DimUser d2		WITH (NOLOCK) ON f.UserKey = d2.UserKey
WHERE 
	d1.IsOffDuty = 'No'
AND f.UserKey <> -1
AND f.ShiftKey <> -1
)

,LastKnownLocationCTE AS (
SELECT
	device_id																AS DeviceID
	,CAST(
		CAST(user_event_date AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATE)															AS EventDate
	,CAST(
		CAST(user_event_date AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)														AS EventDateTime
	,ISNULL(CAST(user_event_source AS VARCHAR(50)),'Unknown')				AS EventSource
	,CAST(status_display AS VARCHAR(10))									AS EventStatus
	,ISNULL(CAST(user_event_subtype AS VARCHAR(50)),'Unknown')				AS EventSubType
	,CAST(
		SUBSTRING(
			CONVERT(
				VARCHAR(20),
				CAST(user_event_date AS DATETIMEOFFSET)	
				AT TIME ZONE 'South Africa Standard Time',
				113
			),13,5
		) AS TIME)															AS EventTime
	,ISNULL(CAST(user_event_type AS VARCHAR(50)),'Unknown')					AS EventType
	,CAST(user_event_information AS VARCHAR(100))							AS EventValue
	,CAST(latitude AS NUMERIC(11,5))										AS LatitudeRange
	,CAST(longitude AS NUMERIC(11,5))										AS LongitudeRange
	,traffic_centre_id														AS TrafficCentreID
	,user_event_id															AS TrafficControlEventGUID
	,id																		AS UniqueID
	,[user_id]																AS UserID
	,l.updated_at															AS UpdateDateTime
	,l.DeltaLogKey															AS DeltaLogKey
FROM itis.transformLastKnownLocation l

)

,MainCTE AS (
SELECT 
	 l.*
	,o.OperationID															AS OperationID
	,s.ShiftID																AS ShiftID
	,ROW_NUMBER() OVER (
					PARTITION BY l.UniqueId 
					ORDER BY UpdateDateTime DESC)							AS RowSequence
from LastKnownLocationCTE l
LEFT JOIN OperationAssignmentDWCTE o 
	ON l.UserID = o.UserID 
	AND l.EventDateTime BETWEEN o.OperationStartDateTime AND o.OperationStopDateTime 
LEFT JOIN ShiftDWCTE s 
	ON l.UserID = s.UserID 
	AND EventDateTime BETWEEN s.ShiftStartDateTime AND s.ShiftEndDateTime 

)

SELECT 
	 DeviceID
	,EventDate
	,EventDateTime
	,EventSource
	,EventStatus
	,EventSubType
	,EventTime
	,EventType
	,EventValue
	,LatitudeRange
	,LongitudeRange
	,OperationID
	,ShiftID
	,TrafficCentreID
	,TrafficControlEventGUID
	,UniqueID
	,UserID
	,DeltaLogKey
FROM MainCTE
WHERE 
	RowSequence = 1