
CREATE PROCEDURE [itis].[prcExtractactivity]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-04-2018 01:33:27
-- Reason				:	Reads JSON file and inserts data into Stage table (activity)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractactivity 'D:\PSA\TCE2\sample\activity.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[activity]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[activity] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[device_id], ' + CHAR(13)
SET @sql = @sql + '[location_id], ' + CHAR(13)
SET @sql = @sql + '[operational_area_id], ' + CHAR(13)
SET @sql = @sql + '[shift_id], ' + CHAR(13)
SET @sql = @sql + '[shift_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[task_description_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[activity_type_key], ' + CHAR(13)
SET @sql = @sql + '[activity_type_display], ' + CHAR(13)
SET @sql = @sql + '[adhoc_key], ' + CHAR(13)
SET @sql = @sql + '[adhoc_display], ' + CHAR(13)
SET @sql = @sql + '[comments], ' + CHAR(13)
SET @sql = @sql + '[date], ' + CHAR(13)
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[end_time], ' + CHAR(13)
SET @sql = @sql + '[gps_latitude], ' + CHAR(13)
SET @sql = @sql + '[gps_longitude], ' + CHAR(13)
SET @sql = @sql + '[gps_altitude], ' + CHAR(13)
SET @sql = @sql + '[gps_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_timestamp], ' + CHAR(13)
SET @sql = @sql + '[other_location], ' + CHAR(13)
SET @sql = @sql + '[start], ' + CHAR(13)
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
SET @sql = @sql + '[device_id], ' + CHAR(13)
SET @sql = @sql + '[location_id], ' + CHAR(13)
SET @sql = @sql + '[operational_area_id], ' + CHAR(13)
SET @sql = @sql + '[shift_id], ' + CHAR(13)
SET @sql = @sql + '[shift_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[task_description_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[activity_type_key], ' + CHAR(13)
SET @sql = @sql + '[activity_type_display], ' + CHAR(13)
SET @sql = @sql + '[adhoc_key], ' + CHAR(13)
SET @sql = @sql + '[adhoc_display], ' + CHAR(13)
SET @sql = @sql + '[comments], ' + CHAR(13)
SET @sql = @sql + '[date], ' + CHAR(13)
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[end_time], ' + CHAR(13)
SET @sql = @sql + '[gps_latitude], ' + CHAR(13)
SET @sql = @sql + '[gps_longitude], ' + CHAR(13)
SET @sql = @sql + '[gps_altitude], ' + CHAR(13)
SET @sql = @sql + '[gps_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_timestamp], ' + CHAR(13)
SET @sql = @sql + '[other_location], ' + CHAR(13)
SET @sql = @sql + '[start], ' + CHAR(13)
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
SET @sql = @sql + '[device_id] [varchar](max) ''$.device_id'',' + CHAR(13)
SET @sql = @sql + '[location_id] [varchar](max) ''$.location_id'',' + CHAR(13)
SET @sql = @sql + '[operational_area_id] [varchar](max) ''$.operational_area_id'',' + CHAR(13)
SET @sql = @sql + '[shift_id] [varchar](max) ''$.shift_id'',' + CHAR(13)
SET @sql = @sql + '[shift_statistic_id] [varchar](max) ''$.shift_statistic_id'',' + CHAR(13)
SET @sql = @sql + '[task_description_id] [varchar](max) ''$.task_description_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[user_id] [varchar](max) ''$.user_id'',' + CHAR(13)
SET @sql = @sql + '[activity_type_key] [varchar](max) ''$.activity_type.key'',' + CHAR(13)
SET @sql = @sql + '[activity_type_display] [varchar](max) ''$.activity_type.display'',' + CHAR(13)
SET @sql = @sql + '[adhoc_key] [varchar](max) ''$.adhoc.key'',' + CHAR(13)
SET @sql = @sql + '[adhoc_display] [varchar](max) ''$.adhoc.display'',' + CHAR(13)
SET @sql = @sql + '[comments] [varchar](max) ''$.comments'',' + CHAR(13)
SET @sql = @sql + '[date] [varchar](max) ''$.date'',' + CHAR(13)
SET @sql = @sql + '[description] [varchar](max) ''$.description'',' + CHAR(13)
SET @sql = @sql + '[end_time] [varchar](max) ''$.end_time'',' + CHAR(13)
SET @sql = @sql + '[gps_latitude] [varchar](max) ''$.gps.latitude'',' + CHAR(13)
SET @sql = @sql + '[gps_longitude] [varchar](max) ''$.gps.longitude'',' + CHAR(13)
SET @sql = @sql + '[gps_altitude] [varchar](max) ''$.gps.altitude'',' + CHAR(13)
SET @sql = @sql + '[gps_horizontal_accuracy] [varchar](max) ''$.gps.horizontal_accuracy'',' + CHAR(13)
SET @sql = @sql + '[gps_vertical_accuracy] [varchar](max) ''$.gps.vertical_accuracy'',' + CHAR(13)
SET @sql = @sql + '[gps_timestamp] [varchar](max) ''$.gps.timestamp'',' + CHAR(13)
SET @sql = @sql + '[other_location] [varchar](max) ''$.other_location'',' + CHAR(13)
SET @sql = @sql + '[start] [varchar](max) ''$.start'',' + CHAR(13)
SET @sql = @sql + '[start_time] [varchar](max) ''$.start_time''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

