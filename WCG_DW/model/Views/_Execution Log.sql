



CREATE VIEW [model].[_Execution Log] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   2019-06-14
-- Reason               :   Semantic View for dbo.DimExecutionLog
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

WITH ExecutionLogCTE AS (
	SELECT 
		 ExecutionLogKey											AS ExecutionLogKey
		,StartTime													AS StartTime
		,EndTime													AS EndTime
		,FORMAT(StartTime,'yyyyMMdd')								AS ExecutionDateKey
		,FORMAT(StartTime,'HHmm')									AS ExecutionTimeKey
		,ScriptName													AS ScriptName
		,ExceptionLineNo											AS ExceptionLineNo
		,ExceptionLine												AS ExceptionLine
		,ExceptionMessage											AS ExceptionMessage
		--,SUBSTRING(ScriptName,CHARINDEX('ps\',scriptname,1)+3,50)	AS ScriptNameOnly
		,REPLACE(REPLACE(
			CASE
				WHEN CHARINDEX('\', ScriptName) > 0
					THEN RIGHT(ScriptName, CHARINDEX('\', REVERSE(ScriptName)) -1)
				ELSE ScriptName
			END,'.ps1',''),'.p','')									AS ScriptNameOnly
FROM DimExecutionLogWCG e WITH (NOLOCK)
WHERE ScriptName LIKE '%ps\%'
)

,MasterCTE AS (
	SELECT 
		 e.StartTime											AS MasterScriptStartTime
		,e.EndTime												AS MasterScriptEndTime
		,DATEDIFF(SECOND,e.StartTime,e.EndTime)					AS MasterScriptDuration
		,FORMAT(StartTime,'yyyyMMdd')							AS MasterScriptExecutionDateKey
		,FORMAT(StartTime,'HHmm')								AS MasterScriptExecutionTimeKey
		,CASE
			WHEN ScriptName LIKE '%LoadMasterDaily%' 
				THEN 'LoadMasterEBAT'
			ELSE REPLACE(
					SUBSTRING(
						ScriptName
						,CHARINDEX('ps\',scriptname,1)+3
						,50
					),'.ps1','') 
		END														AS MasterScript
		,DATEADD(
			SECOND
			,-1
			,LEAD(StartTime) 
				OVER (
					PARTITION BY ScriptName 
					ORDER BY StartTime)
			)													AS NextStartTime
FROM ExecutionLogCTE e 
)

,MasterCTE1 AS (
	SELECT
		 MasterScript											AS MasterScript
		,REPLACE(MasterScript,'.ps1','') 
		 + FORMAT(MasterScriptStartTime,'yyyyMMdd-') 
		 + CAST((ROW_NUMBER() OVER (
								PARTITION BY MasterScript, MasterScriptExecutionDateKey 
								ORDER BY MasterScriptStartTime)) 
				AS VARCHAR(3))									AS ExecutionBatch
		,MasterScriptStartTime									AS MasterScriptStartTime
		,ISNULL(MasterScriptEndTime,NextStartTime)				AS MasterScriptEndTime
		,MasterScriptExecutionDateKey							AS MasterScriptExecutionDateKey
		,MasterScriptExecutionTimeKey							AS MasterScriptExecutionTimeKey
		,MasterScriptDuration									AS MasterScriptDuration
	FROM MasterCTE
)

SELECT
	 e.ExecutionLogKey											AS ExecutionLogKey
	,e.ScriptNameOnly											AS ScriptName
	,ISNULL(m.MasterScript,'Adhoc')								AS MasterScript
	,e.StartTime												AS ScriptStartTime
	,e.EndTime													AS ScriptEndTime
	,CASE
		WHEN m.MasterScript + '.ps1' = e.ScriptNameOnly THEN NULL
		ELSE DATEDIFF(SECOND,e.StartTime,e.EndTime)						
	END															AS ScriptDuration
	,CAST(b.ExecutionBatch AS VARCHAR(100))						AS ExecutionBatch
	,CASE
		WHEN m.MasterScript + '.ps1' = e.ScriptNameOnly 
			THEN b.MasterScriptDuration
		ELSE NULL
	END															AS MasterScriptDuration
	,CAST(
		ISNULL(
			b.MasterScriptExecutionDateKey,e.ExecutionDateKey) 
		AS INT)													AS MasterScriptExecutionDateKey
	,CAST(
		ISNULL(
			b.MasterScriptExecutionTimeKey, e.ExecutionTimeKey) 
		AS INT)													AS MasterScriptExecutionTimeKey
	,CAST(e.ExceptionMessage AS VARCHAR(1000))					AS ExceptionMessage
FROM ExecutionLogCTE e
LEFT JOIN ScriptMapping m ON e.ScriptNameOnly = m.ScriptName AND e.StartTime BETWEEN m.StartDateTime AND m.EndDateTime
LEFT JOIN MasterCTE1 b ON m.MasterScript = b.MasterScript AND e.StartTime BETWEEN b.MasterScriptStartTime AND b.MasterScriptEndTime


