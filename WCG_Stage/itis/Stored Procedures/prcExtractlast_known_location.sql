
CREATE PROCEDURE [itis].[prcExtractlast_known_location]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	22-03-2019 01:46:57
-- Reason				:	Reads JSON file and inserts data into Stage table (last_known_location)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractlast_known_location 'D:\PSA\WCG\changes\WCG-0075 - Last Known Location\sample\last_known_location.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[last_known_location]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[last_known_location] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[device_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[device_name], ' + CHAR(13)
SET @sql = @sql + '[device_number], ' + CHAR(13)
SET @sql = @sql + '[latitude], ' + CHAR(13)
SET @sql = @sql + '[longitude], ' + CHAR(13)
SET @sql = @sql + '[sent_on], ' + CHAR(13)
SET @sql = @sql + '[status_key], ' + CHAR(13)
SET @sql = @sql + '[status_display], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_name], ' + CHAR(13)
SET @sql = @sql + '[user_event_date], ' + CHAR(13)
SET @sql = @sql + '[user_event_id], ' + CHAR(13)
SET @sql = @sql + '[user_event_information], ' + CHAR(13)
SET @sql = @sql + '[user_event_source], ' + CHAR(13)
SET @sql = @sql + '[user_event_subtype], ' + CHAR(13)
SET @sql = @sql + '[user_event_type], ' + CHAR(13)
SET @sql = @sql + '[user_infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[user_name], ' + CHAR(13)
SET @sql = @sql + '[user_rank], ' + CHAR(13)
SET @sql = @sql + '[user_surname], ' + CHAR(13)
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
SET @sql = @sql + '[device_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[user_id], ' + CHAR(13)
SET @sql = @sql + '[device_name], ' + CHAR(13)
SET @sql = @sql + '[device_number], ' + CHAR(13)
SET @sql = @sql + '[latitude], ' + CHAR(13)
SET @sql = @sql + '[longitude], ' + CHAR(13)
SET @sql = @sql + '[sent_on], ' + CHAR(13)
SET @sql = @sql + '[status_key], ' + CHAR(13)
SET @sql = @sql + '[status_display], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_name], ' + CHAR(13)
SET @sql = @sql + '[user_event_date], ' + CHAR(13)
SET @sql = @sql + '[user_event_id], ' + CHAR(13)
SET @sql = @sql + '[user_event_information], ' + CHAR(13)
SET @sql = @sql + '[user_event_source], ' + CHAR(13)
SET @sql = @sql + '[user_event_subtype], ' + CHAR(13)
SET @sql = @sql + '[user_event_type], ' + CHAR(13)
SET @sql = @sql + '[user_infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[user_name], ' + CHAR(13)
SET @sql = @sql + '[user_rank], ' + CHAR(13)
SET @sql = @sql + '[user_surname], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[device_id] [varchar](max) ''$.device_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[user_id] [varchar](max) ''$.user_id'',' + CHAR(13)
SET @sql = @sql + '[device_name] [varchar](max) ''$.device_name'',' + CHAR(13)
SET @sql = @sql + '[device_number] [varchar](max) ''$.device_number'',' + CHAR(13)
SET @sql = @sql + '[latitude] [varchar](max) ''$.latitude'',' + CHAR(13)
SET @sql = @sql + '[longitude] [varchar](max) ''$.longitude'',' + CHAR(13)
SET @sql = @sql + '[sent_on] [varchar](max) ''$.sent_on'',' + CHAR(13)
SET @sql = @sql + '[status_key] [varchar](max) ''$.status.key'',' + CHAR(13)
SET @sql = @sql + '[status_display] [varchar](max) ''$.status.display'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_name] [varchar](max) ''$.traffic_centre_name'',' + CHAR(13)
SET @sql = @sql + '[user_event_date] [varchar](max) ''$.user_event_date'',' + CHAR(13)
SET @sql = @sql + '[user_event_id] [varchar](max) ''$.user_event_id'',' + CHAR(13)
SET @sql = @sql + '[user_event_information] [varchar](max) ''$.user_event_information'',' + CHAR(13)
SET @sql = @sql + '[user_event_source] [varchar](max) ''$.user_event_source'',' + CHAR(13)
SET @sql = @sql + '[user_event_subtype] [varchar](max) ''$.user_event_subtype'',' + CHAR(13)
SET @sql = @sql + '[user_event_type] [varchar](max) ''$.user_event_type'',' + CHAR(13)
SET @sql = @sql + '[user_infrastructure_number] [varchar](max) ''$.user_infrastructure_number'',' + CHAR(13)
SET @sql = @sql + '[user_name] [varchar](max) ''$.user_name'',' + CHAR(13)
SET @sql = @sql + '[user_rank] [varchar](max) ''$.user_rank'',' + CHAR(13)
SET @sql = @sql + '[user_surname] [varchar](max) ''$.user_surname''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

