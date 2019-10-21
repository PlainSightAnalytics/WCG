
CREATE VIEW [model].[_Shift Tasks] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactShiftTasks
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [OperationsDateKey] AS [OperationsDateKey]
	,[ShiftDateKey] AS [ShiftDateKey]
	,[ShiftKey] AS [ShiftKey]
	,[ShiftLocationKey] AS [ShiftLocationKey]
	,[ShiftTaskKey] AS [ShiftTaskKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[UserKey] AS [UserKey]
	,[IsAdhocTask] AS [Is Adhoc Task]
	,[OtherLocation] AS [Other Location]
	,[TaskEndTime] AS [Task End Time]
	,[TaskStartTime] AS [Task Start Time]
	,[UniqueID] AS [Unique ID]
	,[DurationHours] AS [_DurationHours]
	,[TaskTarget] AS [_TaskTarget]
FROM WCG_DW.dbo.FactShiftTasks WITH (NOLOCK)
