

CREATE VIEW [dbo].[LoadFactShiftActivities] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-10-2018
-- Reason				:	Load view for FactShiftActivities
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.GeoLocationKey,-1)					AS GeoLocationKey
	,ISNULL(d2.DateKey,-1)							AS OperationsDateKey
	,ISNULL(d3.ShiftActivityTypeKey,-1)				AS ShiftActivityTypeKey
	,ISNULL(d4.DateKey,-1)							AS ShiftDateKey
	,ISNULL(d5.ShiftKey,-1)							AS ShiftKey
	,ISNULL(d6.ShiftLocationKey,-1)					AS ShiftLocationKey
	,ISNULL(d7.ShiftTaskKey,-1)						AS ShiftTaskKey
	,ISNULL(d8.TrafficCentreKey,-1)					AS TrafficCentreKey
	,ISNULL(d9.UserKey,-1)							AS UserKey
	,tfm.DurationHours								AS DurationHours
	,tfm.ActivityComment							AS ActivityComment
	,tfm.ActivityEndTime							AS ActivityEndTime
	,tfm.ActivityStartTime							AS ActivityStartTime
	,tfm.IsAdhocActivity							AS IsAdhocActivity
	,tfm.OtherLocation								AS OtherLocation
	,tfm.UniqueID									AS UniqueID
	,tfm.DeltaLogKey								AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactShiftActivities] tfm
LEFT JOIN [WCG_DW].[dbo].[DimGeoLocation]			d1 ON tfm.Latitude = d1.Latitude AND tfm.Longitude = d1.Longitude
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d2 ON tfm.OperationsDate = d2.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimShiftActivityType]		d3 ON tfm.ShiftActivityCode = d3.ShiftActivityTypeCode
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d4 ON tfm.ShiftDate = d4.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimShift]					d5 ON tfm.ShiftID = d5.ShiftID
LEFT JOIN [WCG_DW].[dbo].[DimShiftLocation]			d6 ON tfm.ShiftLocationID = d6.ShiftLocationID
LEFT JOIN [WCG_DW].[dbo].[DimShiftTask]				d7 ON tfm.ShiftTaskID = d7.ShiftTaskID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]			d8 ON tfm.TrafficCentreID = d8.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimUser]					d9 ON tfm.UserID = d9.UserID







