

CREATE VIEW [meta].[transformDimObject] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	21-12-2019
-- Reason				:	Transform view for DimObject
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
 CreateDateTime										AS CreateDateTime
,LastModifiedDateTime								AS LastModifiedDateTime
,ObjectFullName										AS ObjectFullName
,LocationName										AS ObjectLocation
,ObjectName											AS ObjectName
,ObjectType											AS ObjectType
,CASE ObjectType
	WHEN 'Journey Table' THEN 1
	WHEN 'Master PowerShell Script' THEN 2
	WHEN 'PowerShell Script' THEN 3
	WHEN 'Extract Stored Procedure' THEN 4
	WHEN 'Stage Table' THEN 5
	WHEN 'Transform View' THEN 6
	WHEN 'Conform View' THEN 7
	WHEN 'Conform Table' THEN 8
	WHEN 'Surrogate Pipeline View' THEN 9
	WHEN 'Dimension Load Stored Procedure' THEN 10
	WHEN 'Fact Load Stored Procedure' THEN 11
	WHEN 'Dimension Table' THEN 12
	WHEN 'Fact Table' THEN 13
	WHEN 'Semantic View' THEN 14
	WHEN 'Model Table' THEN 15
	WHEN 'Stage Stored Procedure' THEN 16
	ELSE 99
END  												AS ObjectTypeOrder  
,ISNULL(ParentObjectName,'No Parent')				AS ParentObject
,ISNULL(ParentObjectOrder,0)						AS ParentObjectOrder
,CAST(ISNULL(SchemaName,'N/A') AS VARCHAR(10))		AS SchemaName
FROM WCG_Stage.dbo.ConformDimObject