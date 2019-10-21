

CREATE PROCEDURE [ebat].[prcExtractebat_device]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	12-08-2016 04:57:42
-- Reason				:	Reads JSON file and inserts data into Stage table (ebat_device)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec ebat.prcExtractebat_device 'F:\PSA\WCG\v3\data\ebat_device.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [ebat].[ebat_device]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [ebat].[ebat_device] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[centre_id], ' + CHAR(13)
SET @sql = @sql + '[calibration_certificate], ' + CHAR(13)
SET @sql = @sql + '[certificate_date_of_issue], ' + CHAR(13)
SET @sql = @sql + '[certificate_number], ' + CHAR(13)
SET @sql = @sql + '[comments], ' + CHAR(13)
SET @sql = @sql + '[created_at], ' + CHAR(13)
SET @sql = @sql + '[created_by], ' + CHAR(13)
SET @sql = @sql + '[created_location_latitude], ' + CHAR(13)
SET @sql = @sql + '[created_location_longitude], ' + CHAR(13)
SET @sql = @sql + '[created_location_altitude], ' + CHAR(13)
SET @sql = @sql + '[created_location_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[created_location_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[created_location_timestamp], ' + CHAR(13)
SET @sql = @sql + '[created_signature], ' + CHAR(13)
SET @sql = @sql + '[date_of_next_calibration], ' + CHAR(13)
SET @sql = @sql + '[make], ' + CHAR(13)
SET @sql = @sql + '[manufacturer], ' + CHAR(13)
SET @sql = @sql + '[model], ' + CHAR(13)
SET @sql = @sql + '[serial], ' + CHAR(13)
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
SET @sql = @sql + '[centre_id], ' + CHAR(13)
SET @sql = @sql + '[calibration_certificate], ' + CHAR(13)
SET @sql = @sql + '[certificate_date_of_issue], ' + CHAR(13)
SET @sql = @sql + '[certificate_number], ' + CHAR(13)
SET @sql = @sql + '[comments], ' + CHAR(13)
SET @sql = @sql + '[created_at], ' + CHAR(13)
SET @sql = @sql + '[created_by], ' + CHAR(13)
SET @sql = @sql + '[created_location_latitude], ' + CHAR(13)
SET @sql = @sql + '[created_location_longitude], ' + CHAR(13)
SET @sql = @sql + '[created_location_altitude], ' + CHAR(13)
SET @sql = @sql + '[created_location_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[created_location_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[created_location_timestamp], ' + CHAR(13)
SET @sql = @sql + '[created_signature], ' + CHAR(13)
SET @sql = @sql + '[date_of_next_calibration], ' + CHAR(13)
SET @sql = @sql + '[make], ' + CHAR(13)
SET @sql = @sql + '[manufacturer], ' + CHAR(13)
SET @sql = @sql + '[model], ' + CHAR(13)
SET @sql = @sql + '[serial], ' + CHAR(13)
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
SET @sql = @sql + '[centre_id] [varchar](max) ''$.centre_id'',' + CHAR(13)
SET @sql = @sql + '[calibration_certificate] [varchar](max) ''$.calibration_certificate'',' + CHAR(13)
SET @sql = @sql + '[certificate_date_of_issue] [varchar](max) ''$.certificate_date_of_issue'',' + CHAR(13)
SET @sql = @sql + '[certificate_number] [varchar](max) ''$.certificate_number'',' + CHAR(13)
SET @sql = @sql + '[comments] [varchar](max) ''$.comments'',' + CHAR(13)
SET @sql = @sql + '[created_at] [varchar](max) ''$.created_at'',' + CHAR(13)
SET @sql = @sql + '[created_by] [varchar](max) ''$.created_by'',' + CHAR(13)
SET @sql = @sql + '[created_location_latitude] [varchar](max) ''$.created_location.latitude'',' + CHAR(13)
SET @sql = @sql + '[created_location_longitude] [varchar](max) ''$.created_location.longitude'',' + CHAR(13)
SET @sql = @sql + '[created_location_altitude] [varchar](max) ''$.created_location.altitude'',' + CHAR(13)
SET @sql = @sql + '[created_location_horizontal_accuracy] [varchar](max) ''$.created_location.horizontal_accuracy'',' + CHAR(13)
SET @sql = @sql + '[created_location_vertical_accuracy] [varchar](max) ''$.created_location.vertical_accuracy'',' + CHAR(13)
SET @sql = @sql + '[created_location_timestamp] [varchar](max) ''$.created_location.timestamp'',' + CHAR(13)
SET @sql = @sql + '[created_signature] [varchar](max) ''$.created_signature'',' + CHAR(13)
SET @sql = @sql + '[date_of_next_calibration] [varchar](max) ''$.date_of_next_calibration'',' + CHAR(13)
SET @sql = @sql + '[make] [varchar](max) ''$.make'',' + CHAR(13)
SET @sql = @sql + '[manufacturer] [varchar](max) ''$.manufacturer'',' + CHAR(13)
SET @sql = @sql + '[model] [varchar](max) ''$.model'',' + CHAR(13)
SET @sql = @sql + '[serial] [varchar](max) ''$.serial'',' + CHAR(13)
SET @sql = @sql + '[status_key] [varchar](max) ''$.status.key'',' + CHAR(13)
SET @sql = @sql + '[status_display] [varchar](max) ''$.status.display''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)


;
