﻿
CREATE PROCEDURE [itis].[prcExtractcamera_site]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	14-04-2018 03:30:45
-- Reason				:	Reads JSON file and inserts data into Stage table (camera_site)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractcamera_site 'D:\PSA\TCE2\sample\camera_site.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[camera_site]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[camera_site] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[operational_area_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[camera_id_number], ' + CHAR(13)
SET @sql = @sql + '[lane_id_number], ' + CHAR(13)
SET @sql = @sql + '[location_description], ' + CHAR(13)
SET @sql = @sql + '[location_name], ' + CHAR(13)
SET @sql = @sql + '[location_name_short], ' + CHAR(13)
SET @sql = @sql + '[site_id_number], ' + CHAR(13)
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
SET @sql = @sql + '[operational_area_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[camera_id_number], ' + CHAR(13)
SET @sql = @sql + '[lane_id_number], ' + CHAR(13)
SET @sql = @sql + '[location_description], ' + CHAR(13)
SET @sql = @sql + '[location_name], ' + CHAR(13)
SET @sql = @sql + '[location_name_short], ' + CHAR(13)
SET @sql = @sql + '[site_id_number], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[operational_area_id] [varchar](max) ''$.operational_area_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[camera_id_number] [varchar](max) ''$.camera_id_number'',' + CHAR(13)
SET @sql = @sql + '[lane_id_number] [varchar](max) ''$.lane_id_number'',' + CHAR(13)
SET @sql = @sql + '[location_description] [varchar](max) ''$.location_description'',' + CHAR(13)
SET @sql = @sql + '[location_name] [varchar](max) ''$.location_name'',' + CHAR(13)
SET @sql = @sql + '[location_name_short] [varchar](max) ''$.location_name_short'',' + CHAR(13)
SET @sql = @sql + '[site_id_number] [varchar](max) ''$.site_id_number''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

