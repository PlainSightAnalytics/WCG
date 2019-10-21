

CREATE PROCEDURE [dbo].[prcUpdateDimDeltaLog]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14-06-2016
-- Reason				:	Updates record on DimDeltaLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@DeltaLogKey, @AuditKey, @StageTable
-- Ouputs				:
-- Test					:	exec dbo.prcUpdateDimDeltaLog 6010, -1, 'ebat.ebat_report'
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@DeltaLogKey		INT,
@AuditKey			INT = -1,
@StageTable			VARCHAR(MAX)

AS

SET NOCOUNT ON

/* Declare Variables */
DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE ' + CHAR(13)
SET @sql = @sql + '@HighWaterDateTime AS VARCHAR(20), ' + CHAR(13)
SET @sql = @sql + '@RowCountStage AS INT' + CHAR(13)
SET @sql = @sql + CHAR(13)
SET @sql = @sql + 'SELECT @HighWaterDateTime = MAX(updated_at), ' + CHAR(13)
SET @sql = @sql + '	@RowCountStage = COUNT(1) ' + CHAR(13)
SET @sql = @sql + 'FROM ' + @StageTable + CHAR(13)
SET @sql = @sql + 'WHERE DeltaLogKey = ' + CAST(@DeltaLogKey AS VARCHAR(10)) + CHAR(13)
SET @sql = @sql + CHAR(13)
SET @sql = @sql + 'UPDATE WCG_DW.dbo.DimDeltaLog ' + CHAR(13)
SET @sql = @sql + 'SET ' + CHAR(13)
SET @sql = @sql + '	RowCountStage = @RowCountStage, ' + CHAR(13)
SET @sql = @sql + '	HighWaterDateTime = @HighWaterDateTime ' + CHAR(13)
SET @sql = @sql + 'WHERE DeltaLogKey = ' + CAST(@DeltaLogKey AS VARCHAR(10)) + CHAR(13)

EXEC (@sql)







;
;
