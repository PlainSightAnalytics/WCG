





CREATE VIEW [dbo].[LoadFactShiftTimes] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	21-10-2018
-- Reason				:	Load view for FactShiftTimes
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.DateKey,-1)				AS OperationsDateKey
	,ISNULL(d2.RosterKey,-1)			AS RosterKey
	,ISNULL(d3.DateKey,-1)				AS ShiftDateKey
	,ISNULL(d4.ShiftKey,-1)				AS ShiftKey
	,ISNULL(d5.ShiftTimeKey,-1)			AS ShiftTimeKey
	,ISNULL(d6.ShiftWeekKey,-1)			AS ShiftWeekKey
	,ISNULL(d7.TrafficCentreKey,-1)		AS TrafficCentreKey
	,ISNULL(d8.UserKey,-1)				AS UserKey
	,tfm.DurationHours					AS DurationHours
	,tfm.IsAcknowledged					AS IsAcknowledged
	,tfm.IsArchived						AS IsArchived
	,tfm.IsDeleted						AS IsDeleted
	,tfm.IsUserShift					AS IsUserShift
	,tfm.ShiftGUID						AS UniqueID
	,tfm.DeltaLogKey					AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactShiftTimes] tfm
LEFT JOIN [WCG_DW].[dbo].[DimDate]				d1 ON tfm.OperationsDate = d1.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimRoster]			d2 ON tfm.RosterGUID = d2.RosterGUID
LEFT JOIN [WCG_DW].[dbo].[DimDate]				d3 ON tfm.ShiftDate = d3.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimShift]				d4 ON tfm.ShiftGUID = d4.ShiftID
LEFT JOIN [WCG_DW].[dbo].[DimShiftTime]			d5 ON tfm.ShiftTimeGUID = d5.ShiftTimeGUID
LEFT JOIN [WCG_DW].[dbo].[DimShiftWeek]			d6 ON tfm.ShiftWeekGUID = d6.ShiftWeekGUID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]		d7 ON tfm.TrafficCentreGUID = d7.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimUser]				d8 ON tfm.UserGUID = d8.UserID








