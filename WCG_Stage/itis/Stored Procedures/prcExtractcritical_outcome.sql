
CREATE PROCEDURE [itis].[prcExtractcritical_outcome]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	14-04-2018 03:30:44
-- Reason				:	Reads JSON file and inserts data into Stage table (critical_outcome)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec itis.prcExtractcritical_outcome 'D:\PSA\TCE2\sample\critical_outcome.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [itis].[critical_outcome]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [itis].[critical_outcome] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[shift_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[bus_stopped], ' + CHAR(13)
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[hmv_stopped], ' + CHAR(13)
SET @sql = @sql + '[ldv_stopped], ' + CHAR(13)
SET @sql = @sql + '[lmv_stopped], ' + CHAR(13)
SET @sql = @sql + '[midibus_stopped], ' + CHAR(13)
SET @sql = @sql + '[minibus_stopped], ' + CHAR(13)
SET @sql = @sql + '[motorcycle_stopped], ' + CHAR(13)
SET @sql = @sql + '[mpv_stopped], ' + CHAR(13)
SET @sql = @sql + '[order], ' + CHAR(13)
SET @sql = @sql + '[other_stopped], ' + CHAR(13)
SET @sql = @sql + '[outcome_type_key], ' + CHAR(13)
SET @sql = @sql + '[outcome_type_display], ' + CHAR(13)
SET @sql = @sql + '[started_filling_in_key], ' + CHAR(13)
SET @sql = @sql + '[started_filling_in_display], ' + CHAR(13)
SET @sql = @sql + '[system_populated_outcome_key], ' + CHAR(13)
SET @sql = @sql + '[system_populated_outcome_display], ' + CHAR(13)
SET @sql = @sql + '[taxi_stopped], ' + CHAR(13)
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
SET @sql = @sql + '[shift_statistic_id], ' + CHAR(13)
SET @sql = @sql + '[bus_stopped], ' + CHAR(13)
SET @sql = @sql + '[description], ' + CHAR(13)
SET @sql = @sql + '[hmv_stopped], ' + CHAR(13)
SET @sql = @sql + '[ldv_stopped], ' + CHAR(13)
SET @sql = @sql + '[lmv_stopped], ' + CHAR(13)
SET @sql = @sql + '[midibus_stopped], ' + CHAR(13)
SET @sql = @sql + '[minibus_stopped], ' + CHAR(13)
SET @sql = @sql + '[motorcycle_stopped], ' + CHAR(13)
SET @sql = @sql + '[mpv_stopped], ' + CHAR(13)
SET @sql = @sql + '[order], ' + CHAR(13)
SET @sql = @sql + '[other_stopped], ' + CHAR(13)
SET @sql = @sql + '[outcome_type_key], ' + CHAR(13)
SET @sql = @sql + '[outcome_type_display], ' + CHAR(13)
SET @sql = @sql + '[started_filling_in_key], ' + CHAR(13)
SET @sql = @sql + '[started_filling_in_display], ' + CHAR(13)
SET @sql = @sql + '[system_populated_outcome_key], ' + CHAR(13)
SET @sql = @sql + '[system_populated_outcome_display], ' + CHAR(13)
SET @sql = @sql + '[taxi_stopped], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[shift_statistic_id] [varchar](max) ''$.shift_statistic_id'',' + CHAR(13)
SET @sql = @sql + '[bus_stopped] [varchar](max) ''$.bus_stopped'',' + CHAR(13)
SET @sql = @sql + '[description] [varchar](max) ''$.description'',' + CHAR(13)
SET @sql = @sql + '[hmv_stopped] [varchar](max) ''$.hmv_stopped'',' + CHAR(13)
SET @sql = @sql + '[ldv_stopped] [varchar](max) ''$.ldv_stopped'',' + CHAR(13)
SET @sql = @sql + '[lmv_stopped] [varchar](max) ''$.lmv_stopped'',' + CHAR(13)
SET @sql = @sql + '[midibus_stopped] [varchar](max) ''$.midibus_stopped'',' + CHAR(13)
SET @sql = @sql + '[minibus_stopped] [varchar](max) ''$.minibus_stopped'',' + CHAR(13)
SET @sql = @sql + '[motorcycle_stopped] [varchar](max) ''$.motorcycle_stopped'',' + CHAR(13)
SET @sql = @sql + '[mpv_stopped] [varchar](max) ''$.mpv_stopped'',' + CHAR(13)
SET @sql = @sql + '[order] [varchar](max) ''$.order'',' + CHAR(13)
SET @sql = @sql + '[other_stopped] [varchar](max) ''$.other_stopped'',' + CHAR(13)
SET @sql = @sql + '[outcome_type_key] [varchar](max) ''$.outcome_type.key'',' + CHAR(13)
SET @sql = @sql + '[outcome_type_display] [varchar](max) ''$.outcome_type.display'',' + CHAR(13)
SET @sql = @sql + '[started_filling_in_key] [varchar](max) ''$.started_filling_in.key'',' + CHAR(13)
SET @sql = @sql + '[started_filling_in_display] [varchar](max) ''$.started_filling_in.display'',' + CHAR(13)
SET @sql = @sql + '[system_populated_outcome_key] [varchar](max) ''$.system_populated_outcome.key'',' + CHAR(13)
SET @sql = @sql + '[system_populated_outcome_display] [varchar](max) ''$.system_populated_outcome.display'',' + CHAR(13)
SET @sql = @sql + '[taxi_stopped] [varchar](max) ''$.taxi_stopped''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

