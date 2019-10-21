
CREATE PROCEDURE [dbo].[prcLoadDimDate]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe (c_TrevorHo)
-- Date Created			:	18-06-2016
-- Reason				:	SCD Load for DimDate
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@StartDate, @EndDate
-- Ouputs				:	
-- Test					:	dbo.prcLoadDimDate -1, '31 Mar 2019'
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@EndDate AS DATE = '1 Jan 2015'

AS

/* Create Temp Table */
CREATE TABLE #DimDate (
	 [DateKey] INT
	,[FullDate] DATE
	,[CalendarMonth] TINYINT
	,[CalendarQuarter] TINYINT
	,[CalendarWeek] TINYINT
	,[CalendarYear] SMALLINT
	,[CalendarYearMonthKey] INT
	,[CalendarYearQuarterKey] INT
	,[CalendarYearWeekKey] INT
	,[DayOfMonth] TINYINT
	,[DayOfQuarter] TINYINT
	,[DayOfWeekMonday] TINYINT
	,[DayOfWeekName] VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[DayOfWeekSaturday] TINYINT
	,[DayOfWeekShortName] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[DayOfWeekSunday] TINYINT
	,[DayOfYear] SMALLINT
	,[DaySuffix] VARCHAR(5) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[IsFirstDayOfMonth] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[IsFirstDayOfQuarter]  VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[IsFirstDayOfYear] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[IsLastDayOfMonth] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[IsLastDayOfQuarter] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[ISLastDayOfYear] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[IsPublicHoliday] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[IsWeekend] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[IsWorkingDay] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[MonthName] VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[MonthOfQuarter] TINYINT
	,[MonthShortName] VARCHAR(3) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[MonthYearName] VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[PublicHolidayName] VARCHAR(50) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[QuarterName] VARCHAR(15) COLLATE SQL_Latin1_General_CP1_CI_AS
	,[YearName] VARCHAR(10) COLLATE SQL_Latin1_General_CP1_CI_AS
)

DECLARE @StartDate AS DATE
SELECT @StartDate = '1 Jan 2010'

IF @EndDate = '1 Jan 2015'
SELECT @EndDate = DATEADD(MONTH,3,DATEFROMPARTS(YEAR(GETDATE()),12,31))

/* Set DATEFIRST */
SET DATEFIRST 1;

/* Create Recursive dates between start and end date */
WITH DateListCTE AS (
	SELECT 
		@StartDate AS [DateKey]
	UNION ALL
	SELECT	
		DATEADD(DAY,1,[DateKey])
	FROM	DateListCTE   
	WHERE	DATEADD(DAY,1,[DateKey]) <= @EndDate
),

DayOfWeekCTE AS (
SELECT 'Monday' AS DayofWeekName, 1 AS DayOfWeekMonday, 3 AS DayOfWeekSaturday, 2 AS DayOfWeekSunday
UNION ALL
SELECT 'Tuesday' AS DayofWeekName, 2 AS DayOfWeekMonday, 4 AS DayOfWeekSaturday, 3 AS DayOfWeekSunday
UNION ALL
SELECT 'Wednesday' AS DayofWeekName, 3 AS DayOfWeekMonday, 5 AS DayOfWeekSaturday, 4 AS DayOfWeekSunday
UNION ALL
SELECT 'Thursday' AS DayofWeekName, 4 AS DayOfWeekMonday, 6 AS DayOfWeekSaturday, 5 AS DayOfWeekSunday
UNION ALL
SELECT 'Friday' AS DayofWeekName, 5 AS DayOfWeekMonday, 7 AS DayOfWeekSaturday, 6 AS DayOfWeekSunday
UNION ALL
SELECT 'Saturday' AS DayofWeekName, 6 AS DayOfWeekMonday, 1 AS DayOfWeekSaturday, 7 AS DayOfWeekSunday
UNION ALL
SELECT 'Sunday' AS DayofWeekName, 7 AS DayOfWeekMonday, 2 AS DayOfWeekSaturday, 1 AS DayOfWeekSunday
)

