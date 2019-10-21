


CREATE PROCEDURE [dbo].[prcInsertDimAudit]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-06-2016
-- Reason				:	Adds record to DimAudit
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@TableName, @ScriptName
-- Ouputs				:	AuditKey
-- 
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------
@ClientName			VARCHAR(50) = 'Unknown',
@SchemaName			VARCHAR(50) = 'Unknown',
@TableName			VARCHAR(50) = 'Unknown',
@ScriptName			VARCHAR(50) = 'Unknown',
@AuditKey			INT OUTPUT

AS

SET NOCOUNT ON

/* Declare Variables */
DECLARE @RowCountInitial AS INT = 0

/* Get Initial Row Count */
IF @TableName LIKE 'Dim%' OR @TableName LIKE 'Fact%'
	SELECT @RowCountInitial = SUM(row_count) 
	FROM WCG_DW.sys.objects o
	LEFT JOIN WCG_DW.sys.schemas s ON o.schema_id = s.schema_id
	LEFT JOIN WCG_DW.sys.dm_db_partition_stats p ON o.object_id = p.object_id
	WHERE o.name = @TableName
	and s.name = 'dbo'
	AND index_id < 2
ELSE
	SELECT @RowCountInitial = SUM(row_count) 
	FROM sys.objects o
	LEFT JOIN sys.schemas s ON o.schema_id = s.schema_id
	LEFT JOIN sys.dm_db_partition_stats p ON o.object_id = p.object_id
	WHERE o.name = @TableName
	and s.name = @SchemaName
	AND index_id < 2

/* Insert Record */
INSERT INTO WCG_DW.dbo.DimAudit 
(TableName, ClientName, SchemaName, ScriptName, DateTimeStart, RowCountInitial)
VALUES (@TableName, @ClientName, @SchemaName, @ScriptName, GETDATE(), @RowCountInitial)

/* Return Audit Id */
SET @AuditKey =  CAST(IDENT_CURRENT( 'WCG_DW.dbo.DimAudit' ) AS INT) 




;
;
