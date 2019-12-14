

CREATE VIEW [dbo].[LoadFactDeviceHistory] 

AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	15-11-2019
-- Reason				:	Load view for FactDeviceHistory
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	ISNULL(d1.DeviceKey,-1)										AS DeviceKey
	,ISNULL(d9.DeviceEventKey,-1)								AS DeviceEventKey
	,ISNULL(d2.DateKey,-1)										AS EventDateKey
	,ISNULL(d3.TimeKey,-1)										AS EventTimeKey
	--GeoLocationKey
	,ISNULL(d4.OperationKey,-1)									AS OperationKey
	,ISNULL(d5.ShiftKey,-1)										AS ShiftKey
	,ISNULL(d6.TrafficCentreKey,-1)								AS TrafficCentreKey
	,ISNULL(d7.TrafficControlEventKey,-1)						AS TrafficControlEventKey
	,ISNULL(d8.UserKey,-1)										AS UserKey
	-- Possible Dimensions Later
	,tfm.LatitudeRange											AS Latitude
	,tfm.LongitudeRange											AS Longitude
	,tfm.EventSource											AS EventSource
	,tfm.EventSubType											AS EventSubType
	,tfm.EventType												AS EventType
	-- Degenerate Dimensions
	,tfm.EventDateTime											AS EventDateTime
	,tfm.EventStatus											AS EventStatus
	,tfm.EventValue												AS EventValue
	,tfm.UniqueID												AS UniqueID
	,ROW_NUMBER() OVER (
					PARTITION BY
					tfm.UniqueId
					ORDER BY d7.TrafficControlEventKey DESC)	AS RowSequence
	,tfm.[DeltaLogKey]											AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactDeviceHistory] tfm
LEFT JOIN WCG_DW.dbo.DimDevice					d1 ON tfm.DeviceID = d1.DeviceId
LEFT JOIN WCG_DW.dbo.DimDate					d2 ON tfm.EventDate = d2.FullDate
LEFT JOIN WCG_DW.dbo.DimTime					d3 ON tfm.EventTime = d3.FullTime
LEFT JOIN WCG_DW.dbo.DimOperation				d4 ON tfm.OperationID = d4.OperationID
LEFT JOIN WCG_DW.dbo.DimShift					d5 ON tfm.ShiftID = d5.ShiftID
LEFT JOIN WCG_DW.dbo.DimTrafficCentre			d6 ON tfm.TrafficCentreID = d6.TrafficCentreID
LEFT JOIN WCG_DW.dbo.DimTrafficControlEvent		d7 ON tfm.TrafficControlEventGUID = d7.TrafficControlEventGUID
LEFT JOIN WCG_DW.dbo.DimUser					d8 ON tfm.UserID = d8.UserID
LEFT JOIN WCG_DW.dbo.DimDeviceEvent				d9 ON tfm.EventSource = d9.EventSource AND tfm.EventType = d9.EventType AND tfm.EventSubType = d9.EventSubType