
CREATE PROCEDURE [itis].[prcExtractimpound_request]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	02-02-2019 01:55:11
-- Reason				:	Reads JSON file and inserts data into Stage table (impound_request)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractimpound_request 'D:\PSA\WCG\changes\WCG-0067 - Impound\itis\impound_request.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[impound_request]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[impound_request] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[event_id], ' + CHAR(13)
SET @sql = @sql + '[impound_id], ' + CHAR(13)
SET @sql = @sql + '[error_message], ' + CHAR(13)
SET @sql = @sql + '[override_key], ' + CHAR(13)
SET @sql = @sql + '[override_display], ' + CHAR(13)
SET @sql = @sql + '[override_reason], ' + CHAR(13)
SET @sql = @sql + '[status_key], ' + CHAR(13)
SET @sql = @sql + '[status_display], ' + CHAR(13)
SET @sql = @sql + '[deltalogkey],' + CHAR(13)
SET @sql = @sql + '[auditkey]' + CHAR(13)
--Insert End
SET @sql = @sql + ')' + CHAR(13)
SET @sql = @sql + 'SELECT ' 
--Select Begin
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
SET @sql = @sql + '[event_id], ' + CHAR(13)
SET @sql = @sql + '[impound_id], ' + CHAR(13)
SET @sql = @sql + '[error_message], ' + CHAR(13)
SET @sql = @sql + '[override_key], ' + CHAR(13)
SET @sql = @sql + '[override_display], ' + CHAR(13)
SET @sql = @sql + '[override_reason], ' + CHAR(13)
SET @sql = @sql + '[status_key], ' + CHAR(13)
SET @sql = @sql + '[status_display], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[event_id] [varchar](max) ''$.event_id'',' + CHAR(13)
SET @sql = @sql + '[impound_id] [varchar](max) ''$.impound_id'',' + CHAR(13)
SET @sql = @sql + '[error_message] [varchar](max) ''$.error_message'',' + CHAR(13)
SET @sql = @sql + '[override_key] [varchar](max) ''$.override.key'',' + CHAR(13)
SET @sql = @sql + '[override_display] [varchar](max) ''$.override.display'',' + CHAR(13)
SET @sql = @sql + '[override_reason] [varchar](max) ''$.override_reason'',' + CHAR(13)
SET @sql = @sql + '[status_key] [varchar](max) ''$.status.key'',' + CHAR(13)
SET @sql = @sql + '[status_display] [varchar](max) ''$.status.display''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

