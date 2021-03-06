﻿

CREATE PROCEDURE [itis].[prcExtractshift]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-04-2018 01:33:29
-- Reason				:	Reads JSON file and inserts data into Stage table (shift)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractshift 'D:\PSA\TCE2\sample\shift.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[shift]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[shift] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[master_shift_id], ' + CHAR(13)
SET @sql = @sql + '[roster_id], ' + CHAR(13)
SET @sql = @sql + '[shift_time_id], ' + CHAR(13)
SET @sql = @sql + '[shift_week_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[acknowledged_key], ' + CHAR(13)
SET @sql = @sql + '[acknowledged_display], ' + CHAR(13)
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[date], ' + CHAR(13)
SET @sql = @sql + '[deleted_key], ' + CHAR(13)
SET @sql = @sql + '[deleted_display], ' + CHAR(13)
SET @sql = @sql + '[submission_datetime], ' + CHAR(13)
SET @sql = @sql + '[user_shift_key], ' + CHAR(13)
SET @sql = @sql + '[user_shift_display], ' + CHAR(13)
SET @sql = @sql + '[week_day_key], ' + CHAR(13)
SET @sql = @sql + '[week_day_display], ' + CHAR(13)
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
SET @sql = @sql + '[master_shift_id], ' + CHAR(13)
SET @sql = @sql + '[roster_id], ' + CHAR(13)
SET @sql = @sql + '[shift_time_id], ' + CHAR(13)
SET @sql = @sql + '[shift_week_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[acknowledged_key], ' + CHAR(13)
SET @sql = @sql + '[acknowledged_display], ' + CHAR(13)
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[date], ' + CHAR(13)
SET @sql = @sql + '[deleted_key], ' + CHAR(13)
SET @sql = @sql + '[deleted_display], ' + CHAR(13)
SET @sql = @sql + '[submission_datetime], ' + CHAR(13)
SET @sql = @sql + '[user_shift_key], ' + CHAR(13)
SET @sql = @sql + '[user_shift_display], ' + CHAR(13)
SET @sql = @sql + '[week_day_key], ' + CHAR(13)
SET @sql = @sql + '[week_day_display], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[master_shift_id] [varchar](max) ''$.master_shift_id'',' + CHAR(13)
SET @sql = @sql + '[roster_id] [varchar](max) ''$.roster_id'',' + CHAR(13)
SET @sql = @sql + '[shift_time_id] [varchar](max) ''$.shift_time_id'',' + CHAR(13)
SET @sql = @sql + '[shift_week_id] [varchar](max) ''$.shift_week_id'',' + CHAR(13)
SET @sql = @sql + '[user_id] [varchar](max) ''$.user_id'',' + CHAR(13)
SET @sql = @sql + '[acknowledged_key] [varchar](max) ''$.acknowledged.key'',' + CHAR(13)
SET @sql = @sql + '[acknowledged_display] [varchar](max) ''$.acknowledged.display'',' + CHAR(13)
SET @sql = @sql + '[archived_key] [varchar](max) ''$.archived.key'',' + CHAR(13)
SET @sql = @sql + '[archived_display] [varchar](max) ''$.archived.display'',' + CHAR(13)
SET @sql = @sql + '[date] [varchar](max) ''$.date'',' + CHAR(13)
SET @sql = @sql + '[deleted_key] [varchar](max) ''$.deleted.key'',' + CHAR(13)
SET @sql = @sql + '[deleted_display] [varchar](max) ''$.deleted.display'',' + CHAR(13)
SET @sql = @sql + '[submission_datetime] [varchar](max) ''$.submission_datetime'',' + CHAR(13)
SET @sql = @sql + '[user_shift_key] [varchar](max) ''$.user_shift.key'',' + CHAR(13)
SET @sql = @sql + '[user_shift_display] [varchar](max) ''$.user_shift.display'',' + CHAR(13)
SET @sql = @sql + '[week_day_key] [varchar](max) ''$.week_day.key'',' + CHAR(13)
SET @sql = @sql + '[week_day_display] [varchar](max) ''$.week_day.display''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)


