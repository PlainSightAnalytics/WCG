
CREATE PROCEDURE [itis].[prcExtracttask]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-04-2018 01:33:29
-- Reason				:	Reads JSON file and inserts data into Stage table (task)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtracttask 'D:\PSA\TCE2\sample\task.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[task]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[task] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[location_id], ' + CHAR(13)
SET @sql = @sql + '[shift_id], ' + CHAR(13)
SET @sql = @sql + '[task_description_id], ' + CHAR(13)
SET @sql = @sql + '[task_template_group_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[adhoc_key], ' + CHAR(13)
SET @sql = @sql + '[adhoc_display], ' + CHAR(13)
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[date], ' + CHAR(13)
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[duration_key], ' + CHAR(13)
SET @sql = @sql + '[duration_display], ' + CHAR(13)
SET @sql = @sql + '[end_datetime], ' + CHAR(13)
SET @sql = @sql + '[end_time], ' + CHAR(13)
SET @sql = @sql + '[other_location], ' + CHAR(13)
SET @sql = @sql + '[sort], ' + CHAR(13)
SET @sql = @sql + '[start_datetime], ' + CHAR(13)
SET @sql = @sql + '[start_time], ' + CHAR(13)
SET @sql = @sql + '[task_template_group_name], ' + CHAR(13)
SET @sql = @sql + '[temp_template_store], ' + CHAR(13)
SET @sql = @sql + '[temp_template_store_desc], ' + CHAR(13)
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
SET @sql = @sql + '[location_id], ' + CHAR(13)
SET @sql = @sql + '[shift_id], ' + CHAR(13)
SET @sql = @sql + '[task_description_id], ' + CHAR(13)
SET @sql = @sql + '[task_template_group_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[adhoc_key], ' + CHAR(13)
SET @sql = @sql + '[adhoc_display], ' + CHAR(13)
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[date], ' + CHAR(13)
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[duration_key], ' + CHAR(13)
SET @sql = @sql + '[duration_display], ' + CHAR(13)
SET @sql = @sql + '[end_datetime], ' + CHAR(13)
SET @sql = @sql + '[end_time], ' + CHAR(13)
SET @sql = @sql + '[other_location], ' + CHAR(13)
SET @sql = @sql + '[sort], ' + CHAR(13)
SET @sql = @sql + '[start_datetime], ' + CHAR(13)
SET @sql = @sql + '[start_time], ' + CHAR(13)
SET @sql = @sql + '[task_template_group_name], ' + CHAR(13)
SET @sql = @sql + '[temp_template_store], ' + CHAR(13)
SET @sql = @sql + '[temp_template_store_desc], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[location_id] [varchar](max) ''$.location_id'',' + CHAR(13)
SET @sql = @sql + '[shift_id] [varchar](max) ''$.shift_id'',' + CHAR(13)
SET @sql = @sql + '[task_description_id] [varchar](max) ''$.task_description_id'',' + CHAR(13)
SET @sql = @sql + '[task_template_group_id] [varchar](max) ''$.task_template_group_id'',' + CHAR(13)
SET @sql = @sql + '[user_id] [varchar](max) ''$.user_id'',' + CHAR(13)
SET @sql = @sql + '[adhoc_key] [varchar](max) ''$.adhoc.key'',' + CHAR(13)
SET @sql = @sql + '[adhoc_display] [varchar](max) ''$.adhoc.display'',' + CHAR(13)
SET @sql = @sql + '[archived_key] [varchar](max) ''$.archived.key'',' + CHAR(13)
SET @sql = @sql + '[archived_display] [varchar](max) ''$.archived.display'',' + CHAR(13)
SET @sql = @sql + '[date] [varchar](max) ''$.date'',' + CHAR(13)
SET @sql = @sql + '[description] [varchar](max) ''$.description'',' + CHAR(13)
SET @sql = @sql + '[duration_key] [varchar](max) ''$.duration.key'',' + CHAR(13)
SET @sql = @sql + '[duration_display] [varchar](max) ''$.duration.display'',' + CHAR(13)
SET @sql = @sql + '[end_datetime] [varchar](max) ''$.end_datetime'',' + CHAR(13)
SET @sql = @sql + '[end_time] [varchar](max) ''$.end_time'',' + CHAR(13)
SET @sql = @sql + '[other_location] [varchar](max) ''$.other_location'',' + CHAR(13)
SET @sql = @sql + '[sort] [varchar](max) ''$.sort'',' + CHAR(13)
SET @sql = @sql + '[start_datetime] [varchar](max) ''$.start_datetime'',' + CHAR(13)
SET @sql = @sql + '[start_time] [varchar](max) ''$.start_time'',' + CHAR(13)
SET @sql = @sql + '[task_template_group_name] [varchar](max) ''$.task_template_group_name'',' + CHAR(13)
SET @sql = @sql + '[temp_template_store] [varchar](max) ''$.temp_template_store'',' + CHAR(13)
SET @sql = @sql + '[temp_template_store_desc] [varchar](max) ''$.temp_template_store_desc''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

