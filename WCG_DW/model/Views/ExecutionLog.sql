

CREATE VIEW [model].[ExecutionLog]

AS

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   09-09-2018
-- Reason               :   Model view for dbo.ExecutionLog
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT 
	 ExecutionLogKey
	,CAST('WCG' AS VARCHAR(10)) AS ClientName
	,CONVERT(INT,CONVERT(VARCHAR(10),StartTime,112)) AS DateKey
	,CONVERT(INT,CAST(REPLACE(CONVERT(TIME,StartTime,105),':','') AS VARCHAR(4))) AS TimeKey
	,StartTime
	,EndTime
	,ScriptName
	,ExceptionLineNo
	,ExceptionLine
	,ExceptionMessage
FROM dbo.DimExecutionLog WITH (NOLOCK)


