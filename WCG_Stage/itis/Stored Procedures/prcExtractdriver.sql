﻿CREATE PROCEDURE [itis].[prcExtractdriver]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	12-08-2018 12:46:58
-- Reason				:	Reads JSON file and inserts data into itis table (driver)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountitis
-- Test					:	exec itis.prcExtractdriver 'D:\PSA\WCG\sample\itis\driver.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[driver]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[driver] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[device_id], ' + CHAR(13)
SET @sql = @sql + '[event_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[age], ' + CHAR(13)
SET @sql = @sql + '[age_captured], ' + CHAR(13)
SET @sql = @sql + '[alternative_id_number_captured], ' + CHAR(13)
SET @sql = @sql + '[code_a1_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_a1_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_a1_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_a1_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_a_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_a_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_a_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_a_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_b_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_b_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_b_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_b_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_c1_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_c1_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_c1_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_c1_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_c_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_c_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_c_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_c_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_eb_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_eb_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_eb_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_eb_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_ec1_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_ec1_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_ec1_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_ec1_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_ec_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_ec_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_ec_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_ec_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[country], ' + CHAR(13)
SET @sql = @sql + '[country_captured_key], ' + CHAR(13)
SET @sql = @sql + '[country_captured_display], ' + CHAR(13)
SET @sql = @sql + '[date_of_birth], ' + CHAR(13)
SET @sql = @sql + '[date_of_birth_captured], ' + CHAR(13)
SET @sql = @sql + '[enatis_id_document_number], ' + CHAR(13)
SET @sql = @sql + '[enatis_id_document_type], ' + CHAR(13)
SET @sql = @sql + '[enatis_summary], ' + CHAR(13)
SET @sql = @sql + '[enatis_time_updated], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_latitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_longitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_altitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_timestamp], ' + CHAR(13)
SET @sql = @sql + '[have_checked_enatis_key], ' + CHAR(13)
SET @sql = @sql + '[have_checked_enatis_display], ' + CHAR(13)
SET @sql = @sql + '[identification_photo_captured], ' + CHAR(13)
SET @sql = @sql + '[id_number_captured], ' + CHAR(13)
SET @sql = @sql + '[id_type_captured_key], ' + CHAR(13)
SET @sql = @sql + '[id_type_captured_display], ' + CHAR(13)
SET @sql = @sql + '[initials], ' + CHAR(13)
SET @sql = @sql + '[initials_captured], ' + CHAR(13)
SET @sql = @sql + '[learner_certificate_number], ' + CHAR(13)
SET @sql = @sql + '[learner_license_status_description], ' + CHAR(13)
SET @sql = @sql + '[learner_license_type_description], ' + CHAR(13)
SET @sql = @sql + '[learner_license_valid_from], ' + CHAR(13)
SET @sql = @sql + '[license_authorisation_date], ' + CHAR(13)
SET @sql = @sql + '[license_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[license_expiry_date], ' + CHAR(13)
SET @sql = @sql + '[license_expiry_date_captured], ' + CHAR(13)
SET @sql = @sql + '[license_number_captured], ' + CHAR(13)
SET @sql = @sql + '[license_present_captured_key], ' + CHAR(13)
SET @sql = @sql + '[license_present_captured_display], ' + CHAR(13)
SET @sql = @sql + '[license_restriction], ' + CHAR(13)
SET @sql = @sql + '[license_restriction_captured], ' + CHAR(13)
SET @sql = @sql + '[license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[license_type_code], ' + CHAR(13)
SET @sql = @sql + '[license_type_code_captured], ' + CHAR(13)
SET @sql = @sql + '[license_type_description], ' + CHAR(13)
SET @sql = @sql + '[license_vehicle_restrictions], ' + CHAR(13)
SET @sql = @sql + '[license_vehicle_restrictions_captured], ' + CHAR(13)
SET @sql = @sql + '[method_captured_key], ' + CHAR(13)
SET @sql = @sql + '[method_captured_display], ' + CHAR(13)
SET @sql = @sql + '[name_captured], ' + CHAR(13)
SET @sql = @sql + '[occupation_captured], ' + CHAR(13)
SET @sql = @sql + '[prdp_code], ' + CHAR(13)
SET @sql = @sql + '[prdp_code_captured], ' + CHAR(13)
SET @sql = @sql + '[prdp_dangerous_goods_flag_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_dangerous_goods_flag_display], ' + CHAR(13)
SET @sql = @sql + '[prdp_date_authorised], ' + CHAR(13)
SET @sql = @sql + '[prdp_expiry_date], ' + CHAR(13)
SET @sql = @sql + '[prdp_expiry_date_captured], ' + CHAR(13)
SET @sql = @sql + '[prdp_goods_flag_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_goods_flag_display], ' + CHAR(13)
SET @sql = @sql + '[prdp_passenger_flag_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_passenger_flag_display], ' + CHAR(13)
SET @sql = @sql + '[primary_or_additional_driver_key], ' + CHAR(13)
SET @sql = @sql + '[primary_or_additional_driver_display], ' + CHAR(13)
SET @sql = @sql + '[scan_id_number], ' + CHAR(13)
SET @sql = @sql + '[sex], ' + CHAR(13)
SET @sql = @sql + '[sex_captured_key], ' + CHAR(13)
SET @sql = @sql + '[sex_captured_display], ' + CHAR(13)
SET @sql = @sql + '[status_key], ' + CHAR(13)
SET @sql = @sql + '[status_display], ' + CHAR(13)
SET @sql = @sql + '[surname], ' + CHAR(13)
SET @sql = @sql + '[surname_captured], ' + CHAR(13)
SET @sql = @sql + '[timestamp_captured], ' + CHAR(13)
SET @sql = @sql + '[traffic_register_number], ' + CHAR(13)
SET @sql = @sql + '[user_location_captured], ' + CHAR(13)
SET @sql = @sql + '[voluntary_lookup_key], ' + CHAR(13)
SET @sql = @sql + '[voluntary_lookup_display], ' + CHAR(13)
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
SET @sql = @sql + '[device_id], ' + CHAR(13)
SET @sql = @sql + '[event_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[age], ' + CHAR(13)
SET @sql = @sql + '[age_captured], ' + CHAR(13)
SET @sql = @sql + '[alternative_id_number_captured], ' + CHAR(13)
SET @sql = @sql + '[code_a1_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_a1_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_a1_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_a1_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_a_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_a_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_a_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_a_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_b_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_b_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_b_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_b_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_c1_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_c1_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_c1_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_c1_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_c_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_c_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_c_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_c_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_eb_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_eb_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_eb_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_eb_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_ec1_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_ec1_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_ec1_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_ec1_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[code_ec_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[code_ec_has_license_key], ' + CHAR(13)
SET @sql = @sql + '[code_ec_has_license_display], ' + CHAR(13)
SET @sql = @sql + '[code_ec_license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[country], ' + CHAR(13)
SET @sql = @sql + '[country_captured_key], ' + CHAR(13)
SET @sql = @sql + '[country_captured_display], ' + CHAR(13)
SET @sql = @sql + '[date_of_birth], ' + CHAR(13)
SET @sql = @sql + '[date_of_birth_captured], ' + CHAR(13)
SET @sql = @sql + '[enatis_id_document_number], ' + CHAR(13)
SET @sql = @sql + '[enatis_id_document_type], ' + CHAR(13)
SET @sql = @sql + '[enatis_summary], ' + CHAR(13)
SET @sql = @sql + '[enatis_time_updated], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_latitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_longitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_altitude], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_horizontal_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_vertical_accuracy], ' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_timestamp], ' + CHAR(13)
SET @sql = @sql + '[have_checked_enatis_key], ' + CHAR(13)
SET @sql = @sql + '[have_checked_enatis_display], ' + CHAR(13)
SET @sql = @sql + '[identification_photo_captured], ' + CHAR(13)
SET @sql = @sql + '[id_number_captured], ' + CHAR(13)
SET @sql = @sql + '[id_type_captured_key], ' + CHAR(13)
SET @sql = @sql + '[id_type_captured_display], ' + CHAR(13)
SET @sql = @sql + '[initials], ' + CHAR(13)
SET @sql = @sql + '[initials_captured], ' + CHAR(13)
SET @sql = @sql + '[learner_certificate_number], ' + CHAR(13)
SET @sql = @sql + '[learner_license_status_description], ' + CHAR(13)
SET @sql = @sql + '[learner_license_type_description], ' + CHAR(13)
SET @sql = @sql + '[learner_license_valid_from], ' + CHAR(13)
SET @sql = @sql + '[license_authorisation_date], ' + CHAR(13)
SET @sql = @sql + '[license_date_of_first_issue], ' + CHAR(13)
SET @sql = @sql + '[license_expiry_date], ' + CHAR(13)
SET @sql = @sql + '[license_expiry_date_captured], ' + CHAR(13)
SET @sql = @sql + '[license_number_captured], ' + CHAR(13)
SET @sql = @sql + '[license_present_captured_key], ' + CHAR(13)
SET @sql = @sql + '[license_present_captured_display], ' + CHAR(13)
SET @sql = @sql + '[license_restriction], ' + CHAR(13)
SET @sql = @sql + '[license_restriction_captured], ' + CHAR(13)
SET @sql = @sql + '[license_restriction_description], ' + CHAR(13)
SET @sql = @sql + '[license_type_code], ' + CHAR(13)
SET @sql = @sql + '[license_type_code_captured], ' + CHAR(13)
SET @sql = @sql + '[license_type_description], ' + CHAR(13)
SET @sql = @sql + '[license_vehicle_restrictions], ' + CHAR(13)
SET @sql = @sql + '[license_vehicle_restrictions_captured], ' + CHAR(13)
SET @sql = @sql + '[method_captured_key], ' + CHAR(13)
SET @sql = @sql + '[method_captured_display], ' + CHAR(13)
SET @sql = @sql + '[name_captured], ' + CHAR(13)
SET @sql = @sql + '[occupation_captured], ' + CHAR(13)
SET @sql = @sql + '[prdp_code], ' + CHAR(13)
SET @sql = @sql + '[prdp_code_captured], ' + CHAR(13)
SET @sql = @sql + '[prdp_dangerous_goods_flag_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_dangerous_goods_flag_display], ' + CHAR(13)
SET @sql = @sql + '[prdp_date_authorised], ' + CHAR(13)
SET @sql = @sql + '[prdp_expiry_date], ' + CHAR(13)
SET @sql = @sql + '[prdp_expiry_date_captured], ' + CHAR(13)
SET @sql = @sql + '[prdp_goods_flag_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_goods_flag_display], ' + CHAR(13)
SET @sql = @sql + '[prdp_passenger_flag_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_passenger_flag_display], ' + CHAR(13)
SET @sql = @sql + '[primary_or_additional_driver_key], ' + CHAR(13)
SET @sql = @sql + '[primary_or_additional_driver_display], ' + CHAR(13)
SET @sql = @sql + '[scan_id_number], ' + CHAR(13)
SET @sql = @sql + '[sex], ' + CHAR(13)
SET @sql = @sql + '[sex_captured_key], ' + CHAR(13)
SET @sql = @sql + '[sex_captured_display], ' + CHAR(13)
SET @sql = @sql + '[status_key], ' + CHAR(13)
SET @sql = @sql + '[status_display], ' + CHAR(13)
SET @sql = @sql + '[surname], ' + CHAR(13)
SET @sql = @sql + '[surname_captured], ' + CHAR(13)
SET @sql = @sql + '[timestamp_captured], ' + CHAR(13)
SET @sql = @sql + '[traffic_register_number], ' + CHAR(13)
SET @sql = @sql + '[user_location_captured], ' + CHAR(13)
SET @sql = @sql + '[voluntary_lookup_key], ' + CHAR(13)
SET @sql = @sql + '[voluntary_lookup_display], ' + CHAR(13)
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
SET @sql = @sql + '[event_id] [varchar](max) ''$.event_id'',' + CHAR(13)
SET @sql = @sql + '[user_id] [varchar](max) ''$.user_id'',' + CHAR(13)
SET @sql = @sql + '[age] [varchar](max) ''$.age'',' + CHAR(13)
SET @sql = @sql + '[age_captured] [varchar](max) ''$.age_captured'',' + CHAR(13)
SET @sql = @sql + '[alternative_id_number_captured] [varchar](max) ''$.alternative_id_number_captured'',' + CHAR(13)
SET @sql = @sql + '[code_a1_date_of_first_issue] [varchar](max) ''$.code_a1_date_of_first_issue'',' + CHAR(13)
SET @sql = @sql + '[code_a1_has_license_key] [varchar](max) ''$.code_a1_has_license.key'',' + CHAR(13)
SET @sql = @sql + '[code_a1_has_license_display] [varchar](max) ''$.code_a1_has_license.display'',' + CHAR(13)
SET @sql = @sql + '[code_a1_license_restriction_description] [varchar](max) ''$.code_a1_license_restriction_description'',' + CHAR(13)
SET @sql = @sql + '[code_a_date_of_first_issue] [varchar](max) ''$.code_a_date_of_first_issue'',' + CHAR(13)
SET @sql = @sql + '[code_a_has_license_key] [varchar](max) ''$.code_a_has_license.key'',' + CHAR(13)
SET @sql = @sql + '[code_a_has_license_display] [varchar](max) ''$.code_a_has_license.display'',' + CHAR(13)
SET @sql = @sql + '[code_a_license_restriction_description] [varchar](max) ''$.code_a_license_restriction_description'',' + CHAR(13)
SET @sql = @sql + '[code_b_date_of_first_issue] [varchar](max) ''$.code_b_date_of_first_issue'',' + CHAR(13)
SET @sql = @sql + '[code_b_has_license_key] [varchar](max) ''$.code_b_has_license.key'',' + CHAR(13)
SET @sql = @sql + '[code_b_has_license_display] [varchar](max) ''$.code_b_has_license.display'',' + CHAR(13)
SET @sql = @sql + '[code_b_license_restriction_description] [varchar](max) ''$.code_b_license_restriction_description'',' + CHAR(13)
SET @sql = @sql + '[code_c1_date_of_first_issue] [varchar](max) ''$.code_c1_date_of_first_issue'',' + CHAR(13)
SET @sql = @sql + '[code_c1_has_license_key] [varchar](max) ''$.code_c1_has_license.key'',' + CHAR(13)
SET @sql = @sql + '[code_c1_has_license_display] [varchar](max) ''$.code_c1_has_license.display'',' + CHAR(13)
SET @sql = @sql + '[code_c1_license_restriction_description] [varchar](max) ''$.code_c1_license_restriction_description'',' + CHAR(13)
SET @sql = @sql + '[code_c_date_of_first_issue] [varchar](max) ''$.code_c_date_of_first_issue'',' + CHAR(13)
SET @sql = @sql + '[code_c_has_license_key] [varchar](max) ''$.code_c_has_license.key'',' + CHAR(13)
SET @sql = @sql + '[code_c_has_license_display] [varchar](max) ''$.code_c_has_license.display'',' + CHAR(13)
SET @sql = @sql + '[code_c_license_restriction_description] [varchar](max) ''$.code_c_license_restriction_description'',' + CHAR(13)
SET @sql = @sql + '[code_eb_date_of_first_issue] [varchar](max) ''$.code_eb_date_of_first_issue'',' + CHAR(13)
SET @sql = @sql + '[code_eb_has_license_key] [varchar](max) ''$.code_eb_has_license.key'',' + CHAR(13)
SET @sql = @sql + '[code_eb_has_license_display] [varchar](max) ''$.code_eb_has_license.display'',' + CHAR(13)
SET @sql = @sql + '[code_eb_license_restriction_description] [varchar](max) ''$.code_eb_license_restriction_description'',' + CHAR(13)
SET @sql = @sql + '[code_ec1_date_of_first_issue] [varchar](max) ''$.code_ec1_date_of_first_issue'',' + CHAR(13)
SET @sql = @sql + '[code_ec1_has_license_key] [varchar](max) ''$.code_ec1_has_license.key'',' + CHAR(13)
SET @sql = @sql + '[code_ec1_has_license_display] [varchar](max) ''$.code_ec1_has_license.display'',' + CHAR(13)
SET @sql = @sql + '[code_ec1_license_restriction_description] [varchar](max) ''$.code_ec1_license_restriction_description'',' + CHAR(13)
SET @sql = @sql + '[code_ec_date_of_first_issue] [varchar](max) ''$.code_ec_date_of_first_issue'',' + CHAR(13)
SET @sql = @sql + '[code_ec_has_license_key] [varchar](max) ''$.code_ec_has_license.key'',' + CHAR(13)
SET @sql = @sql + '[code_ec_has_license_display] [varchar](max) ''$.code_ec_has_license.display'',' + CHAR(13)
SET @sql = @sql + '[code_ec_license_restriction_description] [varchar](max) ''$.code_ec_license_restriction_description'',' + CHAR(13)
SET @sql = @sql + '[country] [varchar](max) ''$.country'',' + CHAR(13)
SET @sql = @sql + '[country_captured_key] [varchar](max) ''$.country_captured.key'',' + CHAR(13)
SET @sql = @sql + '[country_captured_display] [varchar](max) ''$.country_captured.display'',' + CHAR(13)
SET @sql = @sql + '[date_of_birth] [varchar](max) ''$.date_of_birth'',' + CHAR(13)
SET @sql = @sql + '[date_of_birth_captured] [varchar](max) ''$.date_of_birth_captured'',' + CHAR(13)
SET @sql = @sql + '[enatis_id_document_number] [varchar](max) ''$.enatis_id_document_number'',' + CHAR(13)
SET @sql = @sql + '[enatis_id_document_type] [varchar](max) ''$.enatis_id_document_type'',' + CHAR(13)
SET @sql = @sql + '[enatis_summary] [varchar](max) ''$.enatis_summary'',' + CHAR(13)
SET @sql = @sql + '[enatis_time_updated] [varchar](max) ''$.enatis_time_updated'',' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_latitude] [varchar](max) ''$.gps_location_captured.latitude'',' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_longitude] [varchar](max) ''$.gps_location_captured.longitude'',' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_altitude] [varchar](max) ''$.gps_location_captured.altitude'',' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_horizontal_accuracy] [varchar](max) ''$.gps_location_captured.horizontal_accuracy'',' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_vertical_accuracy] [varchar](max) ''$.gps_location_captured.vertical_accuracy'',' + CHAR(13)
SET @sql = @sql + '[gps_location_captured_timestamp] [varchar](max) ''$.gps_location_captured.timestamp'',' + CHAR(13)
SET @sql = @sql + '[have_checked_enatis_key] [varchar](max) ''$.have_checked_enatis.key'',' + CHAR(13)
SET @sql = @sql + '[have_checked_enatis_display] [varchar](max) ''$.have_checked_enatis.display'',' + CHAR(13)
SET @sql = @sql + '[identification_photo_captured] [varchar](max) ''$.identification_photo_captured'',' + CHAR(13)
SET @sql = @sql + '[id_number_captured] [varchar](max) ''$.id_number_captured'',' + CHAR(13)
SET @sql = @sql + '[id_type_captured_key] [varchar](max) ''$.id_type_captured.key'',' + CHAR(13)
SET @sql = @sql + '[id_type_captured_display] [varchar](max) ''$.id_type_captured.display'',' + CHAR(13)
SET @sql = @sql + '[initials] [varchar](max) ''$.initials'',' + CHAR(13)
SET @sql = @sql + '[initials_captured] [varchar](max) ''$.initials_captured'',' + CHAR(13)
SET @sql = @sql + '[learner_certificate_number] [varchar](max) ''$.learner_certificate_number'',' + CHAR(13)
SET @sql = @sql + '[learner_license_status_description] [varchar](max) ''$.learner_license_status_description'',' + CHAR(13)
SET @sql = @sql + '[learner_license_type_description] [varchar](max) ''$.learner_license_type_description'',' + CHAR(13)
SET @sql = @sql + '[learner_license_valid_from] [varchar](max) ''$.learner_license_valid_from'',' + CHAR(13)
SET @sql = @sql + '[license_authorisation_date] [varchar](max) ''$.license_authorisation_date'',' + CHAR(13)
SET @sql = @sql + '[license_date_of_first_issue] [varchar](max) ''$.license_date_of_first_issue'',' + CHAR(13)
SET @sql = @sql + '[license_expiry_date] [varchar](max) ''$.license_expiry_date'',' + CHAR(13)
SET @sql = @sql + '[license_expiry_date_captured] [varchar](max) ''$.license_expiry_date_captured'',' + CHAR(13)
SET @sql = @sql + '[license_number_captured] [varchar](max) ''$.license_number_captured'',' + CHAR(13)
SET @sql = @sql + '[license_present_captured_key] [varchar](max) ''$.license_present_captured.key'',' + CHAR(13)
SET @sql = @sql + '[license_present_captured_display] [varchar](max) ''$.license_present_captured.display'',' + CHAR(13)
SET @sql = @sql + '[license_restriction] [varchar](max) ''$.license_restriction'',' + CHAR(13)
SET @sql = @sql + '[license_restriction_captured] [varchar](max) ''$.license_restriction_captured'',' + CHAR(13)
SET @sql = @sql + '[license_restriction_description] [varchar](max) ''$.license_restriction_description'',' + CHAR(13)
SET @sql = @sql + '[license_type_code] [varchar](max) ''$.license_type_code'',' + CHAR(13)
SET @sql = @sql + '[license_type_code_captured] [varchar](max) ''$.license_type_code_captured'',' + CHAR(13)
SET @sql = @sql + '[license_type_description] [varchar](max) ''$.license_type_description'',' + CHAR(13)
SET @sql = @sql + '[license_vehicle_restrictions] [varchar](max) ''$.license_vehicle_restrictions'',' + CHAR(13)
SET @sql = @sql + '[license_vehicle_restrictions_captured] [varchar](max) ''$.license_vehicle_restrictions_captured'',' + CHAR(13)
SET @sql = @sql + '[method_captured_key] [varchar](max) ''$.method_captured.key'',' + CHAR(13)
SET @sql = @sql + '[method_captured_display] [varchar](max) ''$.method_captured.display'',' + CHAR(13)
SET @sql = @sql + '[name_captured] [varchar](max) ''$.name_captured'',' + CHAR(13)
SET @sql = @sql + '[occupation_captured] [varchar](max) ''$.occupation_captured'',' + CHAR(13)
SET @sql = @sql + '[prdp_code] [varchar](max) ''$.prdp_code'',' + CHAR(13)
SET @sql = @sql + '[prdp_code_captured] [varchar](max) ''$.prdp_code_captured'',' + CHAR(13)
SET @sql = @sql + '[prdp_dangerous_goods_flag_key] [varchar](max) ''$.prdp_dangerous_goods_flag.key'',' + CHAR(13)
SET @sql = @sql + '[prdp_dangerous_goods_flag_display] [varchar](max) ''$.prdp_dangerous_goods_flag.display'',' + CHAR(13)
SET @sql = @sql + '[prdp_date_authorised] [varchar](max) ''$.prdp_date_authorised'',' + CHAR(13)
SET @sql = @sql + '[prdp_expiry_date] [varchar](max) ''$.prdp_expiry_date'',' + CHAR(13)
SET @sql = @sql + '[prdp_expiry_date_captured] [varchar](max) ''$.prdp_expiry_date_captured'',' + CHAR(13)
SET @sql = @sql + '[prdp_goods_flag_key] [varchar](max) ''$.prdp_goods_flag.key'',' + CHAR(13)
SET @sql = @sql + '[prdp_goods_flag_display] [varchar](max) ''$.prdp_goods_flag.display'',' + CHAR(13)
SET @sql = @sql + '[prdp_passenger_flag_key] [varchar](max) ''$.prdp_passenger_flag.key'',' + CHAR(13)
SET @sql = @sql + '[prdp_passenger_flag_display] [varchar](max) ''$.prdp_passenger_flag.display'',' + CHAR(13)
SET @sql = @sql + '[primary_or_additional_driver_key] [varchar](max) ''$.primary_or_additional_driver.key'',' + CHAR(13)
SET @sql = @sql + '[primary_or_additional_driver_display] [varchar](max) ''$.primary_or_additional_driver.display'',' + CHAR(13)
SET @sql = @sql + '[scan_id_number] [varchar](max) ''$.scan_id_number'',' + CHAR(13)
SET @sql = @sql + '[sex] [varchar](max) ''$.sex'',' + CHAR(13)
SET @sql = @sql + '[sex_captured_key] [varchar](max) ''$.sex_captured.key'',' + CHAR(13)
SET @sql = @sql + '[sex_captured_display] [varchar](max) ''$.sex_captured.display'',' + CHAR(13)
SET @sql = @sql + '[status_key] [varchar](max) ''$.status.key'',' + CHAR(13)
SET @sql = @sql + '[status_display] [varchar](max) ''$.status.display'',' + CHAR(13)
SET @sql = @sql + '[surname] [varchar](max) ''$.surname'',' + CHAR(13)
SET @sql = @sql + '[surname_captured] [varchar](max) ''$.surname_captured'',' + CHAR(13)
SET @sql = @sql + '[timestamp_captured] [varchar](max) ''$.timestamp_captured'',' + CHAR(13)
SET @sql = @sql + '[traffic_register_number] [varchar](max) ''$.traffic_register_number'',' + CHAR(13)
SET @sql = @sql + '[user_location_captured] [varchar](max) ''$.user_location_captured'',' + CHAR(13)
SET @sql = @sql + '[voluntary_lookup_key] [varchar](max) ''$.voluntary_lookup.key'',' + CHAR(13)
SET @sql = @sql + '[voluntary_lookup_display] [varchar](max) ''$.voluntary_lookup.display''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)
