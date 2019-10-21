
CREATE PROCEDURE [pnd].[prcExtractviolation]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	03-02-2019 11:53:09
-- Reason				:	Reads JSON file and inserts data into Stage table (violation)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec pnd.prcExtractviolation 'D:\PSA\WCG\changes\WCG-0067 - Impound\impound\violation.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [pnd].[violation]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [pnd].[violation] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[impound_instruction_id], ' + CHAR(13)
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[created_at], ' + CHAR(13)
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[section_details], ' + CHAR(13)
SET @sql = @sql + '[violation_code], ' + CHAR(13)
SET @sql = @sql + '[violation_type_key], ' + CHAR(13)
SET @sql = @sql + '[violation_type_display], ' + CHAR(13)
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
SET @sql = @sql + '[impound_instruction_id], ' + CHAR(13)
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[created_at], ' + CHAR(13)
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[section_details], ' + CHAR(13)
SET @sql = @sql + '[violation_code], ' + CHAR(13)
SET @sql = @sql + '[violation_type_key], ' + CHAR(13)
SET @sql = @sql + '[violation_type_display], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[impound_instruction_id] [varchar](max) ''$.impound_instruction_id'',' + CHAR(13)
SET @sql = @sql + '[archived_key] [varchar](max) ''$.archived.key'',' + CHAR(13)
SET @sql = @sql + '[archived_display] [varchar](max) ''$.archived.display'',' + CHAR(13)
SET @sql = @sql + '[created_at] [varchar](max) ''$.created_at'',' + CHAR(13)
SET @sql = @sql + '[description] [varchar](max) ''$.description'',' + CHAR(13)
SET @sql = @sql + '[section_details] [varchar](max) ''$.section_details'',' + CHAR(13)
SET @sql = @sql + '[violation_code] [varchar](max) ''$.violation_code'',' + CHAR(13)
SET @sql = @sql + '[violation_type_key] [varchar](max) ''$.violation_type.key'',' + CHAR(13)
SET @sql = @sql + '[violation_type_display] [varchar](max) ''$.violation_type.display''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

