
CREATE PROCEDURE [itis].[prcExtractdevice]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-04-2018 01:33:26
-- Reason				:	Reads JSON file and inserts data into Stage table (device)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractdevice 'D:\PSA\TCE2\sample\device.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[device]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[device] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[current_actvity_id], ' + CHAR(13)
SET @sql = @sql + '[current_potential_violation_id], ' + CHAR(13)
SET @sql = @sql + '[current_shift_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[current_user_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[alert_violation_key], ' + CHAR(13)
SET @sql = @sql + '[alert_violation_display], ' + CHAR(13)
SET @sql = @sql + '[deleted_vehicle_or_driver_key], ' + CHAR(13)
SET @sql = @sql + '[deleted_vehicle_or_driver_display], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_begin], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_end], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_last_used], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_nn], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_nnn], ' + CHAR(13)
SET @sql = @sql + '[immediate_stop_and_approach_key], ' + CHAR(13)
SET @sql = @sql + '[immediate_stop_and_approach_display], ' + CHAR(13)
SET @sql = @sql + '[last_app_version], ' + CHAR(13)
SET @sql = @sql + '[last_authentication_timestamp], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_latitude], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_longitude], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_altitude], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_timestamp], ' + CHAR(13)
SET @sql = @sql + '[make_and_model], ' + CHAR(13)
SET @sql = @sql + '[mobile_number], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[number], ' + CHAR(13)
SET @sql = @sql + '[sect_56_device_identifier], ' + CHAR(13)
SET @sql = @sql + '[sect_56_nn], ' + CHAR(13)
SET @sql = @sql + '[sect_56_nnn], ' + CHAR(13)
SET @sql = @sql + '[serial_number], ' + CHAR(13)
SET @sql = @sql + '[widget_url], ' + CHAR(13)
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
SET @sql = @sql + '[current_actvity_id], ' + CHAR(13)
SET @sql = @sql + '[current_potential_violation_id], ' + CHAR(13)
SET @sql = @sql + '[current_shift_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[current_user_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[alert_violation_key], ' + CHAR(13)
SET @sql = @sql + '[alert_violation_display], ' + CHAR(13)
SET @sql = @sql + '[deleted_vehicle_or_driver_key], ' + CHAR(13)
SET @sql = @sql + '[deleted_vehicle_or_driver_display], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_begin], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_end], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_last_used], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_nn], ' + CHAR(13)
SET @sql = @sql + '[device_sect_56_nnn], ' + CHAR(13)
SET @sql = @sql + '[immediate_stop_and_approach_key], ' + CHAR(13)
SET @sql = @sql + '[immediate_stop_and_approach_display], ' + CHAR(13)
SET @sql = @sql + '[last_app_version], ' + CHAR(13)
SET @sql = @sql + '[last_authentication_timestamp], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_latitude], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_longitude], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_altitude], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[last_known_location_timestamp], ' + CHAR(13)
SET @sql = @sql + '[make_and_model], ' + CHAR(13)
SET @sql = @sql + '[mobile_number], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[number], ' + CHAR(13)
SET @sql = @sql + '[sect_56_device_identifier], ' + CHAR(13)
SET @sql = @sql + '[sect_56_nn], ' + CHAR(13)
SET @sql = @sql + '[sect_56_nnn], ' + CHAR(13)
SET @sql = @sql + '[serial_number], ' + CHAR(13)
SET @sql = @sql + '[widget_url], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[current_actvity_id] [varchar](max) ''$.current_actvity_id'',' + CHAR(13)
SET @sql = @sql + '[current_potential_violation_id] [varchar](max) ''$.current_potential_violation_id'',' + CHAR(13)
SET @sql = @sql + '[current_shift_statistic_id] [varchar](max) ''$.current_shift_statistic_id'',' + CHAR(13)
SET @sql = @sql + '[current_user_id] [varchar](max) ''$.current_user_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[alert_violation_key] [varchar](max) ''$.alert_violation.key'',' + CHAR(13)
SET @sql = @sql + '[alert_violation_display] [varchar](max) ''$.alert_violation.display'',' + CHAR(13)
SET @sql = @sql + '[deleted_vehicle_or_driver_key] [varchar](max) ''$.deleted_vehicle_or_driver.key'',' + CHAR(13)
SET @sql = @sql + '[deleted_vehicle_or_driver_display] [varchar](max) ''$.deleted_vehicle_or_driver.display'',' + CHAR(13)
SET @sql = @sql + '[device_sect_56_begin] [varchar](max) ''$.device_sect_56_begin'',' + CHAR(13)
SET @sql = @sql + '[device_sect_56_end] [varchar](max) ''$.device_sect_56_end'',' + CHAR(13)
SET @sql = @sql + '[device_sect_56_last_used] [varchar](max) ''$.device_sect_56_last_used'',' + CHAR(13)
SET @sql = @sql + '[device_sect_56_nn] [varchar](max) ''$.device_sect_56_nn'',' + CHAR(13)
SET @sql = @sql + '[device_sect_56_nnn] [varchar](max) ''$.device_sect_56_nnn'',' + CHAR(13)
SET @sql = @sql + '[immediate_stop_and_approach_key] [varchar](max) ''$.immediate_stop_and_approach.key'',' + CHAR(13)
SET @sql = @sql + '[immediate_stop_and_approach_display] [varchar](max) ''$.immediate_stop_and_approach.display'',' + CHAR(13)
SET @sql = @sql + '[last_app_version] [varchar](max) ''$.last_app_version'',' + CHAR(13)
SET @sql = @sql + '[last_authentication_timestamp] [varchar](max) ''$.last_authentication_timestamp'',' + CHAR(13)
SET @sql = @sql + '[last_known_location_latitude] [varchar](max) ''$.last_known_location.latitude'',' + CHAR(13)
SET @sql = @sql + '[last_known_location_longitude] [varchar](max) ''$.last_known_location.longitude'',' + CHAR(13)
SET @sql = @sql + '[last_known_location_altitude] [varchar](max) ''$.last_known_location.altitude'',' + CHAR(13)
SET @sql = @sql + '[last_known_location_horizontal_accuracy] [varchar](max) ''$.last_known_location.horizontal_accuracy'',' + CHAR(13)
SET @sql = @sql + '[last_known_location_vertical_accuracy] [varchar](max) ''$.last_known_location.vertical_accuracy'',' + CHAR(13)
SET @sql = @sql + '[last_known_location_timestamp] [varchar](max) ''$.last_known_location.timestamp'',' + CHAR(13)
SET @sql = @sql + '[make_and_model] [varchar](max) ''$.make_and_model'',' + CHAR(13)
SET @sql = @sql + '[mobile_number] [varchar](max) ''$.mobile_number'',' + CHAR(13)
SET @sql = @sql + '[name] [varchar](max) ''$.name'',' + CHAR(13)
SET @sql = @sql + '[number] [varchar](max) ''$.number'',' + CHAR(13)
SET @sql = @sql + '[sect_56_device_identifier] [varchar](max) ''$.sect_56_device_identifier'',' + CHAR(13)
SET @sql = @sql + '[sect_56_nn] [varchar](max) ''$.sect_56_nn'',' + CHAR(13)
SET @sql = @sql + '[sect_56_nnn] [varchar](max) ''$.sect_56_nnn'',' + CHAR(13)
SET @sql = @sql + '[serial_number] [varchar](max) ''$.serial_number'',' + CHAR(13)
SET @sql = @sql + '[widget_url] [varchar](max) ''$.widget_url''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