/* Build standard date attributes */
INSERT INTO #DimDate
([DateKey],[CalendarMonth],[CalendarQuarter],[CalendarWeek],[CalendarYear],[CalendarYearMonthKey],[CalendarYearQuarterKey],[CalendarYearWeekKey],
 [DayOfMonth],[DayOfQuarter], [DayOfWeekMonday],[DayOfWeekName],[DayOfWeekSaturday], [DayOfWeekShortName],[DayOFWeekSunday], [DayOfYear], [DaySuffix],
 [FullDate], [IsFirstDayOfMonth], [IsFirstDayOfQuarter], [IsFirstDayOfYear], [IsLastDayOfMonth], [IsLastDayOfQuarter], [ISLastDayOfYear], 
 [IsPublicHoliday], [IsWeekend],[IsWorkingDay], [MonthName],[MonthOfQuarter], [MonthShortName],[MonthYearName], [PublicHolidayName], [QuarterName], 
 [YearName] 
 )
 SELECT 
	CONVERT(VARCHAR,[DateKey],112)													AS [DateKey]
	,DATEPART(MONTH, [DateKey])														AS [CalendarMonth]
	,DATEPART(QUARTER, [DateKey])													AS [CalendarQuarter]
	,DATEPART(WEEK, [DateKey])														AS [CalendarWeek]
	,YEAR([DateKey])																AS [CalendarYear]
	,(YEAR([DateKey]) * 100) + DATEPART(MONTH, [DateKey])							AS [CalendarYearMonthKey]
	,(YEAR([DateKey]) * 100) + DATEPART(QUARTER, [DateKey])							AS [CalendarYearQuarterKey]
	,(YEAR([DateKey]) * 100) + DATEPART(WEEK, [DateKey])							AS [CalendarYearWeekKey]
	,DAY([DateKey])																	AS [DayOfMonth]
	,DATEDIFF(d, DATEADD(qq, DATEDIFF(qq, 0, [DateKey]), 0), [DateKey]) + 1			AS [DayOfQuarter]
	,dw.DayOfWeekMonday																AS [DayOfWeekMonday]
	,DATENAME(WEEKDAY, [DateKey])													AS [DayOfWeekName]
	,dw.DayOfWeekSaturday															AS [DayOfWeekSaturday]
	,SUBSTRING(DATENAME(WEEKDAY, [DateKey]),1,3)									AS [DayOfWeekShortName]
	,dw.DayOfWeekSunday																AS [DayOfWeekSunday]
	,DATEPART(DAYOFYEAR, [DateKey])													AS [DayOfYear]
	,CHOOSE(
		DAY([DateKey]), 
		'1st','2nd','3rd','4th','5th','6th','7th','8th','9th','10th','11th','12th',
		'13th','14th','15th','16th','17th','18th','19th','20th','21st','22nd','23rd',
		'24th','25th','26th','27th','28th','29th','30th','31st')					AS [DaySuffix]
	,[DateKey]																		AS [FullDate]
	,CASE
		WHEN DAY([DateKey]) = 1 THEN 'Yes'
		ELSE 'No'
	END																				AS [IsFirstDayOfMonth]
	,CASE
		WHEN DATEDIFF(d, DATEADD(qq, DATEDIFF(qq, 0, [DateKey]), 0), [DateKey]) + 1 = 1 THEN 'Yes'
		ELSE 'No'
	END																				AS [IsFirstDayOfQuarter]
	,CASE
		WHEN DATEPART(DAYOFYEAR, [DateKey]) = 1 THEN 'Yes'
		ELSE 'No'
	END																				AS [IsFirstDayOfYear]
	,CASE
		WHEN EOMONTH([DateKey]) = [DateKey] THEN 'Yes'
		ELSE 'No'
	END																				AS [IsLastDayOfMonth]
	,CASE
		WHEN EOMONTH([DateKey]) = [DateKey] 
			 AND DATEPART(MONTH, [DateKey]) IN (3,6,9,12) THEN 'Yes'
		ELSE 'No'
	END																				AS [IsLastDayOfQuarter]
	,CASE
		WHEN EOMONTH([DateKey]) = [DateKey] AND DATEPART(MONTH, [DateKey]) = 12 THEN 'Yes'
		ELSE 'No'
	END																				AS [IsLastDayOfYear]
	,CASE
		WHEN ph.PublicHolidayName IS NOT NULL THEN 'Yes'
		ELSE 'No'
	END 																			AS [IsPublicHoliday]
	,CASE
		WHEN DATENAME(WEEKDAY, [DateKey]) IN ('Saturday','Sunday') THEN 'Yes' 
		ELSE 'No'			
	END																				AS [IsWeekend]
	,CASE
		WHEN DATENAME(WEEKDAY, [DateKey]) IN ('Saturday','Sunday') THEN 'No' 
		ELSE 'Yes'			
	END																				AS [IsWorkingDay]
	,DATENAME(MONTH, [DateKey])														AS [MonthName]
	,CHOOSE(DATEPART(MONTH, [DateKey]),1,2,3,1,2,3,1,2,3,1,2,3)						AS [MonthInQuarter]
	,SUBSTRING(DATENAME(MONTH, [DateKey]),1,3)										AS [MonthShortName]
	,SUBSTRING(DATENAME(MONTH, [DateKey]),1,3) + ' ' 
		+ CAST(YEAR([DateKey]) AS VARCHAR(4))										AS [MonthYearName]
	,ISNULL(ph.PublicHolidayName,'No Holiday')										AS [PublicHolidayName]
	,CHOOSE(DATEPART(QUARTER, [DateKey]),
			'First Quarter','Second Quarter', 'Third Quarter', 'Fourth Quarter')	AS [QuarterName]
	,CONCAT('CY ', YEAR([DateKey]))													AS [YearName] 
