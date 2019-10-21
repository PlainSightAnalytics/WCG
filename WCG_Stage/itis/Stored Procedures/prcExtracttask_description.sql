
CREATE PROCEDURE [itis].[prcExtracttask_description]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-04-2018 01:33:30
-- Reason				:	Reads JSON file and inserts data into Stage table (task_description)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtracttask_description 'D:\PSA\TCE2\sample\task_description.json'
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@FileName NVARCHAR(MAX),
@DeltaLogKey INT = -1,
@AuditKey INT = -1,
@TruncateFlag INT = 1

AS

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[task_description]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[task_description] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[measure], ' + CHAR(13)
SET @sql = @sql + '[period], ' + CHAR(13)
SET @sql = @sql + '[task_type_key], ' + CHAR(13)
SET @sql = @sql + '[task_type_display], ' + CHAR(13)
SET @sql = @sql + '[unit], ' + CHAR(13)
SET @sql = @sql + '[deltalogkey],' + CHAR(13)
SET @sql = @sql + '[AuditKey]' + CHAR(13)
--Insert End
SET @sql = @sql + ')' + CHAR(13)
SET @sql = @sql + 'SELECT ' 
--Select Begin
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[measure], ' + CHAR(13)
SET @sql = @sql + '[period], ' + CHAR(13)
SET @sql = @sql + '[task_type_key], ' + CHAR(13)
SET @sql = @sql + '[task_type_display], ' + CHAR(13)
SET @sql = @sql + '[unit], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[description] [varchar](max) ''$.description'',' + CHAR(13)
SET @sql = @sql + '[measure] [varchar](max) ''$.measure'',' + CHAR(13)
SET @sql = @sql + '[period] [varchar](max) ''$.period'',' + CHAR(13)
SET @sql = @sql + '[task_type_key] [varchar](max) ''$.task_type.key'',' + CHAR(13)
SET @sql = @sql + '[task_type_display] [varchar](max) ''$.task_type.display'',' + CHAR(13)
SET @sql = @sql + '[unit] [varchar](max) ''$.unit''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

