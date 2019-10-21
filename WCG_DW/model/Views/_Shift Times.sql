
CREATE VIEW [model].[_Shift Times] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactShiftTimes
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [OperationsDateKey] AS [OperationsDateKey]
	,[RosterKey] AS [RosterKey]
	,[ShiftDateKey] AS [ShiftDateKey]
	,[ShiftKey] AS [ShiftKey]
	,[ShiftTimeKey] AS [ShiftTimeKey]
	,[ShiftWeekKey] AS [ShiftWeekKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[UserKey] AS [UserKey]
	,[IsAcknowledged] AS [Is Acknowledged]
	,[IsArchived] AS [Is Archived]
	,[IsDeleted] AS [Is Deleted]
	,[IsUserShift] AS [Is User Shift]
	,[UniqueID] AS [Unique ID]
	,[DurationHours] AS [_DurationHours]
FROM WCG_DW.dbo.FactShiftTimes WITH (NOLOCK)
