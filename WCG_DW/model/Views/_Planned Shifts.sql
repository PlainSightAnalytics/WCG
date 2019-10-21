

CREATE VIEW [model].[_Planned Shifts] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   24 Jun 2018 1:16:53 PM
-- Reason               :   Semantic View for dbo.FactPlannedShifts
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [RosterKey] AS [RosterKey]
	,[ShiftDateKey] AS [ShiftDateKey]
	,[ShiftTimeKey] AS [ShiftTimeKey]
	,[ShiftWeekKey] AS [ShiftWeekKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[UserKey] AS [UserKey]
	,[IsAcknowledged] AS [Is Acknowledged]
	,[IsArchived] AS [Is Archived]
	,[IsDeleted] AS [Is Deleted]
	,[IsUserShift] AS [Is User Shift]
	,[ShiftGUID] AS [Shift GUID]
FROM WCG_DW.dbo.FactPlannedShifts WITH (NOLOCK)

