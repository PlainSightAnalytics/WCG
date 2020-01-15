

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

SELECT
	 CAST(o.create_date AS DATETIME)								AS CreateDateTime
	,CAST(o.modify_date AS DATETIME)								AS LastModifiedDateTime
	,CAST('PowerBIDB1' AS VARCHAR(50))								AS LocationName
	,CAST('PowerBIDB1.' + s.name + '.' + o.name AS VARCHAR(100))	AS ObjectFullName
	,CAST(o.name AS VARCHAR(50))									AS ObjectName
	,CAST(CASE
		WHEN o.type = 'U' AND s.name = 'model' THEN 'Model Table'
		ELSE 'Uncategorised'
	END AS VARCHAR(30)) AS ObjectType
	,NULL AS ObjectTypeOrder
	,CAST(NULL AS VARCHAR(50)) AS ParentObjectName
	,NULL AS ParentObjectOrder
	,CAST(s.name AS VARCHAR(10)) AS SchemaName
FROM sys.objects o 
LEFT JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE 
	o.type NOT IN ('D','F','IT','S','SQ', 'PK','UQ')
AND o.name NOT LIKE '%diagram%'