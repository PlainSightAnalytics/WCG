


CREATE PROCEDURE [dbo].[prcInsertDimDeltaLog]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	13-06-2016
-- Reason				:	Adds record to DimDeltaLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ClientName, SchemaName, ObjectName
-- Ouputs				:	DeltaLogKey
-- 
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------
@ClientName			VARCHAR(50) = 'Unknown',
@SchemaName			VARCHAR(50) = 'Unknown',
@ObjectName			VARCHAR(50) = 'Unknown',
@RowCountSource		INT= 0,
@AuditKey			INT = 0,
@DeltaLogKey		INT OUTPUT

AS

SET NOCOUNT ON

/* Insert Record */
INSERT INTO WCG_DW.dbo.DimDeltaLog 
(ClientName, SchemaName, ObjectName, LogDate, RowCountSource, InsertAuditKey, UpdateAuditKey)
VALUES (@ClientName, @SchemaName, @ObjectName, GETDATE(), @RowCountSource, @AuditKey, @AuditKey)

/* Return Audit Id */
SET @DeltaLogKey =  CAST(IDENT_CURRENT( 'WCG_DW.dbo.DimDeltaLog' ) AS INT) 





;
;