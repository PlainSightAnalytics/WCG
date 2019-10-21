

CREATE PROCEDURE [ebat].[prcExtractuser]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	12-08-2016 04:57:37
-- Reason				:	Reads JSON file and inserts data into Stage table (user)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec ebat.prcExtractuser 'F:\PSA\WCG\v3\data\user.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [ebat].[user]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [ebat].[user] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[centre_id], ' + CHAR(13)
SET @sql = @sql + '[ebat_operator_key], ' + CHAR(13)
SET @sql = @sql + '[ebat_operator_display], ' + CHAR(13)
SET @sql = @sql + '[id_number], ' + CHAR(13)
SET @sql = @sql + '[infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[operator_certificate], ' + CHAR(13)
SET @sql = @sql + '[password], ' + CHAR(13)
SET @sql = @sql + '[role_key], ' + CHAR(13)
SET @sql = @sql + '[role_display], ' + CHAR(13)
SET @sql = @sql + '[surname], ' + CHAR(13)
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
SET @sql = @sql + '[ebat_operator_key], ' + CHAR(13)
SET @sql = @sql + '[ebat_operator_display], ' + CHAR(13)
SET @sql = @sql + '[id_number], ' + CHAR(13)
SET @sql = @sql + '[infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[operator_certificate], ' + CHAR(13)
SET @sql = @sql + '[password], ' + CHAR(13)
SET @sql = @sql + '[role_key], ' + CHAR(13)
SET @sql = @sql + '[role_display], ' + CHAR(13)
SET @sql = @sql + '[surname], ' + CHAR(13)
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
SET @sql = @sql + '[ebat_operator_key] [varchar](max) ''$.ebat_operator.key'',' + CHAR(13)
SET @sql = @sql + '[ebat_operator_display] [varchar](max) ''$.ebat_operator.display'',' + CHAR(13)
SET @sql = @sql + '[id_number] [varchar](max) ''$.id_number'',' + CHAR(13)
SET @sql = @sql + '[infrastructure_number] [varchar](max) ''$.infrastructure_number'',' + CHAR(13)
SET @sql = @sql + '[name] [varchar](max) ''$.name'',' + CHAR(13)
SET @sql = @sql + '[operator_certificate] [varchar](max) ''$.operator_certificate'',' + CHAR(13)
SET @sql = @sql + '[password] [varchar](max) ''$.password'',' + CHAR(13)
SET @sql = @sql + '[role_key] [varchar](max) ''$.role.key'',' + CHAR(13)
SET @sql = @sql + '[role_display] [varchar](max) ''$.role.display'',' + CHAR(13)
SET @sql = @sql + '[surname] [varchar](max) ''$.surname''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)


;
