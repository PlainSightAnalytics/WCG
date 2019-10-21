







CREATE VIEW [dbo].[LoadFactShiftTasks] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-10-2018
-- Reason				:	Load view for FactShiftTasks
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.DateKey,-1)				AS OperationsDateKey
	,ISNULL(d2.DateKey,-1)				AS ShiftDateKey
	,ISNULL(d3.ShiftKey,-1)				AS ShiftKey
	,ISNULL(d4.ShiftLocationKey,-1)		AS ShiftLocationKey
	,ISNULL(d5.ShiftTaskKey,-1)			AS ShiftTaskKey
	,ISNULL(d6.TrafficCentreKey,-1)		AS TrafficCentreKey
	,ISNULL(d7.UserKey,-1)				AS UserKey
	,tfm.DurationHours					AS DurationHours
	,tfm.TaskTarget						AS TaskTarget
	,tfm.IsAdhocTask					AS IsAdHocTask
	,tfm.OtherLocation					AS OtherLocation
	,tfm.TaskEndTime					AS TaskEndTime
	,tfm.TaskStartTime					AS TaskStartTime
	,tfm.UniqueId						AS UniqueID
	,tfm.DeltaLogKey					AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactShiftTasks]  tfm WITH (NOLOCK)
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d1 WITH (NOLOCK) ON tfm.OperationsDate = d1.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d2 WITH (NOLOCK) ON tfm.ShiftDate = d2.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimShift]					d3 WITH (NOLOCK) ON tfm.ShiftID = d3.ShiftID
LEFT JOIN [WCG_DW].[dbo].[DimShiftLocation]			d4 WITH (NOLOCK) ON tfm.ShiftLocationID = d4.ShiftLocationID
LEFT JOIN [WCG_DW].[dbo].[DimShiftTask]				d5 WITH (NOLOCK) ON tfm.ShiftTaskID = d5.ShiftTaskID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]			d6 WITH (NOLOCK) ON tfm.TrafficCentreID = d6.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimUser]					d7 WITH (NOLOCK) ON tfm.UserID = d7.UserID








