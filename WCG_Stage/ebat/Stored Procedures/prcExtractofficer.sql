

CREATE PROCEDURE [ebat].[prcExtractofficer]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	12-08-2016 04:57:38
-- Reason				:	Reads JSON file and inserts data into Stage table (officer)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec ebat.prcExtractofficer 'F:\PSA\WCG\v3\data\officer.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [ebat].[officer]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [ebat].[officer] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[authority_id], ' + CHAR(13)
SET @sql = @sql + '[rank_id], ' + CHAR(13)
SET @sql = @sql + '[station_id], ' + CHAR(13)
SET @sql = @sql + '[officer_full_name], ' + CHAR(13)
SET @sql = @sql + '[officer_id_number], ' + CHAR(13)
SET @sql = @sql + '[officer_infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[officer_initials], ' + CHAR(13)
SET @sql = @sql + '[officer_mobile_number], ' + CHAR(13)
SET @sql = @sql + '[officer_surname], ' + CHAR(13)
SET @sql = @sql + '[other_authority], ' + CHAR(13)
SET @sql = @sql + '[other_rank], ' + CHAR(13)
SET @sql = @sql + '[other_station], ' + CHAR(13)
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
SET @sql = @sql + '[authority_id], ' + CHAR(13)
SET @sql = @sql + '[rank_id], ' + CHAR(13)
SET @sql = @sql + '[station_id], ' + CHAR(13)
SET @sql = @sql + '[officer_full_name], ' + CHAR(13)
SET @sql = @sql + '[officer_id_number], ' + CHAR(13)
SET @sql = @sql + '[officer_infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[officer_initials], ' + CHAR(13)
SET @sql = @sql + '[officer_mobile_number], ' + CHAR(13)
SET @sql = @sql + '[officer_surname], ' + CHAR(13)
SET @sql = @sql + '[other_authority], ' + CHAR(13)
SET @sql = @sql + '[other_rank], ' + CHAR(13)
SET @sql = @sql + '[other_station], ' + CHAR(13)
--Select End
SET @sql = @sql + CAST(@DeltaLogKey AS VARCHAR(10)) + ',' + CAST(@AuditKey AS VARCHAR(10)) +  CHAR(13)
SET @sql = @sql + 'FROM OPENJSON(@json, ''$.objects'') '   + CHAR(13)
SET @sql = @sql + 'WITH ( ' + CHAR(13)
--WITH Begin
SET @sql = @sql + '[id] [uniqueidentifier] ''$.id'',' + CHAR(13)
SET @sql = @sql + '[type] [nvarchar](max) ''$.type'',' + CHAR(13)
SET @sql = @sql + '[updated_at] [nvarchar](max) ''$.updated_at'',' + CHAR(13)
SET @sql = @sql + '[display] [nvarchar](max) ''$.display'',' + CHAR(13)
SET @sql = @sql + '[authority_id] [varchar](max) ''$.authority_id'',' + CHAR(13)
SET @sql = @sql + '[rank_id] [varchar](max) ''$.rank_id'',' + CHAR(13)
SET @sql = @sql + '[station_id] [varchar](max) ''$.station_id'',' + CHAR(13)
SET @sql = @sql + '[officer_full_name] [varchar](max) ''$.officer_full_name'',' + CHAR(13)
SET @sql = @sql + '[officer_id_number] [varchar](max) ''$.officer_id_number'',' + CHAR(13)
SET @sql = @sql + '[officer_infrastructure_number] [varchar](max) ''$.officer_infrastructure_number'',' + CHAR(13)
SET @sql = @sql + '[officer_initials] [varchar](max) ''$.officer_initials'',' + CHAR(13)
SET @sql = @sql + '[officer_mobile_number] [varchar](max) ''$.officer_mobile_number'',' + CHAR(13)
SET @sql = @sql + '[officer_surname] [varchar](max) ''$.officer_surname'',' + CHAR(13)
SET @sql = @sql + '[other_authority] [varchar](max) ''$.other_authority'',' + CHAR(13)
SET @sql = @sql + '[other_rank] [varchar](max) ''$.other_rank'',' + CHAR(13)
SET @sql = @sql + '[other_station] [varchar](max) ''$.other_station''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)


;
