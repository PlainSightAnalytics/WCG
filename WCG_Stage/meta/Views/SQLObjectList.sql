CREATE VIEW [meta].[SQLObjectList] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	21-12-2019
-- Reason				:	View of SQL Objects from various databases
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

WITH SQLObjectsCTE AS (
SELECT
	'WCG_DW.' + s.name + '.' + o.name		AS ObjectNameFull 
	,'WCG_DW'								AS DatabaseName
	,o.name									AS ObjectName
	,s.name									AS SchemaName
	,CAST(o.create_date AS DATETIME)		AS CreateDate
	,o.modify_date							AS ModifyDate
	,o.type									AS SQLType
FROM WCG_DW.sys.objects o 
LEFT JOIN WCG_DW.sys.schemas s 
	ON o.schema_id = s.schema_id
WHERE TYPE 
	NOT IN ('D','F','IT','S','SQ', 'PK','UQ')
UNION ALL
SELECT
	'WCG_Stage.' + s.name + '.' + o.name	AS ObjectNameFull 
	,'WCG_Stage'							AS DatabaseName
	,o.name									AS ObjectName
	,s.name									AS SchemaName
	,o.create_date							AS CreateDate
	,o.modify_date							AS ModifyDate
	,o.type									AS SQLType
FROM WCG_Stage.sys.objects o 
LEFT JOIN WCG_Stage.sys.schemas s 
	ON o.schema_id = s.schema_id
WHERE TYPE NOT IN ('D','F','IT','S','SQ', 'PK','UQ')
AND o.name NOT LIKE '%diagram%'
AND o.name <> 'tempList'
)

SELECT 
	 CAST(CreateDate AS DATETIME) AS CreateDateTime
	,CAST(ModifyDate AS DATETIME) AS LastModifiedDateTime
	,CAST(DatabaseName AS VARCHAR(50)) AS LocationName
	,CAST(ObjectNameFull AS VARCHAR(100)) AS ObjectFullName
	,CAST(ObjectName AS VARCHAR(50)) AS ObjectName
	,CAST(CASE
		WHEN SQLType = 'U' AND DatabaseName = 'WCG_Stage' AND SchemaName <> 'dbo' THEN 'Stage Table'
		WHEN SQLType = 'U' AND DatabaseName = 'WCG_Stage' AND SchemaName = 'dbo' AND ObjectName LIKE '%conform%' THEN 'Conform Table'
		WHEN SQLType = 'P' AND DatabaseName = 'WCG_Stage'AND ObjectName like 'prcExtract%' THEN 'Extract Stored Procedure'
		WHEN SQLType = 'V' AND DatabaseName = 'WCG_Stage' AND  ObjectName like 'transform%' THEN 'Transform View'
		WHEN SQLType = 'V' AND DatabaseName = 'WCG_Stage' AND  ObjectName like 'conform%' THEN 'Conform View'
		WHEN SQLType = 'P' AND DatabaseName = 'WCG_Stage'AND ObjectName like 'prcLoadDim%' THEN 'Dimension Load Stored Procedure'
		WHEN SQLType = 'P' AND DatabaseName = 'WCG_Stage'AND ObjectName like 'prcLoadFact%' THEN 'Fact Load Stored Procedure'
		WHEN SQLType = 'V' AND DatabaseName = 'WCG_Stage' AND  ObjectName like 'LoadFact%' THEN 'Surrogate Pipeline View'
		WHEN SQLType = 'U' AND DatabaseName = 'WCG_DW' AND ObjectName like 'Dim%' THEN 'Dimension Table'
		WHEN SQLType = 'U' AND DatabaseName = 'WCG_DW' AND ObjectName like 'Fact%' THEN 'Fact Table'
		WHEN SQLType = 'V' AND DatabaseName = 'WCG_DW' AND SchemaName = 'model' THEN 'Semantic View'
		WHEN SQLType = 'P' AND DatabaseName = 'WCG_Stage' THEN 'Stage Stored Procedure'
		WHEN SQLType = 'V' AND DatabaseName = 'WCG_DW' THEN 'DW View'
		ELSE 'Uncategorised'
	END AS VARCHAR(50)) AS ObjectType
	,NULL AS ObjectTypeOrder
	,CAST(NULL AS VARCHAR(50)) AS ParentObjectName
	,NULL AS ParentObjectOrder
	,CAST(SchemaName AS VARCHAR(10)) AS SchemaName
FROM SQLObjectsCTE