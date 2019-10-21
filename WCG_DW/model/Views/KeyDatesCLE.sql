








CREATE VIEW [model].[KeyDatesCLE] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   26-04-2019
-- Reason               :   Single Row view for Key Dates (CLE) to display in power bi model
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	13-07-2019
-- Reason               :	Changed Key Dates to use AT TIME ZONE instead of DATEADD
------------------------------------------------------------------------------------------

WITH AlertsHWM AS (
SELECT MAX(CAST(HighWaterMark AS INT)) AS HighWaterMark
FROM WCG_DW.dbo.DimDeltaLog WHERE ObjectName = 'Alerts'
)

,SightingsHWM AS (
SELECT MAX(CAST(HighWaterMark AS INT)) AS HighWaterMark
FROM WCG_DW.dbo.DimDeltaLog WHERE ObjectName = 'Sightings'
)

SELECT 
	LastAlertDate, LastSightingDate
FROM (
		SELECT 'LastAlertDate' AS Name, CAST(MAX(AlertDateTime AT TIME ZONE 'South Africa Standard Time') AS DATETIME) AS KeyDate
		FROM WCG_Stage.cle.Alerts stg
		INNER JOIN AlertsHWM hwm ON stg.AlertRecordId = hwm.HighWaterMark
		UNION ALL
		SELECT 'LastSightingDate' AS Name, CAST(MAX(Timestamp AT TIME ZONE 'South Africa Standard Time') AS DATETIME) AS KeyDate
		FROM WCG_Stage.cle.Sightings stg
		INNER JOIN SightingsHWM hwm ON stg.SightingRecordId = hwm.HighWaterMark
) AS SourceTable
PIVOT
(
MAX(KeyDate)
FOR Name IN ([LastAlertDate], [LastSightingDate])
) AS PivotTable
