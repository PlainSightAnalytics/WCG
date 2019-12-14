

CREATE VIEW [model].[_Device History] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   19-11-2019
-- Reason               :   Semantic View for dbo.FactDeviceHistory (with Duration)
------------------------------------------------------------------------------------------
-- Modified By          :	
-- Modified On          :	
-- Reason               :	
------------------------------------------------------------------------------------------

WITH CTE AS (
SELECT
	 f.DeviceEventKey
	,f.DeviceKey
	,f.EventDateKey
	,f.EventTimeKey
	,f.GeoLocationKey
	,f.OperationKey
	,f.ShiftKey
	,f.TrafficCentreKey
	,f.TrafficControlEventKey
	,f.UserKey
	,f.EventDateTime
	,f.EventStatus
	,f.EventValue
	,f.DeltaLogKey
	,d1.EventType
	,ROW_NUMBER() OVER (PARTITION BY DeviceKey ORDER BY EventDateTime) AS RowSequence
	,LAG(EventDateTime) OVER (PARTITION BY DeviceKey ORDER BY EventDateTime) AS PreviousEventDateTime
FROM WCG_DW.dbo.FactDeviceHistory f
LEFT JOIN WCG_DW.dbo.DimDeviceEvent d1 ON f.DeviceEventKey = d1.DeviceEventKey
where f.DeviceEventKey <> -1
)

SELECT
	 DeviceEventKey
	,DeviceKey
	,EventDateKey
	,EventTimeKey
	,GeoLocationKey
	,OperationKey
	,ShiftKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UserKey
	,EventDateTime
	,EventStatus
	,EventValue
	,DeltaLogKey
	,CASE
		WHEN RowSequence = 1 OR EventType = 'Login' OR DATEDIFF(Hour,PreviousEventDateTime,EventDateTime) > 4 THEN 0
		ELSE DATEDIFF(SECOND,PreviousEventDateTime,EventDateTime) 
	END AS DurationSeconds
FROM CTE