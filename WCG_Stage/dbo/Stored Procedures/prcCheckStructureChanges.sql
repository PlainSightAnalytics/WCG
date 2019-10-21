



CREATE PROCEDURE [dbo].[prcCheckStructureChanges]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	29-12-2018
-- Reason				:	Compares stage and sample tables for new and redundant fields
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@StageSchema, @SampleSchema
-- Ouputs				:	AuditLogKey
-- Test					:	prcCheckStructureChanges 
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@StageSchema			VARCHAR(50) = 'itis',
@SampleSchema			VARCHAR(50) = 'its'

AS

/* Create Table if it does not exist */
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[StageTablesAndColumns]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[StageTablesAndColumns](
[DatabaseName] [varchar](50) NULL,
[TableName] varchar(50) NULL,
[ColumnName] varchar (50) NULL,
[Status] varchar (20)
) ON [PRIMARY]
END

/* Truncate Table */
TRUNCATE TABLE dbo.StageTablesAndColumns

;WITH CTE AS (
SELECT
	 s.name AS SchemaName
	,o.name AS TableName
	,c.name AS ColumnName
	,1 AS rc
FROM sys.objects o
LEFT JOIN sys.columns c ON o.object_id = c.object_id
LEFT JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE s.name = @StageSchema
AND o.type = 'U'
UNION ALL
SELECT
	 s.name AS SchemaName
	,o.name AS TableName
	,c.name AS ColumnName
	,1 AS rc
FROM sys.objects o
LEFT JOIN sys.columns c ON o.object_id = c.object_id
LEFT JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE s.name = @SampleSchema
AND o.type = 'U'
)

INSERT INTO dbo.StageTablesAndColumns
(DatabaseName, TableName, ColumnName, Status)
SELECT DB_NAME() AS DatabaseName, TableName, ColumnName, 
CASE WHEN itis IS NULL THEN 'New'
WHEN its IS NULL THEN 'Redundant'
ELSE 'No Change' END AS Status
FROM  
(SELECT * FROM CTE
WHERE ColumnName NOT IN ('AuditLogKey','DeltaLogKey','AuditKey')) AS SourceTable  
PIVOT  
(  
AVG(rc)  
FOR SchemaName IN ([itis], [its])  
) AS PivotTable  
ORDER BY Tablename, ColumnName


