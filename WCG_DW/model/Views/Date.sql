






CREATE VIEW [model].[Date] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   06 Aug 2016 2:23:15 PM
-- Reason               :   Semantic View for dbo.DimDate
-- Modified By          :   Toufiq Abrahams
-- Modified On          :   30 August 2016
-- Reason               :   Simplify Date and add Financial Periods
------------------------------------------------------------------------------------------

WITH ThisYearCTE AS (
	SELECT
		CASE
			WHEN MONTH(GETDATE()) <= 3 THEN CONCAT(CAST(YEAR(GETDATE()) -1 AS VARCHAR(4)),'/',CAST(YEAR(GETDATE()) AS VARCHAR(4))) 
			ELSE CONCAT(CAST(YEAR(GETDATE()) AS VARCHAR(4)),'/',CAST(YEAR(GETDATE())+ 1 AS VARCHAR(4)))
		END AS ThisYear
)

,DateCTE AS (
SELECT [DateKey]
	,[FullDate]										AS [Full Date]
	,[CalendarYear]									AS [Calendar Year]
	,CASE WHEN [CalendarMonth] = 0 THEN ''
	      WHEN [CalendarMonth] IN (1,2,3) 
			THEN CAST([CalendarYear] - 1 AS VARCHAR(20)) + '/' + CAST([CalendarYear] AS VARCHAR(20))
	      ELSE CAST([CalendarYear] AS VARCHAR(20)) + '/' + CAST([CalendarYear] + 1 AS VARCHAR(20)) 
	 END											AS [Year]
	,[CalendarQuarter]								AS [Calendar Quarter]
	,CASE WHEN [CalendarMonth] IN (4,5,6) THEN 1
	      WHEN [CalendarMonth] IN (7,8,9) THEN 2
		  WHEN [CalendarMonth] IN (10,11,12) THEN 3
		  WHEN [CalendarMonth] IN (1,2,3) THEN 4
		  ELSE 0
	 END											AS [Quarter]
	,[MonthShortName]								AS [Month]
	,[CalendarMonth]								AS [Calendar Month Number]
	,CASE WHEN [CalendarMonth] = 0 THEN 0
	      WHEN [CalendarMonth] > 3 THEN [CalendarMonth] - 3
		  ELSE [CalendarMonth] + 9 
	 END											AS [Financial Month Number]
	,CASE 
		WHEN MONTH(GETDATE()) > 3 AND CalendarYear = YEAR(GETDATE()) THEN 'Current FY'
		WHEN MONTH(GETDATE()) <= 3 AND CalendarYear = YEAR(GETDATE()) -1 THEN 'Current FY'
		WHEN CalendarMonth > 3 THEN CONCAT('FY ',CAST(CalendarYear AS VARCHAR(4)),'/',CAST(CalendarYear + 1AS VARCHAR(4)))
		ELSE CONCAT('FY ',CAST(CalendarYear -1 AS VARCHAR(4)),'/',CAST(CalendarYear AS VARCHAR(4)))
	END												AS [Financial Year Display]
	,CASE 
		WHEN CalendarYear = YEAR(GETDATE()) AND CalendarMonth = MONTH(GETDATE()) THEN 'Current'
		ELSE [MonthShortName]
	END												AS [Financial Month Display]
	,[CalendarWeek]									AS [Calendar Week]
	,[DayOfMonth]									AS [Day Of Month]
	,[DayOfWeekSaturday]							AS [Day Of Week Number]
	,[DayOfWeekShortName]							AS [Day Of Week]
	,[IsLastDayOfMonth]								AS [Is Last Day Of Month]
	,[IsPublicHoliday]								AS [Is Public Holiday]
	,[IsWorkingDay]									AS [Is Working Day]
	,[PublicHolidayName]							AS [Public Holiday Name]
	,[MonthYearName]
	,[CalendarYearMonthKey]
FROM WCG_DW.dbo.DimDate WITH (NOLOCK)
WHERE [DateKey] > 0
)

SELECT 
	 d.[DateKey]
	,d.[Full Date]
	,d.[Calendar Year]
	,d.[Year]
	,d.[Calendar Quarter]
	,d.[Quarter]
	,d.[Month]
	,d.[Calendar Month Number]
	,d.[Financial Month Number]
	,d.[Financial Year Display]
	,d.[Financial Month Display]
	,d.[Calendar Week]
	,d.[Day Of Month]
	,d.[Day Of Week Number]
	,d.[Day Of Week]
	,d.[Is Last Day Of Month]
	,d.[Is Public Holiday]
	,d.[Is Working Day]
	,d.[Public Holiday Name]
	,CASE WHEN d.year = y.ThisYear THEN 'Current' ELSE d.Year END AS [Year Display]
	,CASE WHEN MONTH(GETDATE()) = d.[Calendar Month Number] AND d.year = y.ThisYear THEN 'Cur' ELSE d.Month END AS [Month Display]
	,d.[MonthYearName] AS [Month Year Name]
	,0-[CalendarYearMonthKey] AS CalendarYearMonthKey
FROM DateCTE d 
LEFT JOIN ThisYearCTE y ON d.Year = y.ThisYear
