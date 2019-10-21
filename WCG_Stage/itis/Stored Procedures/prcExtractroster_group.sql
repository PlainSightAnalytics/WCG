

CREATE PROCEDURE [itis].[prcExtractroster_group]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	07-04-2018 01:33:28
-- Reason				:	Reads JSON file and inserts data into Stage table (roster_group)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractroster_group 'D:\PSA\TCE2\sample\roster_group.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[roster_group]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[roster_group] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[created_by_id], ' + CHAR(13)
SET @sql = @sql + '[reports_to_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[user_ppi_id], ' + CHAR(13)
SET @sql = @sql + '[user_spi_id], ' + CHAR(13)
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[deleted_key], ' + CHAR(13)
SET @sql = @sql + '[deleted_display], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
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
SET @sql = @sql + '[created_by_id], ' + CHAR(13)
SET @sql = @sql + '[reports_to_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[user_ppi_id], ' + CHAR(13)
SET @sql = @sql + '[user_spi_id], ' + CHAR(13)
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[deleted_key], ' + CHAR(13)
SET @sql = @sql + '[deleted_display], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[created_by_id] [varchar](max) ''$.created_by_id'',' + CHAR(13)
SET @sql = @sql + '[reports_to_id] [varchar](max) ''$.reports_to_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[user_ppi_id] [varchar](max) ''$.user_ppi_id'',' + CHAR(13)
SET @sql = @sql + '[user_spi_id] [varchar](max) ''$.user_spi_id'',' + CHAR(13)
SET @sql = @sql + '[archived_key] [varchar](max) ''$.archived.key'',' + CHAR(13)
SET @sql = @sql + '[archived_display] [varchar](max) ''$.archived.display'',' + CHAR(13)
SET @sql = @sql + '[deleted_key] [varchar](max) ''$.deleted.key'',' + CHAR(13)
SET @sql = @sql + '[deleted_display] [varchar](max) ''$.deleted.display'',' + CHAR(13)
SET @sql = @sql + '[name] [varchar](max) ''$.name''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)


