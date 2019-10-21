










CREATE VIEW [model].[KeyDatesImpound] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   10-02-2019
-- Reason               :   Single Row view for Impound Key Dates to display in power bi model
-- Modified By          :	Trevor Howe
-- Modified On          :	13-07-2019
-- Reason               :	Changed Key Dates to use AT TIME ZONE instead of DATEADD
------------------------------------------------------------------------------------------


SELECT 
	LastImpoundInstructionDate, LastRefreshDate
FROM (
		SELECT 'LastImpoundInstructionDate' AS Name, CAST(MAX(CAST(created_at AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time') AS DATETIME) AS KeyDate
		FROM WCG_Stage.pnd.impound_instruction
		UNION ALL
		SELECT 'LastRefreshDate' AS Name, MAX(EndTime) AS KeyDate 
		FROM DimExecutionLog WHERE ScriptName LIKE '%UploadModelData.ps1%'
) AS SourceTable
PIVOT
(
MAX(KeyDate)
FOR Name IN ([LastImpoundInstructionDate], [LastRefreshDate])
) AS PivotTable
