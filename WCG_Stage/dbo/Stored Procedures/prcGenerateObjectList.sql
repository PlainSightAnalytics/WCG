
CREATE PROCEDURE [dbo].[prcGenerateObjectList]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-11-2019
-- Reason				:	Scans databases and folders for and list Objects
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	None
-- Ouputs				:	None
-- Test					:	[dbo].[prcGenerateObjectList]
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

AS

-- To allow advanced options to be changed.  
EXEC sp_configure 'show advanced options', 1;  

-- To update the currently configured value for advanced options.  
RECONFIGURE;  

-- To enable the feature.  
EXEC sp_configure 'xp_cmdshell', 1;  

-- To update the currently configured value for this feature.  
RECONFIGURE;  

DROP TABLE IF EXISTS tempList

CREATE TABLE tempList (Files VARCHAR(500) collate SQL_Latin1_General_CP1_CI_AS, ObjectLocation VARCHAR(500) collate SQL_Latin1_General_CP1_CI_AS, FileDate VARCHAR(20) collate SQL_Latin1_General_CP1_CI_AS ) 

INSERT INTO tempList (Files)
EXEC MASTER..XP_CMDSHELL 'dir D:\PSA\WCG\PS\*.ps1'

UPDATE templist set ObjectLocation = 'D:\WCG\ps' where ObjectLocation IS NULL

--delete all directories
DELETE tempList WHERE Files LIKE '%<dir>%'

--delete all informational messages
DELETE tempList WHERE Files LIKE ' %'

--delete the null values
DELETE tempList WHERE Files IS NULL

DELETE templist WHERE  Files LIKE 'Volume in drive%'
DELETE templist WHERE  Files LIKE 'Volume Serial Number%'
DELETE templist WHERE  Files LIKE 'Directory of %'

--split dateinfo
UPDATE tempList SET FileDate =LEFT(files,20)

--get rid of dateinfo
UPDATE tempList SET files =RIGHT(files,(LEN(files)-20))

--get rid of leading spaces
UPDATE tempList SET files =LTRIM(files)

;with objectcte as (
select
	'WCG_DW.' + s.name + '.' + o.name as ObjectNameFull 
	,'WCG_DW' AS DatabaseName
	,o.name AS ObjectName
	,s.name AS SchemaName
	,cast(o.create_date as datetime) as CreateDate
	,o.modify_date as ModifyDate
	,o.type AS SQLType
from wcg_dw.sys.objects o 
left join wcg_dw.sys.schemas s on o.schema_id = s.schema_id
where type not in ('D','F','IT','S','SQ', 'PK','UQ')
union all
select
	'WCG_Stage.' + s.name + '.' + o.name as ObjectNameFull 
	,'WCG_Stage' AS DatabaseName
	,o.name AS ObjectName
	,s.name AS SchemaName
	,o.create_date as CreateDate
	,o.modify_date as ModifyDate
	,o.type AS SQLType
from WCG_Stage.sys.objects o 
left join WCG_Stage.sys.schemas s on o.schema_id = s.schema_id
where type not in ('D','F','IT','S','SQ', 'PK','UQ')
and o.name NOT like '%diagram%'
and o.name <> 'tempList'
union all
select
	'PowerBIDB1.' + s.name + '.' + o.name as ObjectNameFull 
	,'PowerBIDB1' AS DatabaseName
	,o.name AS ObjectName
	,s.name AS SchemaName
	,o.create_date as CreateDate
	,o.modify_date as ModifyDate
	,o.type AS SQLType
from PowerBIDB1.sys.objects o 
left join PowerBIDB1.sys.schemas s on o.schema_id = s.schema_id
where type not in ('D','F','IT','S','SQ', 'PK','UQ')
and o.name NOT like '%diagram%'
union all
--split data into size and filename
SELECT 
	'ps\' + RIGHT(files,LEN(files) -PATINDEX('% %',files)) AS ObjectNameFull
	,ObjectLocation AS DatabaseName
	,RIGHT(files,LEN(files) -PATINDEX('% %',files)) AS ObjectName
	,'ps1' AS SchemaName
	,NULL AS CreateDate
	,FileDate AS ModifyDate
	,NULL AS SQLType
FROM tempList 
)

select 
	 CAST(FORMAT(ModifyDate,'yyyyMMdd') AS INT) AS ModifyDateKey
	,CAST(ObjectNameFull AS VARCHAR(100)) AS ObjectNameFull
	,CAST(DatabaseName AS VARCHAR(50)) AS DatabaseName
	,CAST(ObjectName AS VARCHAR(100)) AS ObjectName
	,CAST(SchemaName AS VARCHAR(10)) AS SchemaName
	,CAST(CreateDate AS DATETIME) AS CreateDate
	,CAST(ModifyDate AS DATETIME) AS ModifyDate
	,CAST(SQLType AS VARCHAR(10)) AS SQLType
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
from objectcte;

DROP TABLE IF EXISTS tempList;

-- To enable the feature.  
EXEC sp_configure 'xp_cmdshell', 0;  

-- To update the currently configured value for this feature.  
RECONFIGURE;