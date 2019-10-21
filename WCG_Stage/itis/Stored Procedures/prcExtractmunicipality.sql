
CREATE PROCEDURE [itis].[prcExtractmunicipality]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	21-08-2016 04:38:20
-- Reason				:	Reads JSON file and inserts data into Stage table (municipality)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractmunicipality 'F:\PSA\WCG\itis\data\samplesmunicipality.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[municipality]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[municipality] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[district_id], ' + CHAR(13)
SET @sql = @sql + '[electronic_payment], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[place_of_payment], ' + CHAR(13)
SET @sql = @sql + '[post_payment], ' + CHAR(13)
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
SET @sql = @sql + '[district_id], ' + CHAR(13)
SET @sql = @sql + '[electronic_payment], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[place_of_payment], ' + CHAR(13)
SET @sql = @sql + '[post_payment], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[district_id] [varchar](max) ''$.district_id'',' + CHAR(13)
SET @sql = @sql + '[electronic_payment] [varchar](max) ''$.electronic_payment'',' + CHAR(13)
SET @sql = @sql + '[name] [varchar](max) ''$.name'',' + CHAR(13)
SET @sql = @sql + '[place_of_payment] [varchar](max) ''$.place_of_payment'',' + CHAR(13)
SET @sql = @sql + '[post_payment] [varchar](max) ''$.post_payment''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)


;