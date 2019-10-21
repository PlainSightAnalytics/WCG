











CREATE VIEW [model].[KeyDatesITIS] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   29-04-2019
-- Reason               :   Single Row view for ITIS Key Dates to display in power bi model
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	13-07-2019
-- Reason               :	Changed Key Dates to use AT TIME ZONE instead of DATEADD
------------------------------------------------------------------------------------------


SELECT 
	LastTrafficControlEventDate, LastImpoundInstructionDate, LastRefreshDate
FROM (
		SELECT 'LastTrafficControlEventDate' AS Name, CAST(MAX(CAST(HighWaterDateTime AS datetimeoffset) AT TIME ZONE 'South Africa Standard Time') AS DATETIME) AS KeyDate
		FROM WCG_DW.dbo.DimDeltaLog
		WHERE ObjectName = 'event'
		UNION ALL
		SELECT 'LastImpoundInstructionDate' AS Name, CAST(MAX(CAST(created_at AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time') AS DATETIME) AS KeyDate
		FROM WCG_Stage.pnd.impound_instruction
		UNION ALL
		SELECT 'LastRefreshDate' AS Name, MAX(EndTime) AS KeyDate 
		FROM DimExecutionLog WHERE ScriptName LIKE '%UploadModelDataITIS.ps1%'
) AS SourceTable
PIVOT
(
MAX(KeyDate)
FOR Name IN ([LastTrafficControlEventDate], [LastImpoundInstructionDate], [LastRefreshDate])
) AS PivotTable
