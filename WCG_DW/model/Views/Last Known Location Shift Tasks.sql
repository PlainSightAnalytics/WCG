
CREATE VIEW [model].[Last Known Location Shift Tasks]  AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   2019-03-23
-- Reason               :   Transform view for Last Known Location 
-- Modified By          :
-- Modified ON          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT
	 s.ShiftKey												AS [ShiftKey]
	,f.TaskEndTime											AS [Task End Time]
	,f.TaskStartTime										AS [Task Start Time]
	,f.DurationHours										AS [Tassk Duration Hours]      	
	,ISNULL(sl.LocationType,'Unknown')						AS [Location Type]
	,COALESCE(sl.ShiftLocation,f.OtherLocation,'Unknown')	AS [Shift Location]
	,ISNULL(st.ShiftTask,'No Tasks Defined')				AS [Shift Task]
	,ISNULL(st.ShiftTaskType,'Unknown')						AS [Shift Task Type]
FROM WCG_DW.dbo.DimShift s WITH (NOLOCK)
INNER JOIN WCG_DW.model.[Last Known Location] l on s.ShiftID = l.ShiftId
LEFT JOIN WCG_DW.dbo.FactShiftTasks f WITH (NOLOCK) ON s.ShiftKey = f.ShiftKey
LEFT JOIN WCG_DW.dbo.DimShiftLocation sl WITH (NOLOCK) ON f.ShiftLocationKey = sl.ShiftLocationKey
LEFT JOIN WCG_DW.dbo.DimShiftTask st WITH (NOLOCK) ON f.ShiftTaskKey = st.ShiftTaskKey
