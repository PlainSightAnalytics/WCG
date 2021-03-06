﻿CREATE VIEW [model].[Schema Comparison] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   20-12-2019
-- Reason               :   Semantic View for Journey vs Stage tables
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

WITH StageColumnsCTE AS (
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
AND c.name NOT IN ('AuditKey','DeltaLogKey')
)

,StageNotJourneyCTE AS (
SELECT * FROM StageColumnsCTE
EXCEPT
SELECT JourneySchema, JourneyTable, JourneyColumn
FROM  WCG_Stage.dbo.JourneyColumns
)

,JourneyNotStageCTE AS (
SELECT JourneySchema, JourneyTable, JourneyColumn
FROM WCG_Stage.dbo.JourneyColumns
EXCEPT
SELECT * FROM StageColumnsCTE
)

,JourneyAndStageCTE AS (
SELECT * FROM StageColumnsCTE
INTERSECT
SELECT JourneySchema, JourneyTable, JourneyColumn
FROM WCG_Stage.dbo.JourneyColumns
)

SELECT 
	CASE StageSchema
		WHEN 'itis' THEN 'ITIS'
		WHEN 'ebat' THEN 'EBAT'
		WHEN 'pnd' THEN 'Impoundment'
	END										AS JourneySystem
	,StageSchema							AS SchemaName
	,StageTable								AS TableName
	,StageColumn							AS ColumnName
	,'Deleted'								AS Status 
FROM StageNotJourneyCTE
UNION ALL
SELECT
	CASE JourneySChema
		WHEN 'itis' THEN 'ITIS'
		WHEN 'ebat' THEN 'EBAT'
		WHEN 'pnd' THEN 'Impoundment'
	END										AS JourneySystem
	,JourneySChema							AS SchemaName
	,JourneyTable							AS TableName
	,JourneyColumn							AS ColumnName
	 ,'New'									AS Status 
FROM JourneyNotStageCTE
UNION ALl
SELECT
	CASE StageSchema
		WHEN 'itis' THEN 'ITIS'
		WHEN 'ebat' THEN 'EBAT'
		WHEN 'pnd' THEN 'Impoundment'
	END										AS JourneySystem
	,StageSchema							AS SchemaName
	,StageTable								AS TableName
	,StageColumn							AS ColumnName
	 ,'Match'								AS Status 
FROM JourneyAndStageCTE