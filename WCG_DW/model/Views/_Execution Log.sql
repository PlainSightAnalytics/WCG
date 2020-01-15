
CREATE VIEW [model].[_Execution Log] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   20-12-2019
-- Reason               :   Semantic View for dbo.DimExecutionLog
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

WITH ExecutionLogCTE AS (
SELECT
	 FORMAT(StartTime,'yyyyMMdd')	AS ExecutionDateKey
	,FORMAT(StartTime,'HHmm')		AS ExecutionTimeKey
	,CASE
		WHEN CHARINDEX('\', ScriptName) > 0
			THEN RIGHT(ScriptName, CHARINDEX('\', REVERSE(ScriptName)) -1)
		ELSE ScriptName
	END									AS ScriptName
	,ExecutionLogKey
	,CASE	
		WHEN ExceptionMessage IS NULL THEN NULL
		ELSE CONCAT('Line: ',ExceptionLineNo,'. ',ExceptionLine,' Message: ',ExceptionMessage) 
	END AS Exception
	,StartTime
	,EndTime
	,DATEDIFF(
		MINUTE
		,CASE
			WHEN ROW_NUMBER() OVER (PARTITION BY ExecutionLogKey ORDER BY h.Hour24) = 1 THEN CAST(StartTime AS TIME)
			ELSE TIMEFROMPARTS(h.Hour24,0,0,0,0)
		END
		,CASE
			WHEN ROW_NUMBER() OVER (PARTITION BY ExecutionLogKey ORDER BY h.Hour24 DESC) = 1 THEN CAST(EndTime AS TIME)
			ELSE TIMEFROMPARTS(h.Hour24 + 1,0,0,0,0)	
		END
		) AS Duration
	,h.HourKey AS ExecutionHourKey
	,DATEDIFF(MINUTE,StartTime, EndTime) AS DurationCheck
FROM WCG_DW.dbo.DimExecutionLog e
LEFT JOIN WCG_DW.dbo.DimHour h ON h.Hour24 >= FORMAT(e.StartTime,'HH') AND h.Hour24 <= FORMAT(e.EndTime,'HH')
WHERE ScriptName <> ''
AND EndTime IS NOT NULL
)

SELECT
	 ExecutionDateKey
	,ExecutionHourKey
	,ExecutionTimeKey
	,ISNULL(o.ObjectKey,-1) AS ObjectKey
	,Exception
	,ExecutionLogKey
	,StartTime
	,EndTime
	,Duration
	,ScriptName
FROM ExecutionLogCTE e
LEFT JOIN WCG_DW.dbo.DimObject o ON e.ScriptName = o.ObjectName


