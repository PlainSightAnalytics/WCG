
CREATE PROCEDURE [itis].[prcExtractapp_actual]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	26-05-2018 02:13:41
-- Reason				:	Reads JSON file and inserts data into Stage table (app_actual)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractapp_actual 'D:\PSA\TCE2\sample\app_actual.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[app_actual]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[app_actual] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[app_target_id], ' + CHAR(13)
SET @sql = @sql + '[calendar_month_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[adjusted_target], ' + CHAR(13)
SET @sql = @sql + '[date_created], ' + CHAR(13)
SET @sql = @sql + '[preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[target], ' + CHAR(13)
SET @sql = @sql + '[tc_comment], ' + CHAR(13)
SET @sql = @sql + '[verified_actual], ' + CHAR(13)
SET @sql = @sql + '[verifier_comment], ' + CHAR(13)
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
SET @sql = @sql + '[app_target_id], ' + CHAR(13)
SET @sql = @sql + '[calendar_month_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[adjusted_target], ' + CHAR(13)
SET @sql = @sql + '[date_created], ' + CHAR(13)
SET @sql = @sql + '[preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[target], ' + CHAR(13)
SET @sql = @sql + '[tc_comment], ' + CHAR(13)
SET @sql = @sql + '[verified_actual], ' + CHAR(13)
SET @sql = @sql + '[verifier_comment], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[app_target_id] [varchar](max) ''$.app_target_id'',' + CHAR(13)
SET @sql = @sql + '[calendar_month_id] [varchar](max) ''$.calendar_month_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[adjusted_target] [varchar](max) ''$.adjusted_target'',' + CHAR(13)
SET @sql = @sql + '[date_created] [varchar](max) ''$.date_created'',' + CHAR(13)
SET @sql = @sql + '[preliminary_actual] [varchar](max) ''$.preliminary_actual'',' + CHAR(13)
SET @sql = @sql + '[target] [varchar](max) ''$.target'',' + CHAR(13)
SET @sql = @sql + '[tc_comment] [varchar](max) ''$.tc_comment'',' + CHAR(13)
SET @sql = @sql + '[verified_actual] [varchar](max) ''$.verified_actual'',' + CHAR(13)
SET @sql = @sql + '[verifier_comment] [varchar](max) ''$.verifier_comment''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

