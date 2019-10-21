

CREATE VIEW [dbo].[LoadFactPlannedShifts] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	24-06-2018
-- Reason				:	Load view for FactPlannedShifts
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.RosterKey,-1)			AS RosterKey
	,ISNULL(d2.DateKey,-1)				AS ShiftDateKey
	,ISNULL(d3.ShiftTimeKey,-1)			AS ShiftTimeKey
	,ISNULL(d4.ShiftWeekKey,-1)			AS ShiftWeekKey
	,ISNULL(d5.TrafficCentreKey,-1)		AS TrafficCentreKey
	,ISNULL(d6.UserKey,-1)				AS UserKey
	,tfm.IsAcknowledged					AS IsAcknowledged
	,tfm.IsArchived						AS IsArchived
	,tfm.IsDeleted						AS IsDeleted
	,tfm.IsUserShift					AS IsUserShift
	,tfm.ShiftGUID						AS ShiftGUID
	,tfm.DeltaLogKey					AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactPlannedShifts] tfm
LEFT JOIN [WCG_DW].[dbo].[DimRoster]			d1 ON tfm.RosterGUID = d1.RosterGUID
LEFT JOIN [WCG_DW].[dbo].[DimDate]				d2 ON tfm.ShiftDate = d2.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimShiftTime]			d3 ON tfm.ShiftTimeGUID = d3.ShiftTimeGUID
LEFT JOIN [WCG_DW].[dbo].[DimShiftWeek]			d4 ON tfm.ShiftWeekGUID = d4.ShiftWeekGUID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]		d5 ON tfm.TrafficCentreGUID = d5.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimUser]				d6 ON tfm.UserGUID = d6.UserID








