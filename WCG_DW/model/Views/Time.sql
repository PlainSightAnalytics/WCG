

CREATE VIEW [model].[Time] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimTime
-- Modified By          :	Trevor Howe
-- Modified On          :	30-09-2019
-- Reason               :	Added Sort Column for Hour
------------------------------------------------------------------------------------------
SELECT 
	 [TimeKey] AS [TimeKey]
	,[AMPMIndicator] AS [AM PM Indicator]
	,[FullTime] AS [Full Time]
	,[HalfHourBand] AS [Half Hour Band]
	,[Hour12] AS [Hour 12]
	,[Hour24] AS [Hour 24]
	,[HourBand] AS [Hour Band]
	,[HourShiftSort] AS [Hour Shift Sort]
	,[Is6amTo8pm] AS [Is 6am To 8pm]
	,[MinuteOfHour] AS [Minute Of Hour]
	,[PeriodOfDay] AS [Period Of Day]
	,[QuarterHourBand] AS [Quarter Hour Band]
	,[Shift] AS [Shift]
	,[TimeName] AS [Time Name]
	,CASE
		WHEN Hour24 < 6 THEN Hour24 + 24
		ELSE Hour24
	END AS [HourSort]
FROM WCG_DW.dbo.DimTime WITH (NOLOCK)

