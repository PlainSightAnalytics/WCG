
CREATE VIEW [meta].[JourneyTablesColumnsAudit] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-08-2016
-- Reason				:	Transform view for Vehicle
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

WITH StageTablesCTE AS (
SELECT
	 s.name AS StageSchema
	,o.name AS StageTable
,SUM(p.rows) AS TableRows
FROM WCG_Stage.sys.objects o
LEFT JOIN WCG_Stage.sys.schemas s ON o.schema_id = s.schema_id
LEFT JOIN WCG_Stage.sys.partitions p ON o.object_id = p.object_id
WHERE 
	s.name IN ('itis','ebat','pnd')
AND o.type = 'U'
GROUP BY s.name, o.name
)

,StageColumnsCTE AS (
SELECT
	 s.name AS StageSchema
	,o.name AS StageTable
	,c.name AS StageColumn
FROM WCG_Stage.sys.objects o
LEFT JOIN WCG_Stage.sys.schemas s ON o.schema_id = s.schema_id
LEFT JOIN WCG_Stage.sys.columns c ON o.object_id = c.object_id
WHERE 
	s.name IN ('itis','ebat','pnd')
AND o.type = 'U'
)

,StageJourneyCompare AS (
SELECT
	 j.JourneySchema
	,j.JourneyTable
	,j.JourneyColumn
	,t.StageTable
	,c.StageColumn
	,CASE
		WHEN t.StageTable IS NULL THEN 'Unused Table'
		WHEN c.StageColumn IS NULL THEN 'Unused Column'
		WHEN j.JourneySchema = c.StageSchema AND j.JourneyTable = c.StageTable AND j.JourneyColumn = c.StageColumn THEN 'Match'
		ELSE 'Unknown'
	END AS Status
	,CASE
		WHEN t.StageTable IS NULL THEN 'All Columns'
		ELSE JourneyColumn
	END AS ColumnDisplay
FROM JourneyColumns j
LEFT JOIN StageTablesCTE t ON j.JourneySchema = t.StageSchema AND j.JourneyTable = t.StageTable
LEFT JOIN StageColumnsCTE c ON j.JourneySchema = c.StageSchema AND j.JourneyTable = c.StageTable AND j.JourneyColumn = c.StageColumn
)

SELECT 
	 CASE JourneySchema
		WHEN 'itis' THEN 'ITIS'
		WHEN 'ebat' THEN 'EBAT'
		WHEN 'pnd' THEN 'Impoundment'
	END AS JourneySystem
	,Status
	,JourneyTable
	,ColumnDisplay
FROM StageJourneyCompare