








CREATE VIEW [model].[KeyDatesEBAT] 

AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   23-06-2018
-- Reason               :   Single Row view for EBAT Key Dates to display in power bi model
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	13-07-2019
-- Reason               :	Changed Key Dates to use AT TIME ZONE instead of DATEADD
------------------------------------------------------------------------------------------


SELECT 
	LastEBATReadingDate, LastRefreshDate
FROM (
		SELECT 'LastEBATReadingDate' AS Name, CAST(MAX(CAST(time_of_reading_start AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time') AS DATETIME) AS KeyDate
		FROM WCG_Stage.ebat.ebat_report
		UNION ALL
		SELECT 'LastRefreshDate' AS Name, EndTime AS KeyDate 
		FROM DimExecutionLog WHERE ScriptName LIKE '%UploadModelDataEBAT.ps1%'
) AS SourceTable
PIVOT
(
MAX(KeyDate)
FOR Name IN ([LastAlertDate], [LastSightingDate], [LastTrafficControlEventDate], [LastEBATReadingDate], [LastRefreshDate])
) AS PivotTable
