

CREATE VIEW [model].[Shift Time] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   06 May 2018 1:44:35 PM
-- Reason               :   Semantic View for dbo.DimShiftTime
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ShiftTimeKey] AS [ShiftTimeKey]
	,[DurationHours] AS [Duration Hours]
	,[EndTime] AS [End Time]
	,[IsOffDuty] AS [Is Off Duty]
	,[ShiftTime] AS [Shift Time]
	,[ShiftTimeGUID] AS [Shift Time GUID]
	,[ShiftTimeSort] AS [Shift Time Sort]
	,[StartTime] AS [Start Time]
	,[TrafficCentre] AS [Traffic Centre]
FROM WCG_DW.dbo.DimShiftTime WITH (NOLOCK)

