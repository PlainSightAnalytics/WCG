
CREATE PROCEDURE [itis].[prcExtractasod_road_section]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	14-04-2018 03:30:45
-- Reason				:	Reads JSON file and inserts data into Stage table (asod_road_section)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractasod_road_section 'D:\PSA\TCE2\sample\asod_road_section.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[asod_road_section]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[asod_road_section] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[magistrates_court_id], ' + CHAR(13)
SET @sql = @sql + '[operational_area_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[asod_distance], ' + CHAR(13)
SET @sql = @sql + '[displayed_name], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
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
SET @sql = @sql + '[magistrates_court_id], ' + CHAR(13)
SET @sql = @sql + '[operational_area_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[asod_distance], ' + CHAR(13)
SET @sql = @sql + '[displayed_name], ' + CHAR(13)
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
SET @sql = @sql + '[magistrates_court_id] [varchar](max) ''$.magistrates_court_id'',' + CHAR(13)
SET @sql = @sql + '[operational_area_id] [varchar](max) ''$.operational_area_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[asod_distance] [varchar](max) ''$.asod_distance'',' + CHAR(13)
SET @sql = @sql + '[displayed_name] [varchar](max) ''$.displayed_name'',' + CHAR(13)
SET @sql = @sql + '[name] [varchar](max) ''$.name''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

