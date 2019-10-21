
CREATE PROCEDURE [itis].[prcExtractroad_safety_topic]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	05-04-2019 12:10:44
-- Reason				:	Reads JSON file and inserts data into Stage table (road_safety_topic)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractroad_safety_topic 'D:\PSA\WCG\changes\WCG-0078 - Public Transport Changes\sample\road_safety_topic.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[road_safety_topic]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[road_safety_topic] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[date_created], ' + CHAR(13)
SET @sql = @sql + '[sequence_number], ' + CHAR(13)
SET @sql = @sql + '[topic], ' + CHAR(13)
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
SET @sql = @sql + '[archived_key], ' + CHAR(13)
SET @sql = @sql + '[archived_display], ' + CHAR(13)
SET @sql = @sql + '[date_created], ' + CHAR(13)
SET @sql = @sql + '[sequence_number], ' + CHAR(13)
SET @sql = @sql + '[topic], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[archived_key] [varchar](max) ''$.archived.key'',' + CHAR(13)
SET @sql = @sql + '[archived_display] [varchar](max) ''$.archived.display'',' + CHAR(13)
SET @sql = @sql + '[date_created] [varchar](max) ''$.date_created'',' + CHAR(13)
SET @sql = @sql + '[sequence_number] [varchar](max) ''$.sequence_number'',' + CHAR(13)
SET @sql = @sql + '[topic] [varchar](max) ''$.topic''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

