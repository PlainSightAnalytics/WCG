

CREATE VIEW [model].[Shift] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   28 Oct 2018 1:35:42 PM
-- Reason               :   Semantic View for dbo.DimShift
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ShiftKey] AS [ShiftKey]
	,[DurationHours] AS [Duration Hours]
	,[EndTime] AS [End Time]
	,[IsOffDuty] AS [Is Off Duty]
	,[IsUserShift] AS [Is User Shift]
	,[Officer] AS [Officer]
	,[RosterGroup] AS [Roster Group]
	,[RosterGroupPPI] AS [Roster Group PPI]
	,[RosterGroupReportsTo] AS [Roster Group Reports To]
	,[RosterGroupSPI] AS [Roster Group SPI]
	,[RosterStatus] AS [Roster Status]
	,[RosterWeek] AS [Roster Week]
	,[Shift] AS [Shift]
	,[ShiftDate] AS [Shift Date]
	,[ShiftID] AS [Shift ID]
	,[ShiftTime] AS [Shift Time]
	,[ShiftTimeSort] AS [Shift Time Sort]
	,[StartTime] AS [Start Time]
	,[UserRole] AS [User Role]
	,[WeekDay] AS [Week Day]
	,[WeekEndDate] AS [Week End Date]
	,[WeekStartDate] AS [Week Start Date]
	,CASE
		WHEN [WeekDay] ='Monday' THEN 1
		WHEN [WeekDay] ='Tuesday' THEN 2 
		WHEN [WeekDay] ='Wednesday' THEN 3 
		WHEN [WeekDay] ='Thursday' THEN 4 
		WHEN [WeekDay] ='Friday' THEN 5 
		WHEN [WeekDay] ='Saturday' THEN 6 
		ELSE 7
	END AS [WeekDayOrder]
FROM WCG_DW.dbo.DimShift WITH (NOLOCK)

