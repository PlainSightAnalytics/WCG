
CREATE PROCEDURE [itis].[prcExtractcharge_code]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	14-04-2018 03:30:44
-- Reason				:	Reads JSON file and inserts data into Stage table (charge_code)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractcharge_code 'D:\PSA\TCE2\sample\charge_code.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[charge_code]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[charge_code] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[charge_code_category_id], ' + CHAR(13)
SET @sql = @sql + '[charge_code_subcategory_id], ' + CHAR(13)
SET @sql = @sql + '[ag_key], ' + CHAR(13)
SET @sql = @sql + '[ag_display], ' + CHAR(13)
SET @sql = @sql + '[alternative_charge_code], ' + CHAR(13)
SET @sql = @sql + '[amount], ' + CHAR(13)
SET @sql = @sql + '[charge_code], ' + CHAR(13)
SET @sql = @sql + '[charge_short_text], ' + CHAR(13)
SET @sql = @sql + '[charge_text], ' + CHAR(13)
SET @sql = @sql + '[prdp_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_display], ' + CHAR(13)
SET @sql = @sql + '[regulation_number], ' + CHAR(13)
SET @sql = @sql + '[reporting_category], ' + CHAR(13)
SET @sql = @sql + '[reporting_subcategory], ' + CHAR(13)
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
SET @sql = @sql + '[charge_code_category_id], ' + CHAR(13)
SET @sql = @sql + '[charge_code_subcategory_id], ' + CHAR(13)
SET @sql = @sql + '[ag_key], ' + CHAR(13)
SET @sql = @sql + '[ag_display], ' + CHAR(13)
SET @sql = @sql + '[alternative_charge_code], ' + CHAR(13)
SET @sql = @sql + '[amount], ' + CHAR(13)
SET @sql = @sql + '[charge_code], ' + CHAR(13)
SET @sql = @sql + '[charge_short_text], ' + CHAR(13)
SET @sql = @sql + '[charge_text], ' + CHAR(13)
SET @sql = @sql + '[prdp_key], ' + CHAR(13)
SET @sql = @sql + '[prdp_display], ' + CHAR(13)
SET @sql = @sql + '[regulation_number], ' + CHAR(13)
SET @sql = @sql + '[reporting_category], ' + CHAR(13)
SET @sql = @sql + '[reporting_subcategory], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[charge_code_category_id] [varchar](max) ''$.charge_code_category_id'',' + CHAR(13)
SET @sql = @sql + '[charge_code_subcategory_id] [varchar](max) ''$.charge_code_subcategory_id'',' + CHAR(13)
SET @sql = @sql + '[ag_key] [varchar](max) ''$.ag.key'',' + CHAR(13)
SET @sql = @sql + '[ag_display] [varchar](max) ''$.ag.display'',' + CHAR(13)
SET @sql = @sql + '[alternative_charge_code] [varchar](max) ''$.alternative_charge_code'',' + CHAR(13)
SET @sql = @sql + '[amount] [varchar](max) ''$.amount'',' + CHAR(13)
SET @sql = @sql + '[charge_code] [varchar](max) ''$.charge_code'',' + CHAR(13)
SET @sql = @sql + '[charge_short_text] [varchar](max) ''$.charge_short_text'',' + CHAR(13)
SET @sql = @sql + '[charge_text] [varchar](max) ''$.charge_text'',' + CHAR(13)
SET @sql = @sql + '[prdp_key] [varchar](max) ''$.prdp.key'',' + CHAR(13)
SET @sql = @sql + '[prdp_display] [varchar](max) ''$.prdp.display'',' + CHAR(13)
SET @sql = @sql + '[regulation_number] [varchar](max) ''$.regulation_number'',' + CHAR(13)
SET @sql = @sql + '[reporting_category] [varchar](max) ''$.reporting_category'',' + CHAR(13)
SET @sql = @sql + '[reporting_subcategory] [varchar](max) ''$.reporting_subcategory''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

