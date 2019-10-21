

CREATE PROCEDURE [itis].[prcExtractshift_time]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-04-2018 01:33:29
-- Reason				:	Reads JSON file and inserts data into Stage table (shift_time)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractshift_time 'D:\PSA\TCE2\sample\shift_time.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[shift_time]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[shift_time] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[end_time], ' + CHAR(13)
SET @sql = @sql + '[index], ' + CHAR(13)
SET @sql = @sql + '[off_duty_key], ' + CHAR(13)
SET @sql = @sql + '[off_duty_display], ' + CHAR(13)
SET @sql = @sql + '[start_time], ' + CHAR(13)
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
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[end_time], ' + CHAR(13)
SET @sql = @sql + '[index], ' + CHAR(13)
SET @sql = @sql + '[off_duty_key], ' + CHAR(13)
SET @sql = @sql + '[off_duty_display], ' + CHAR(13)
SET @sql = @sql + '[start_time], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[end_time] [varchar](max) ''$.end_time'',' + CHAR(13)
SET @sql = @sql + '[index] [varchar](max) ''$.index'',' + CHAR(13)
SET @sql = @sql + '[off_duty_key] [varchar](max) ''$.off_duty.key'',' + CHAR(13)
SET @sql = @sql + '[off_duty_display] [varchar](max) ''$.off_duty.display'',' + CHAR(13)
SET @sql = @sql + '[start_time] [varchar](max) ''$.start_time''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)


