



CREATE PROCEDURE [dbo].[prcUpdateDimAudit]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-06-2016
-- Reason				:	Updates record on DimAudit
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	
-- Test					:	exec uspUpdateDimAudit 1012
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------
@AuditKey			INT 

AS

SET NOCOUNT ON

/* Declare Variables */
DECLARE 
	@RowCountFinal AS INT = 0,
	@SchemaName AS VARCHAR(50),
	@TableName AS VARCHAR(50)

/* Get Audit Values */
SELECT @SchemaName = SchemaName, @TableName = TableName
FROM WCG_DW.dbo.DimAudit
WHERE AuditKey = @AuditKey

/* Get Initial Row Count */
IF @TableName LIKE 'Dim%' OR @TableName LIKE 'Fact%'
	SELECT @RowCountFinal = SUM(row_count) 
	FROM WCG_DW.sys.objects o
	LEFT JOIN WCG_DW.sys.schemas s ON o.schema_id = s.schema_id
	LEFT JOIN WCG_DW.sys.dm_db_partition_stats p ON o.object_id = p.object_id
	WHERE o.name = @TableName
	and s.name = 'dbo'
	AND index_id < 2
ELSE
	SELECT @RowCountFinal = SUM(row_count) 
	FROM sys.objects o
	LEFT JOIN sys.schemas s ON o.schema_id = s.schema_id
	LEFT JOIN sys.dm_db_partition_stats p ON o.object_id = p.object_id
	WHERE o.name = @TableName
	and s.name = @SchemaName
	AND index_id < 2

/* Insert Record */
UPDATE WCG_DW.dbo.DimAudit 
SET 
	RowCountFinal = @RowCountFinal,
	RowCountInsert = @RowCountFinal - RowCountInitial,
	DateTimeStop = GETDATE(),
	Successful = 'Y'
WHERE AuditKey = @AuditKey




;
;
