

CREATE VIEW [model].[Shift Week] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   06 May 2018 12:52:05 PM
-- Reason               :   Semantic View for dbo.DimShiftWeek
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ShiftWeekKey] AS [ShiftWeekKey]
	,[IsUserWeek] AS [Is User Week]
	,[RosterWeek] AS [Roster Week]
	,[ShiftWeek] AS [Shift Week]
	,[ShiftWeekGUID] AS [Shift Week GUID]
	,[User] AS [User]
	,[UserRole] AS [User Role]
	,[WeekEndDate] AS [Week End Date]
	,[WeekStartDate] AS [Week Start Date]
FROM WCG_DW.dbo.DimShiftWeek WITH (NOLOCK)

