
CREATE PROCEDURE [itis].[prcExtractviolation_charge]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	14-04-2018 03:30:44
-- Reason				:	Reads JSON file and inserts data into Stage table (violation_charge)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractviolation_charge 'D:\PSA\TCE2\sample\violation_charge.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[violation_charge]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[violation_charge] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[alert_id], ' + CHAR(13)
SET @sql = @sql + '[charge_code_id], ' + CHAR(13)
SET @sql = @sql + '[event_id], ' + CHAR(13)
SET @sql = @sql + '[magistrates_court_id], ' + CHAR(13)
SET @sql = @sql + '[section56_form_id], ' + CHAR(13)
SET @sql = @sql + '[vehicle_id], ' + CHAR(13)
SET @sql = @sql + '[ag_key], ' + CHAR(13)
SET @sql = @sql + '[ag_display], ' + CHAR(13)
SET @sql = @sql + '[alternative_charge_code], ' + CHAR(13)
SET @sql = @sql + '[amount], ' + CHAR(13)
SET @sql = @sql + '[average_kmh], ' + CHAR(13)
SET @sql = @sql + '[category], ' + CHAR(13)
SET @sql = @sql + '[charge_short_text], ' + CHAR(13)
SET @sql = @sql + '[charge_text], ' + CHAR(13)
SET @sql = @sql + '[checkout_action_key], ' + CHAR(13)
SET @sql = @sql + '[checkout_action_display], ' + CHAR(13)
SET @sql = @sql + '[code], ' + CHAR(13)
SET @sql = @sql + '[comments], ' + CHAR(13)
SET @sql = @sql + '[court_code], ' + CHAR(13)
SET @sql = @sql + '[court_date], ' + CHAR(13)
SET @sql = @sql + '[court_name], ' + CHAR(13)
SET @sql = @sql + '[court_no], ' + CHAR(13)
SET @sql = @sql + '[is_asod_key], ' + CHAR(13)
SET @sql = @sql + '[is_asod_display], ' + CHAR(13)
SET @sql = @sql + '[manual_sect56_number], ' + CHAR(13)
SET @sql = @sql + '[payment_date], ' + CHAR(13)
SET @sql = @sql + '[photo], ' + CHAR(13)
SET @sql = @sql + '[prdp_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_display], ' + CHAR(13)
SET @sql = @sql + '[regulation_number], ' + CHAR(13)
SET @sql = @sql + '[removed_at_checkout_key], ' + CHAR(13)
SET @sql = @sql + '[removed_at_checkout_display], ' + CHAR(13)
SET @sql = @sql + '[removed_at_checkout_reason], ' + CHAR(13)
SET @sql = @sql + '[road_section], ' + CHAR(13)
SET @sql = @sql + '[road_section_display_name], ' + CHAR(13)
SET @sql = @sql + '[subcategory], ' + CHAR(13)
SET @sql = @sql + '[timestamp], ' + CHAR(13)
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
SET @sql = @sql + '[alert_id], ' + CHAR(13)
SET @sql = @sql + '[charge_code_id], ' + CHAR(13)
SET @sql = @sql + '[event_id], ' + CHAR(13)
SET @sql = @sql + '[magistrates_court_id], ' + CHAR(13)
SET @sql = @sql + '[section56_form_id], ' + CHAR(13)
SET @sql = @sql + '[vehicle_id], ' + CHAR(13)
SET @sql = @sql + '[ag_key], ' + CHAR(13)
SET @sql = @sql + '[ag_display], ' + CHAR(13)
SET @sql = @sql + '[alternative_charge_code], ' + CHAR(13)
SET @sql = @sql + '[amount], ' + CHAR(13)
SET @sql = @sql + '[average_kmh], ' + CHAR(13)
SET @sql = @sql + '[category], ' + CHAR(13)
SET @sql = @sql + '[charge_short_text], ' + CHAR(13)
SET @sql = @sql + '[charge_text], ' + CHAR(13)
SET @sql = @sql + '[checkout_action_key], ' + CHAR(13)
SET @sql = @sql + '[checkout_action_display], ' + CHAR(13)
SET @sql = @sql + '[code], ' + CHAR(13)
SET @sql = @sql + '[comments], ' + CHAR(13)
SET @sql = @sql + '[court_code], ' + CHAR(13)
SET @sql = @sql + '[court_date], ' + CHAR(13)
SET @sql = @sql + '[court_name], ' + CHAR(13)
SET @sql = @sql + '[court_no], ' + CHAR(13)
SET @sql = @sql + '[is_asod_key], ' + CHAR(13)
SET @sql = @sql + '[is_asod_display], ' + CHAR(13)
SET @sql = @sql + '[manual_sect56_number], ' + CHAR(13)
SET @sql = @sql + '[payment_date], ' + CHAR(13)
SET @sql = @sql + '[photo], ' + CHAR(13)
SET @sql = @sql + '[prdp_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_display], ' + CHAR(13)
SET @sql = @sql + '[regulation_number], ' + CHAR(13)
SET @sql = @sql + '[removed_at_checkout_key], ' + CHAR(13)
SET @sql = @sql + '[removed_at_checkout_display], ' + CHAR(13)
SET @sql = @sql + '[removed_at_checkout_reason], ' + CHAR(13)
SET @sql = @sql + '[road_section], ' + CHAR(13)
SET @sql = @sql + '[road_section_display_name], ' + CHAR(13)
SET @sql = @sql + '[subcategory], ' + CHAR(13)
SET @sql = @sql + '[timestamp], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[alert_id] [varchar](max) ''$.alert_id'',' + CHAR(13)
SET @sql = @sql + '[charge_code_id] [varchar](max) ''$.charge_code_id'',' + CHAR(13)
SET @sql = @sql + '[event_id] [varchar](max) ''$.event_id'',' + CHAR(13)
SET @sql = @sql + '[magistrates_court_id] [varchar](max) ''$.magistrates_court_id'',' + CHAR(13)
SET @sql = @sql + '[section56_form_id] [varchar](max) ''$.section56_form_id'',' + CHAR(13)
SET @sql = @sql + '[vehicle_id] [varchar](max) ''$.vehicle_id'',' + CHAR(13)
SET @sql = @sql + '[ag_key] [varchar](max) ''$.ag.key'',' + CHAR(13)
SET @sql = @sql + '[ag_display] [varchar](max) ''$.ag.display'',' + CHAR(13)
SET @sql = @sql + '[alternative_charge_code] [varchar](max) ''$.alternative_charge_code'',' + CHAR(13)
SET @sql = @sql + '[amount] [varchar](max) ''$.amount'',' + CHAR(13)
SET @sql = @sql + '[average_kmh] [varchar](max) ''$.average_kmh'',' + CHAR(13)
SET @sql = @sql + '[category] [varchar](max) ''$.category'',' + CHAR(13)
SET @sql = @sql + '[charge_short_text] [varchar](max) ''$.charge_short_text'',' + CHAR(13)
SET @sql = @sql + '[charge_text] [varchar](max) ''$.charge_text'',' + CHAR(13)
SET @sql = @sql + '[checkout_action_key] [varchar](max) ''$.checkout_action.key'',' + CHAR(13)
SET @sql = @sql + '[checkout_action_display] [varchar](max) ''$.checkout_action.display'',' + CHAR(13)
SET @sql = @sql + '[code] [varchar](max) ''$.code'',' + CHAR(13)
SET @sql = @sql + '[comments] [varchar](max) ''$.comments'',' + CHAR(13)
SET @sql = @sql + '[court_code] [varchar](max) ''$.court_code'',' + CHAR(13)
SET @sql = @sql + '[court_date] [varchar](max) ''$.court_date'',' + CHAR(13)
SET @sql = @sql + '[court_name] [varchar](max) ''$.court_name'',' + CHAR(13)
SET @sql = @sql + '[court_no] [varchar](max) ''$.court_no'',' + CHAR(13)
SET @sql = @sql + '[is_asod_key] [varchar](max) ''$.is_asod.key'',' + CHAR(13)
SET @sql = @sql + '[is_asod_display] [varchar](max) ''$.is_asod.display'',' + CHAR(13)
SET @sql = @sql + '[manual_sect56_number] [varchar](max) ''$.manual_sect56_number'',' + CHAR(13)
SET @sql = @sql + '[payment_date] [varchar](max) ''$.payment_date'',' + CHAR(13)
SET @sql = @sql + '[photo] [varchar](max) ''$.photo'',' + CHAR(13)
SET @sql = @sql + '[prdp_key] [varchar](max) ''$.prdp.key'',' + CHAR(13)
SET @sql = @sql + '[prdp_display] [varchar](max) ''$.prdp.display'',' + CHAR(13)
SET @sql = @sql + '[regulation_number] [varchar](max) ''$.regulation_number'',' + CHAR(13)
SET @sql = @sql + '[removed_at_checkout_key] [varchar](max) ''$.removed_at_checkout.key'',' + CHAR(13)
SET @sql = @sql + '[removed_at_checkout_display] [varchar](max) ''$.removed_at_checkout.display'',' + CHAR(13)
SET @sql = @sql + '[removed_at_checkout_reason] [varchar](max) ''$.removed_at_checkout_reason'',' + CHAR(13)
SET @sql = @sql + '[road_section] [varchar](max) ''$.road_section'',' + CHAR(13)
SET @sql = @sql + '[road_section_display_name] [varchar](max) ''$.road_section_display_name'',' + CHAR(13)
SET @sql = @sql + '[subcategory] [varchar](max) ''$.subcategory'',' + CHAR(13)
SET @sql = @sql + '[timestamp] [varchar](max) ''$.timestamp''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

