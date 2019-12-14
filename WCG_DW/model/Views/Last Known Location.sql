

CREATE VIEW [model].[Last Known Location]  AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   2019-03-23
-- Reason               :   Transform view for Last Known Location 
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified ON          :	18-11-2019
-- Reason               :	Chagned stage table from last_known_location to last_known_location_current
------------------------------------------------------------------------------------------


WITH LastKnownLocationCTE AS (
SELECT 
	 id
	,device_id
	,device_name
	,device_number
	,latitude
	,longitude
	,traffic_centre_id
	,user_event_date AS EventDateTime
	,CONCAT(user_name, ' ', user_surname) AS Officer
	,user_id
	,COUNT(1) OVER (PARTITION BY device_id) AS EventCount
	,ROW_NUMBER() OVER (PARTITION BY device_id ORDER BY user_event_date DESC) AS RowSequence
FROM WCG_Stage.itis.last_known_location_current l WITH (NOLOCK)
WHERE user_event_date <= GETUTCDATE()
)

,LatestShiftCTE AS (
SELECT 
	i.user_id
	,i.id AS ShiftID
	,CAST(s.ShiftDate AS DATETIME) + CAST(s.StartTime AS DATETIME) AS ShiftStartDateTime
	,CAST(s.ShiftDate AS DATETIME) + CAST(s.EndTime AS DATETIME) AS ShiftEndDateTime
	,ROW_NUMBER() OVER (PARTITION BY i.user_id ORDER BY s.ShiftDate, s.EndTime) AS RowSequence
FROM WCG_Stage.itis.shift i
LEFT JOIN WCG_Stage.itis.transformDimShift s on i.id = s.shiftID
WHERE GETDATE() BETWEEN CAST(s.ShiftDate AS DATETIME) + CAST(s.StartTime AS DATETIME) AND CAST(s.ShiftDate AS DATETIME) + CAST(s.EndTime AS DATETIME)
AND s.IsOffDuty = 'No'
AND i.user_id IS NOT NULL
)

,DeviceCTE AS (
SELECT
	 d.id														AS device_id
	,CONCAT(d.name, ' ', d.number)								AS device
	,d.last_known_location_latitude								AS latitude
	,d.last_known_location_longitude							AS longitude
	,t.id														AS traffic_centre_id
	,ISNULL(last_known_location_timestamp,d.updated_at)			AS LastKnownLocationDateTime
	,CONCAT(u.name, ' ', u.surname)								AS Officer
	,d.current_user_id											AS current_user_id	
FROM WCG_Stage.itis.device d WITH (NOLOCK)
LEFT JOIN WCG_Stage.itis.traffic_centre t WITH (NOLOCK) ON d.traffic_centre_id = t.id
LEFT JOIN WCG_Stage.itis.[user] u WITH (NOLOCK) ON d.current_user_id = u.id
)

,MainCTE AS (
SELECT 
 d.device_id											AS  DeviceId
,s.ShiftID												AS	ShiftId
,ISNULL(l.user_id,d.current_user_id)					AS	UserId
,d.device												AS	Device
,CAST(ISNULL(l.latitude,d.latitude) AS NUMERIC(19,2))	AS	Latitude
,CAST(ISNULL(l.longitude,d.longitude) AS NUMERIC(19,2))	AS	Longitude
,ISNULL(l.traffic_centre_id,d.traffic_centre_id)		AS	TrafficCentreID
,ISNULL(l.officer,d.Officer)							AS	Officer	
,CAST(
	ISNULL(l.EventDateTime,d.LastKnownLocationDateTime) 
	AS DATETIME)										AS	LastKnownLocationDate
,d.LastKnownLocationDateTime							AS	DeviceLastUsedDate
,s.ShiftStartDateTime									AS	LastShiftStartTime
,s.ShiftEndDateTime										AS	LastShiftEndTime
,CASE
	WHEN s.user_id IS NULL THEN 'No'
	ELSE 'Yes'
END														AS  IsOnShift
,CASE
	WHEN l.device_id IS NULL THEN 'No'
	ELSE 'Yes'
END														AS HasRecentEvents
,l.EventDateTime
,DATEDIFF(MINUTE,l.EventDateTime,GETUTCDATE())			AS DurationSinceLastActivity
,l.EventCount											AS EventCount
FROM DeviceCTE d
LEFT JOIN LastKnownLocationCTE l ON d.device_id = l.device_id AND l.RowSequence = 1
LEFT JOIN LatestShiftCTE s ON d.current_user_id = s.user_id AND l.EventDateTime BETWEEN s.ShiftStartDateTime AND s.ShiftEndDateTime AND s.RowSequence = 1
)

SELECT 
	 m.DeviceId														AS DeviceId
	,m.UserId														AS UserId
	,m.ShiftId														AS ShiftId
	,CAST(m.Device AS VARCHAR(50))									AS Device
	,Latitude														AS Latitude
	,Longitude														AS Longitude
	,CAST(t.TrafficCentre AS VARCHAR(50))							AS TrafficCentre
	,CAST(m.Officer AS VARCHAR(100))								AS Officer										
	,DATEADD(HOUR,2,LastKnownLocationDate)							AS LastKnownLocationDate
	,DATEADD(HOUR,2,DeviceLastUsedDate)								AS DeviceLastUsedDate
	,LastShiftStartTime												AS LastShiftStartTime
	,LastShiftEndTime												AS LastShiftEndTime
	,DurationSinceLastActivity										AS DurationSinceLastActivity
	,CASE
		WHEN Latitude IS NULL OR Longitude IS NULL THEN 'No'
		ElSE 'Yes'
	END																AS HasLocation
	,CASE
		WHEN LastKnownLocationDate IS NULL THEN 'No'
		ELSE 'Yes'
	END																AS HasEvents
	,CASE
		WHEN TrafficCentre = 'Mobile' THEN 'Black'
		WHEN m.Officer = ' ' THEN 'Grey'
		WHEN HasRecentEvents = 'No' THEN 'Cyan'
		WHEN DurationSinceLastActivity <= 10 THEN 'Green'
		WHEN DurationSinceLastActivity BETWEEN 11 AND 30 THEN 'Amber'
		WHEN DurationSinceLastActivity > 30 AND IsOnShift = 'Yes' THEN 'Red'
		WHEN DurationSinceLastActivity > 30 AND IsOnShift = 'No' THEN 'Blue'
	END																AS Status
	,ISNULL(d.DeviceKey,-1)											AS DeviceKey
	,ISNULL(t.TrafficCentreKey,-1)									AS TrafficCentreKey
	,ISNULL(u.UserKey,-1)											AS UserKey
	,ISNULL(s.ShiftKey,-1)											AS ShiftKey
	,FORMAT(DATEADD(HOUR,2,LastKnownLocationDate),'yyyyMMdd')		AS LastKnownLocationDateKey
	,FORMAT(DATEADD(HOUR,2,LastKnownLocationDate),'hhmm')			AS LastKnownLocationTimeKey
	,ISNULL(EventCount,0)											AS EventCountLast48Hours
FROM MainCTE m
LEFT JOIN WCG_DW.dbo.DimDevice d WITH (NOLOCK) ON m.DeviceId = d.DeviceID
LEFT JOIN WCG_DW.dbo.DimTrafficCentre t WITH (NOLOCK) ON m.TrafficCentreID = t.TrafficCentreID
LEFT JOIN WCG_DW.dbo.DimUser u WITH (NOLOCK) ON m.UserId = u.UserID
LEFT JOIN WCG_DW.dbo.DimShift s WITH (NOLOCK) ON s.ShiftID = m.ShiftId
