CREATE VIEW [model].[vwObjectList] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   29-11-2019
-- Reason               :   View of object List
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

WITH cte AS (
SELECT
	'PowerBIDB1.' + s.name + '.' + o.name	AS ObjectNameFull 
	,'PowerBIDB1'							AS DatabaseName
	,o.name									AS ObjectName
	,s.name									AS SchemaName
	,o.create_date							AS CreateDate
	,o.modify_date							AS ModifyDate
	,o.type									AS SQLType
FROM sys.objects o 
LEFT JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE 
	o.type NOT IN ('D','F','IT','S','SQ', 'PK','UQ')
AND o.name NOT LIKE '%diagram%'
)

SELECT 
	 CAST(FORMAT(ModifyDate,'yyyyMMdd') AS INT) AS ModifyDateKey
	,CAST(ObjectNameFull AS VARCHAR(100))		AS ObjectNameFull
	,CAST(DatabaseName AS VARCHAR(50))			AS DatabaseName
	,CAST(ObjectName AS VARCHAR(100))			AS ObjectName
	,CAST(SchemaName AS VARCHAR(10))			AS SchemaName
	,CAST(CreateDate AS DATETIME)				AS CreateDate
	,CAST(ModifyDate AS DATETIME)				AS ModifyDate
	,CAST(SQLType AS VARCHAR(10))				AS SQLType
	,CAST(CASE
		WHEN SQLType = 'U' AND DatabaseName = 'WCG_Stage' AND SchemaName <> 'dbo' THEN '01. Stage Table'
		WHEN SQLType = 'P' AND DatabaseName = 'WCG_Stage'AND ObjectName like 'prcExtract%' THEN '02. Extract Stored Procedure'
		WHEN SQLType = 'V' AND DatabaseName = 'WCG_Stage' AND  ObjectName like 'transform%' THEN '03. Transform View'
		WHEN SQLType = 'P' AND DatabaseName = 'WCG_Stage'AND ObjectName like 'prcLoadDim%' THEN '04. Dimension Load Stored Procedure'
		WHEN SQLType = 'P' AND DatabaseName = 'WCG_Stage'AND ObjectName like 'prcLoadFact%' THEN '05. Fact Load Stored Procedure'
		WHEN SQLType = 'V' AND DatabaseName = 'WCG_Stage' AND  ObjectName like 'LoadFact%' THEN '06. Surrogate Pipeline View'
		WHEN SQLType = 'U' AND DatabaseName = 'WCG_DW' AND ObjectName like 'Dim%' THEN '07. Dimension Table'
		WHEN SQLType = 'U' AND DatabaseName = 'WCG_DW' AND ObjectName like 'Fact%' THEN '08. Fact Table'
		WHEN SQLType = 'V' AND DatabaseName = 'WCG_DW' AND SchemaName = 'model' THEN '09. Semantic View'
		WHEN SQLType = 'U' AND DatabaseName = 'PowerBIDB1' AND SchemaName = 'model' THEN '10. Model Table'
		WHEN SQLType = 'P' AND DatabaseName = 'WCG_Stage' THEN '99. Common Stage Stored Procedure'
		WHEN SQLType = 'V' AND DatabaseName = 'WCG_DW' THEN '99. Other DW View'
		WHEN SQLType IS NULL THEN '11. Powershell Script'
		ELSE '00. Uncategorised'
	END AS VARCHAR(50)) AS ObjectType
FROM cte