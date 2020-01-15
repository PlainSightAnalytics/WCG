
CREATE PROCEDURE [itis].[prcExtractapp_actual]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-01-2020 07:55:42
-- Reason				:	Reads JSON file and inserts data into Stage table (app_actual)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractapp_actual 'D:\PSA\WCG\changes\WCG-0130 - APP Targets - New Fields\sample\app_actual.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[app_actual]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[app_actual] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[annual_app_target_for_traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[annual_app_target_total_id], ' + CHAR(13)
SET @sql = @sql + '[app_target_id], ' + CHAR(13)
SET @sql = @sql + '[calendar_month_id], ' + CHAR(13)
SET @sql = @sql + '[calendar_quarter_id], ' + CHAR(13)
SET @sql = @sql + '[calendar_year_id], ' + CHAR(13)
SET @sql = @sql + '[quarterly_app_target_for_traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[quarterly_app_target_total_id], ' + CHAR(13)
SET @sql = @sql + '[tc_who_submitted_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[app_target_description], ' + CHAR(13)
SET @sql = @sql + '[calculated_preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[corrective_action], ' + CHAR(13)
SET @sql = @sql + '[created_at], ' + CHAR(13)
SET @sql = @sql + '[date_finalized_by_tc], ' + CHAR(13)
SET @sql = @sql + '[date_verified], ' + CHAR(13)
SET @sql = @sql + '[finalized_calculated_preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[finalized_manually_added_preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[finalized_preliminary_actual_total], ' + CHAR(13)
SET @sql = @sql + '[finalized_verified_actual], ' + CHAR(13)
SET @sql = @sql + '[has_been_verified_key], ' + CHAR(13)
SET @sql = @sql + '[has_been_verified_display], ' + CHAR(13)
SET @sql = @sql + '[last_date_calculated], ' + CHAR(13)
SET @sql = @sql + '[last_date_calculate_request_sent], ' + CHAR(13)
SET @sql = @sql + '[manually_added_preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[national_target], ' + CHAR(13)
SET @sql = @sql + '[percentage_achieved], ' + CHAR(13)
SET @sql = @sql + '[preliminary_actual_finalized_key], ' + CHAR(13)
SET @sql = @sql + '[preliminary_actual_finalized_display], ' + CHAR(13)
SET @sql = @sql + '[preliminary_actual_total], ' + CHAR(13)
SET @sql = @sql + '[regional_director_comment], ' + CHAR(13)
SET @sql = @sql + '[status_key], ' + CHAR(13)
SET @sql = @sql + '[status_display], ' + CHAR(13)
SET @sql = @sql + '[submitted_by_rd_key], ' + CHAR(13)
SET @sql = @sql + '[submitted_by_rd_display], ' + CHAR(13)
SET @sql = @sql + '[target], ' + CHAR(13)
SET @sql = @sql + '[tc_comment], ' + CHAR(13)
SET @sql = @sql + '[verified_actual], ' + CHAR(13)
SET @sql = @sql + '[verifier_comment], ' + CHAR(13)
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
SET @sql = @sql + '[annual_app_target_for_traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[annual_app_target_total_id], ' + CHAR(13)
SET @sql = @sql + '[app_target_id], ' + CHAR(13)
SET @sql = @sql + '[calendar_month_id], ' + CHAR(13)
SET @sql = @sql + '[calendar_quarter_id], ' + CHAR(13)
SET @sql = @sql + '[calendar_year_id], ' + CHAR(13)
SET @sql = @sql + '[quarterly_app_target_for_traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[quarterly_app_target_total_id], ' + CHAR(13)
SET @sql = @sql + '[tc_who_submitted_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[app_target_description], ' + CHAR(13)
SET @sql = @sql + '[calculated_preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[corrective_action], ' + CHAR(13)
SET @sql = @sql + '[created_at], ' + CHAR(13)
SET @sql = @sql + '[date_finalized_by_tc], ' + CHAR(13)
SET @sql = @sql + '[date_verified], ' + CHAR(13)
SET @sql = @sql + '[finalized_calculated_preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[finalized_manually_added_preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[finalized_preliminary_actual_total], ' + CHAR(13)
SET @sql = @sql + '[finalized_verified_actual], ' + CHAR(13)
SET @sql = @sql + '[has_been_verified_key], ' + CHAR(13)
SET @sql = @sql + '[has_been_verified_display], ' + CHAR(13)
SET @sql = @sql + '[last_date_calculated], ' + CHAR(13)
SET @sql = @sql + '[last_date_calculate_request_sent], ' + CHAR(13)
SET @sql = @sql + '[manually_added_preliminary_actual], ' + CHAR(13)
SET @sql = @sql + '[national_target], ' + CHAR(13)
SET @sql = @sql + '[percentage_achieved], ' + CHAR(13)
SET @sql = @sql + '[preliminary_actual_finalized_key], ' + CHAR(13)
SET @sql = @sql + '[preliminary_actual_finalized_display], ' + CHAR(13)
SET @sql = @sql + '[preliminary_actual_total], ' + CHAR(13)
SET @sql = @sql + '[regional_director_comment], ' + CHAR(13)
SET @sql = @sql + '[status_key], ' + CHAR(13)
SET @sql = @sql + '[status_display], ' + CHAR(13)
SET @sql = @sql + '[submitted_by_rd_key], ' + CHAR(13)
SET @sql = @sql + '[submitted_by_rd_display], ' + CHAR(13)
SET @sql = @sql + '[target], ' + CHAR(13)
SET @sql = @sql + '[tc_comment], ' + CHAR(13)
SET @sql = @sql + '[verified_actual], ' + CHAR(13)
SET @sql = @sql + '[verifier_comment], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[annual_app_target_for_traffic_centre_id] [varchar](max) ''$.annual_app_target_for_traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[annual_app_target_total_id] [varchar](max) ''$.annual_app_target_total_id'',' + CHAR(13)
SET @sql = @sql + '[app_target_id] [varchar](max) ''$.app_target_id'',' + CHAR(13)
SET @sql = @sql + '[calendar_month_id] [varchar](max) ''$.calendar_month_id'',' + CHAR(13)
SET @sql = @sql + '[calendar_quarter_id] [varchar](max) ''$.calendar_quarter_id'',' + CHAR(13)
SET @sql = @sql + '[calendar_year_id] [varchar](max) ''$.calendar_year_id'',' + CHAR(13)
SET @sql = @sql + '[quarterly_app_target_for_traffic_centre_id] [varchar](max) ''$.quarterly_app_target_for_traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[quarterly_app_target_total_id] [varchar](max) ''$.quarterly_app_target_total_id'',' + CHAR(13)
SET @sql = @sql + '[tc_who_submitted_id] [varchar](max) ''$.tc_who_submitted_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[app_target_description] [varchar](max) ''$.app_target_description'',' + CHAR(13)
SET @sql = @sql + '[calculated_preliminary_actual] [varchar](max) ''$.calculated_preliminary_actual'',' + CHAR(13)
SET @sql = @sql + '[corrective_action] [varchar](max) ''$.corrective_action'',' + CHAR(13)
SET @sql = @sql + '[created_at] [varchar](max) ''$.created_at'',' + CHAR(13)
SET @sql = @sql + '[date_finalized_by_tc] [varchar](max) ''$.date_finalized_by_tc'',' + CHAR(13)
SET @sql = @sql + '[date_verified] [varchar](max) ''$.date_verified'',' + CHAR(13)
SET @sql = @sql + '[finalized_calculated_preliminary_actual] [varchar](max) ''$.finalized_calculated_preliminary_actual'',' + CHAR(13)
SET @sql = @sql + '[finalized_manually_added_preliminary_actual] [varchar](max) ''$.finalized_manually_added_preliminary_actual'',' + CHAR(13)
SET @sql = @sql + '[finalized_preliminary_actual_total] [varchar](max) ''$.finalized_preliminary_actual_total'',' + CHAR(13)
SET @sql = @sql + '[finalized_verified_actual] [varchar](max) ''$.finalized_verified_actual'',' + CHAR(13)
SET @sql = @sql + '[has_been_verified_key] [varchar](max) ''$.has_been_verified.key'',' + CHAR(13)
SET @sql = @sql + '[has_been_verified_display] [varchar](max) ''$.has_been_verified.display'',' + CHAR(13)
SET @sql = @sql + '[last_date_calculated] [varchar](max) ''$.last_date_calculated'',' + CHAR(13)
SET @sql = @sql + '[last_date_calculate_request_sent] [varchar](max) ''$.last_date_calculate_request_sent'',' + CHAR(13)
SET @sql = @sql + '[manually_added_preliminary_actual] [varchar](max) ''$.manually_added_preliminary_actual'',' + CHAR(13)
SET @sql = @sql + '[national_target] [varchar](max) ''$.national_target'',' + CHAR(13)
SET @sql = @sql + '[percentage_achieved] [varchar](max) ''$.percentage_achieved'',' + CHAR(13)
SET @sql = @sql + '[preliminary_actual_finalized_key] [varchar](max) ''$.preliminary_actual_finalized.key'',' + CHAR(13)
SET @sql = @sql + '[preliminary_actual_finalized_display] [varchar](max) ''$.preliminary_actual_finalized.display'',' + CHAR(13)
SET @sql = @sql + '[preliminary_actual_total] [varchar](max) ''$.preliminary_actual_total'',' + CHAR(13)
SET @sql = @sql + '[regional_director_comment] [varchar](max) ''$.regional_director_comment'',' + CHAR(13)
SET @sql = @sql + '[status_key] [varchar](max) ''$.status.key'',' + CHAR(13)
SET @sql = @sql + '[status_display] [varchar](max) ''$.status.display'',' + CHAR(13)
SET @sql = @sql + '[submitted_by_rd_key] [varchar](max) ''$.submitted_by_rd.key'',' + CHAR(13)
SET @sql = @sql + '[submitted_by_rd_display] [varchar](max) ''$.submitted_by_rd.display'',' + CHAR(13)
SET @sql = @sql + '[target] [varchar](max) ''$.target'',' + CHAR(13)
SET @sql = @sql + '[tc_comment] [varchar](max) ''$.tc_comment'',' + CHAR(13)
SET @sql = @sql + '[verified_actual] [varchar](max) ''$.verified_actual'',' + CHAR(13)
SET @sql = @sql + '[verifier_comment] [varchar](max) ''$.verifier_comment''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

