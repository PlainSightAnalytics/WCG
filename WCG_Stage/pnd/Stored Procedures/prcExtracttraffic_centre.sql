
CREATE PROCEDURE [pnd].[prcExtracttraffic_centre]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	03-02-2019 11:53:09
-- Reason				:	Reads JSON file and inserts data into Stage table (traffic_centre)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec pnd.prcExtracttraffic_centre 'D:\PSA\WCG\changes\WCG-0067 - Impound\impound\traffic_centre.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [pnd].[traffic_centre]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [pnd].[traffic_centre] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[email], ' + CHAR(13)
SET @sql = @sql + '[handle], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[section_56_email], ' + CHAR(13)
SET @sql = @sql + '[telephone_number], ' + CHAR(13)
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
SET @sql = @sql + '[email], ' + CHAR(13)
SET @sql = @sql + '[handle], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[section_56_email], ' + CHAR(13)
SET @sql = @sql + '[telephone_number], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[email] [varchar](max) ''$.email'',' + CHAR(13)
SET @sql = @sql + '[handle] [varchar](max) ''$.handle'',' + CHAR(13)
SET @sql = @sql + '[name] [varchar](max) ''$.name'',' + CHAR(13)
SET @sql = @sql + '[section_56_email] [varchar](max) ''$.section_56_email'',' + CHAR(13)
SET @sql = @sql + '[telephone_number] [varchar](max) ''$.telephone_number''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