FROM DateListCTE as dl  
LEFT JOIN DayOfWeekCTE dw ON DATENAME(WEEKDAY, dl.[DateKey]) = dw.DayOfWeekName
LEFT JOIN man.transformPublicHolidays ph ON dl.DateKey = ph.[Date]
OPTION (MAXRECURSION 0)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimDate dim
USING #DimDate tmp
ON (dim.FullDate = tmp.FullDate)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (DateKey,FullDate,CalendarMonth,CalendarQuarter,CalendarWeek,CalendarYear,CalendarYearMonthKey,CalendarYearQuarterKey,CalendarYearWeekKey
			,DayOfMonth,DayOfQuarter,DayOfWeekMonday,DayOfWeekName,DayOfWeekSaturday,DayOfWeekShortName,DayOfWeekSunday,DayOfYear,DaySuffix
			,IsFirstDayOfMonth,IsFirstDayOfQuarter,IsFirstDayOfYear,IsLastDayOfMonth,IsLastDayOfQuarter,ISLastDayOfYear,IsPublicHoliday
			,IsWeekend,IsWorkingDay,MonthName,MonthOfQuarter,MonthShortName,MonthYearName, PublicHolidayName,QuarterName,YearName,InsertAuditKey,UpdateAuditKey)
	VALUES (DateKey,tmp.FullDate,tmp.CalendarMonth,tmp.CalendarQuarter,tmp.CalendarWeek,tmp.CalendarYear,tmp.CalendarYearMonthKey,tmp.CalendarYearQuarterKey,
			tmp.CalendarYearWeekKey,tmp.DayOfMonth,tmp.DayOfQuarter,tmp.DayOfWeekMonday,tmp.DayOfWeekName,tmp.DayOfWeekSaturday,tmp.DayOfWeekShortName,
			tmp.DayOfWeekSunday,tmp.DayOfYear,tmp.DaySuffix,tmp.IsFirstDayOfMonth,tmp.IsFirstDayOfQuarter,tmp.IsFirstDayOfYear,
			tmp.IsLastDayOfMonth,tmp.IsLastDayOfQuarter,tmp.ISLastDayOfYear,tmp.IsPublicHoliday, tmp.IsWeekend,tmp.IsWorkingDay,tmp.MonthName, 
			tmp.MonthOfQuarter,tmp.MonthShortName,tmp.MonthYearName,tmp.PublicHolidayName, tmp.QuarterName,tmp.YearName,@AuditKey,@AuditKey)
	WHEN MATCHED 
	AND (	dim.IsPublicHoliday<> tmp.IsPublicHoliday
		OR dim.IsWorkingDay <> tmp.IsWorkingDay
		OR dim.PublicHolidayName <> tmp.PublicHolidayName
	)
	THEN 
		UPDATE 
		SET 
			dim.IsPublicHoliday = tmp.IsPublicHoliday,
			dim.IsWorkingDay = tmp.IsWorkingDay,
			dim.PublicHolidayName = tmp.PublicHolidayName,
			/* Update System Fields */
			dim.UpdateAuditKey = @AuditKey,
			dim.RowIsInferred = 'N',
			dim.RowChangeReason = 'SCD Type 1 Change'
		;

DROP TABLE #DimDate





;
;
;
;
