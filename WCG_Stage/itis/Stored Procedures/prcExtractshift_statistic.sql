
CREATE PROCEDURE [itis].[prcExtractshift_statistic]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-04-2018 01:33:29
-- Reason				:	Reads JSON file and inserts data into Stage table (shift_statistic)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractshift_statistic 'D:\PSA\TCE2\sample\shift_statistic.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[shift_statistic]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[shift_statistic] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[admin_id], ' + CHAR(13)
SET @sql = @sql + '[inspector_id], ' + CHAR(13)
SET @sql = @sql + '[shift_id], ' + CHAR(13)
SET @sql = @sql + '[superior_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[completed_at], ' + CHAR(13)
SET @sql = @sql + '[date], ' + CHAR(13)
SET @sql = @sql + '[manual_tle006], ' + CHAR(13)
SET @sql = @sql + '[no_manual_section_56_statistics_key], ' + CHAR(13)
SET @sql = @sql + '[no_manual_section_56_statistics_display], ' + CHAR(13)
SET @sql = @sql + '[opened_at], ' + CHAR(13)
SET @sql = @sql + '[pedestrian_arrests], ' + CHAR(13)
SET @sql = @sql + '[report_type_key], ' + CHAR(13)
SET @sql = @sql + '[report_type_display], ' + CHAR(13)
SET @sql = @sql + '[signature], ' + CHAR(13)
SET @sql = @sql + '[status_key], ' + CHAR(13)
SET @sql = @sql + '[status_display], ' + CHAR(13)
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
SET @sql = @sql + '[admin_id], ' + CHAR(13)
SET @sql = @sql + '[inspector_id], ' + CHAR(13)
SET @sql = @sql + '[shift_id], ' + CHAR(13)
SET @sql = @sql + '[superior_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[completed_at], ' + CHAR(13)
SET @sql = @sql + '[date], ' + CHAR(13)
SET @sql = @sql + '[manual_tle006], ' + CHAR(13)
SET @sql = @sql + '[no_manual_section_56_statistics_key], ' + CHAR(13)
SET @sql = @sql + '[no_manual_section_56_statistics_display], ' + CHAR(13)
SET @sql = @sql + '[opened_at], ' + CHAR(13)
SET @sql = @sql + '[pedestrian_arrests], ' + CHAR(13)
SET @sql = @sql + '[report_type_key], ' + CHAR(13)
SET @sql = @sql + '[report_type_display], ' + CHAR(13)
SET @sql = @sql + '[signature], ' + CHAR(13)
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
SET @sql = @sql + '[admin_id] [varchar](max) ''$.admin_id'',' + CHAR(13)
SET @sql = @sql + '[inspector_id] [varchar](max) ''$.inspector_id'',' + CHAR(13)
SET @sql = @sql + '[shift_id] [varchar](max) ''$.shift_id'',' + CHAR(13)
SET @sql = @sql + '[superior_id] [varchar](max) ''$.superior_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[completed_at] [varchar](max) ''$.completed_at'',' + CHAR(13)
SET @sql = @sql + '[date] [varchar](max) ''$.date'',' + CHAR(13)
SET @sql = @sql + '[manual_tle006] [varchar](max) ''$.manual_tle006'',' + CHAR(13)
SET @sql = @sql + '[no_manual_section_56_statistics_key] [varchar](max) ''$.no_manual_section_56_statistics.key'',' + CHAR(13)
SET @sql = @sql + '[no_manual_section_56_statistics_display] [varchar](max) ''$.no_manual_section_56_statistics.display'',' + CHAR(13)
SET @sql = @sql + '[opened_at] [varchar](max) ''$.opened_at'',' + CHAR(13)
SET @sql = @sql + '[pedestrian_arrests] [varchar](max) ''$.pedestrian_arrests'',' + CHAR(13)
SET @sql = @sql + '[report_type_key] [varchar](max) ''$.report_type.key'',' + CHAR(13)
SET @sql = @sql + '[report_type_display] [varchar](max) ''$.report_type.display'',' + CHAR(13)
SET @sql = @sql + '[signature] [varchar](max) ''$.signature'',' + CHAR(13)
SET @sql = @sql + '[status_key] [varchar](max) ''$.status.key'',' + CHAR(13)
SET @sql = @sql + '[status_display] [varchar](max) ''$.status.display''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

