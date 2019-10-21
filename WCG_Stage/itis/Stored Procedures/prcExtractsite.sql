
CREATE PROCEDURE [itis].[prcExtractsite]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	02-05-2018 12:59:36
-- Reason				:	Reads JSON file and inserts data into Stage table (site)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractsite 'D:\PSA\TCE2\sample\site.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[site]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[site] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[gps_location_latitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_longitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_altitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_location_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_location_timestamp], ' + CHAR(13)
SET @sql = @sql + '[kilometer_distance], ' + CHAR(13)
SET @sql = @sql + '[location_description], ' + CHAR(13)
SET @sql = @sql + '[location_name], ' + CHAR(13)
SET @sql = @sql + '[location_name_short], ' + CHAR(13)
SET @sql = @sql + '[location_type_key], ' + CHAR(13)
SET @sql = @sql + '[location_type_display], ' + CHAR(13)
SET @sql = @sql + '[road_number], ' + CHAR(13)
SET @sql = @sql + '[road_section], ' + CHAR(13)
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
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[gps_location_latitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_longitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_altitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_location_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_location_timestamp], ' + CHAR(13)
SET @sql = @sql + '[kilometer_distance], ' + CHAR(13)
SET @sql = @sql + '[location_description], ' + CHAR(13)
SET @sql = @sql + '[location_name], ' + CHAR(13)
SET @sql = @sql + '[location_name_short], ' + CHAR(13)
SET @sql = @sql + '[location_type_key], ' + CHAR(13)
SET @sql = @sql + '[location_type_display], ' + CHAR(13)
SET @sql = @sql + '[road_number], ' + CHAR(13)
SET @sql = @sql + '[road_section], ' + CHAR(13)
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
SET @sql = @sql + '[gps_location_latitude] [varchar](max) ''$.gps_location.latitude'',' + CHAR(13)
SET @sql = @sql + '[gps_location_longitude] [varchar](max) ''$.gps_location.longitude'',' + CHAR(13)
SET @sql = @sql + '[gps_location_altitude] [varchar](max) ''$.gps_location.altitude'',' + CHAR(13)
SET @sql = @sql + '[gps_location_horizontal_accuracy] [varchar](max) ''$.gps_location.horizontal_accuracy'',' + CHAR(13)
SET @sql = @sql + '[gps_location_vertical_accuracy] [varchar](max) ''$.gps_location.vertical_accuracy'',' + CHAR(13)
SET @sql = @sql + '[gps_location_timestamp] [varchar](max) ''$.gps_location.timestamp'',' + CHAR(13)
SET @sql = @sql + '[kilometer_distance] [varchar](max) ''$.kilometer_distance'',' + CHAR(13)
SET @sql = @sql + '[location_description] [varchar](max) ''$.location_description'',' + CHAR(13)
SET @sql = @sql + '[location_name] [varchar](max) ''$.location_name'',' + CHAR(13)
SET @sql = @sql + '[location_name_short] [varchar](max) ''$.location_name_short'',' + CHAR(13)
SET @sql = @sql + '[location_type_key] [varchar](max) ''$.location_type.key'',' + CHAR(13)
SET @sql = @sql + '[location_type_display] [varchar](max) ''$.location_type.display'',' + CHAR(13)
SET @sql = @sql + '[road_number] [varchar](max) ''$.road_number'',' + CHAR(13)
SET @sql = @sql + '[road_section] [varchar](max) ''$.road_section''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

