
CREATE PROCEDURE [itis].[prcExtracttraffic_centre]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	23-09-2018 04:26:41
-- Reason				:	Reads JSON file and inserts data into Stage table (traffic_centre)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec stage.prcExtracttraffic_centre 'D:\PSA\WCG\changes\201809 - Row Level Security\traffic_centre.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[traffic_centre]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[traffic_centre] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[magistrates_court_id], ' + CHAR(13)
SET @sql = @sql + '[regional_area_id], ' + CHAR(13)
SET @sql = @sql + '[email], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[power_bi_users], ' + CHAR(13)
SET @sql = @sql + '[section_56_email], ' + CHAR(13)
SET @sql = @sql + '[telephone_number], ' + CHAR(13)
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
SET @sql = @sql + '[magistrates_court_id], ' + CHAR(13)
SET @sql = @sql + '[regional_area_id], ' + CHAR(13)
SET @sql = @sql + '[email], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[power_bi_users], ' + CHAR(13)
SET @sql = @sql + '[section_56_email], ' + CHAR(13)
SET @sql = @sql + '[telephone_number], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[magistrates_court_id] [varchar](max) ''$.magistrates_court_id'',' + CHAR(13)
SET @sql = @sql + '[regional_area_id] [varchar](max) ''$.regional_area_id'',' + CHAR(13)
SET @sql = @sql + '[email] [varchar](max) ''$.email'',' + CHAR(13)
SET @sql = @sql + '[name] [varchar](max) ''$.name'',' + CHAR(13)
SET @sql = @sql + '[power_bi_users] [varchar](max) ''$.power_bi_users'',' + CHAR(13)
SET @sql = @sql + '[section_56_email] [varchar](max) ''$.section_56_email'',' + CHAR(13)
SET @sql = @sql + '[telephone_number] [varchar](max) ''$.telephone_number''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

