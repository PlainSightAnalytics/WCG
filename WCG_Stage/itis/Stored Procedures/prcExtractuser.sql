
CREATE PROCEDURE [itis].[prcExtractuser]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-04-2018 01:33:27
-- Reason				:	Reads JSON file and inserts data into Stage table (user)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractuser 'D:\PSA\TCE2\sample\user.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[user]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[user] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[current_activity_id], ' + CHAR(13)
SET @sql = @sql + '[current_alert_id], ' + CHAR(13)
SET @sql = @sql + '[current_day_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[current_month_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[current_shift_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[last_potential_violation_id], ' + CHAR(13)
SET @sql = @sql + '[operational_area_id], ' + CHAR(13)
SET @sql = @sql + '[ppi_id], ' + CHAR(13)
SET @sql = @sql + '[roster_group_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[designation], ' + CHAR(13)
SET @sql = @sql + '[email], ' + CHAR(13)
SET @sql = @sql + '[id_number], ' + CHAR(13)
SET @sql = @sql + '[inactive_key], ' + CHAR(13)
SET @sql = @sql + '[inactive_display], ' + CHAR(13)
SET @sql = @sql + '[infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[is_control_room_key], ' + CHAR(13)
SET @sql = @sql + '[is_control_room_display], ' + CHAR(13)
SET @sql = @sql + '[mobile_number], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[password], ' + CHAR(13)
SET @sql = @sql + '[persal_number], ' + CHAR(13)
SET @sql = @sql + '[provincial_key], ' + CHAR(13)
SET @sql = @sql + '[provincial_display], ' + CHAR(13)
SET @sql = @sql + '[rank_key], ' + CHAR(13)
SET @sql = @sql + '[rank_display], ' + CHAR(13)
SET @sql = @sql + '[role_key], ' + CHAR(13)
SET @sql = @sql + '[role_display], ' + CHAR(13)
SET @sql = @sql + '[sect_56_nn], ' + CHAR(13)
SET @sql = @sql + '[sect_56_nnn], ' + CHAR(13)
SET @sql = @sql + '[surname], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_string], ' + CHAR(13)
SET @sql = @sql + '[work_number], ' + CHAR(13)
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
SET @sql = @sql + '[current_activity_id], ' + CHAR(13)
SET @sql = @sql + '[current_alert_id], ' + CHAR(13)
SET @sql = @sql + '[current_day_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[current_month_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[current_shift_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[last_potential_violation_id], ' + CHAR(13)
SET @sql = @sql + '[operational_area_id], ' + CHAR(13)
SET @sql = @sql + '[ppi_id], ' + CHAR(13)
SET @sql = @sql + '[roster_group_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[designation], ' + CHAR(13)
SET @sql = @sql + '[email], ' + CHAR(13)
SET @sql = @sql + '[id_number], ' + CHAR(13)
SET @sql = @sql + '[inactive_key], ' + CHAR(13)
SET @sql = @sql + '[inactive_display], ' + CHAR(13)
SET @sql = @sql + '[infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[is_control_room_key], ' + CHAR(13)
SET @sql = @sql + '[is_control_room_display], ' + CHAR(13)
SET @sql = @sql + '[mobile_number], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[password], ' + CHAR(13)
SET @sql = @sql + '[persal_number], ' + CHAR(13)
SET @sql = @sql + '[provincial_key], ' + CHAR(13)
SET @sql = @sql + '[provincial_display], ' + CHAR(13)
SET @sql = @sql + '[rank_key], ' + CHAR(13)
SET @sql = @sql + '[rank_display], ' + CHAR(13)
SET @sql = @sql + '[role_key], ' + CHAR(13)
SET @sql = @sql + '[role_display], ' + CHAR(13)
SET @sql = @sql + '[sect_56_nn], ' + CHAR(13)
SET @sql = @sql + '[sect_56_nnn], ' + CHAR(13)
SET @sql = @sql + '[surname], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_string], ' + CHAR(13)
SET @sql = @sql + '[work_number], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[current_activity_id] [varchar](max) ''$.current_activity_id'',' + CHAR(13)
SET @sql = @sql + '[current_alert_id] [varchar](max) ''$.current_alert_id'',' + CHAR(13)
SET @sql = @sql + '[current_day_statistic_id] [varchar](max) ''$.current_day_statistic_id'',' + CHAR(13)
SET @sql = @sql + '[current_month_statistic_id] [varchar](max) ''$.current_month_statistic_id'',' + CHAR(13)
SET @sql = @sql + '[current_shift_statistic_id] [varchar](max) ''$.current_shift_statistic_id'',' + CHAR(13)
SET @sql = @sql + '[last_potential_violation_id] [varchar](max) ''$.last_potential_violation_id'',' + CHAR(13)
SET @sql = @sql + '[operational_area_id] [varchar](max) ''$.operational_area_id'',' + CHAR(13)
SET @sql = @sql + '[ppi_id] [varchar](max) ''$.ppi_id'',' + CHAR(13)
SET @sql = @sql + '[roster_group_id] [varchar](max) ''$.roster_group_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[designation] [varchar](max) ''$.designation'',' + CHAR(13)
SET @sql = @sql + '[email] [varchar](max) ''$.email'',' + CHAR(13)
SET @sql = @sql + '[id_number] [varchar](max) ''$.id_number'',' + CHAR(13)
SET @sql = @sql + '[inactive_key] [varchar](max) ''$.inactive.key'',' + CHAR(13)
SET @sql = @sql + '[inactive_display] [varchar](max) ''$.inactive.display'',' + CHAR(13)
SET @sql = @sql + '[infrastructure_number] [varchar](max) ''$.infrastructure_number'',' + CHAR(13)
SET @sql = @sql + '[is_control_room_key] [varchar](max) ''$.is_control_room.key'',' + CHAR(13)
SET @sql = @sql + '[is_control_room_display] [varchar](max) ''$.is_control_room.display'',' + CHAR(13)
SET @sql = @sql + '[mobile_number] [varchar](max) ''$.mobile_number'',' + CHAR(13)
SET @sql = @sql + '[name] [varchar](max) ''$.name'',' + CHAR(13)
SET @sql = @sql + '[password] [varchar](max) ''$.password'',' + CHAR(13)
SET @sql = @sql + '[persal_number] [varchar](max) ''$.persal_number'',' + CHAR(13)
SET @sql = @sql + '[provincial_key] [varchar](max) ''$.provincial.key'',' + CHAR(13)
SET @sql = @sql + '[provincial_display] [varchar](max) ''$.provincial.display'',' + CHAR(13)
SET @sql = @sql + '[rank_key] [varchar](max) ''$.rank.key'',' + CHAR(13)
SET @sql = @sql + '[rank_display] [varchar](max) ''$.rank.display'',' + CHAR(13)
SET @sql = @sql + '[role_key] [varchar](max) ''$.role.key'',' + CHAR(13)
SET @sql = @sql + '[role_display] [varchar](max) ''$.role.display'',' + CHAR(13)
SET @sql = @sql + '[sect_56_nn] [varchar](max) ''$.sect_56_nn'',' + CHAR(13)
SET @sql = @sql + '[sect_56_nnn] [varchar](max) ''$.sect_56_nnn'',' + CHAR(13)
SET @sql = @sql + '[surname] [varchar](max) ''$.surname'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_string] [varchar](max) ''$.traffic_centre_string'',' + CHAR(13)
SET @sql = @sql + '[work_number] [varchar](max) ''$.work_number''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

