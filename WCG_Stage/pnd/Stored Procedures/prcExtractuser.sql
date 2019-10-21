
CREATE PROCEDURE [pnd].[prcExtractuser]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Generated from Model
-- Date Created			:	03-02-2019 11:53:09
-- Reason				:	Reads JSON file and inserts data into Stage table (user)
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@FileName, @DeltaLogKey, @AuditKey
-- Ouputs				:	@RowCountStage
-- Test					:	exec pnd.prcExtractuser 'D:\PSA\WCG\changes\WCG-0067 - Impound\impound\user.json'
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

IF @TruncateFlag = 1 TRUNCATE TABLE [pnd].[user]

DECLARE @sql AS NVARCHAR(MAX)

SET @sql = 'DECLARE @json NVARCHAR(MAX) ' + CHAR(13)
SET @sql = @sql + 'SELECT @json = BulkColumn FROM OPENROWSET (BULK ''' + @FileName + ''', SINGLE_CLOB) as j' + CHAR(13)
SET @sql = @sql + 'INSERT INTO [pnd].[user] (' + CHAR(13)
SET @sql = @sql + '[id], ' + CHAR(13)
SET @sql = @sql + '[type], ' + CHAR(13)
SET @sql = @sql + '[updated_at], ' + CHAR(13)
SET @sql = @sql + '[display], ' + CHAR(13)
--Insert Begin
SET @sql = @sql + '[device_id], ' + CHAR(13)
SET @sql = @sql + '[impound_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[email], ' + CHAR(13)
SET @sql = @sql + '[id_number], ' + CHAR(13)
SET @sql = @sql + '[inactive_key], ' + CHAR(13)
SET @sql = @sql + '[inactive_display], ' + CHAR(13)
SET @sql = @sql + '[infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[mobile_number], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[password], ' + CHAR(13)
SET @sql = @sql + '[persal_number], ' + CHAR(13)
SET @sql = @sql + '[rank_key], ' + CHAR(13)
SET @sql = @sql + '[rank_display], ' + CHAR(13)
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
SET @sql = @sql + '[device_id], ' + CHAR(13)
SET @sql = @sql + '[impound_id], ' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id], ' + CHAR(13)
SET @sql = @sql + '[email], ' + CHAR(13)
SET @sql = @sql + '[id_number], ' + CHAR(13)
SET @sql = @sql + '[inactive_key], ' + CHAR(13)
SET @sql = @sql + '[inactive_display], ' + CHAR(13)
SET @sql = @sql + '[infrastructure_number], ' + CHAR(13)
SET @sql = @sql + '[mobile_number], ' + CHAR(13)
SET @sql = @sql + '[name], ' + CHAR(13)
SET @sql = @sql + '[password], ' + CHAR(13)
SET @sql = @sql + '[persal_number], ' + CHAR(13)
SET @sql = @sql + '[rank_key], ' + CHAR(13)
SET @sql = @sql + '[rank_display], ' + CHAR(13)
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
SET @sql = @sql + '[device_id] [varchar](max) ''$.device_id'',' + CHAR(13)
SET @sql = @sql + '[impound_id] [varchar](max) ''$.impound_id'',' + CHAR(13)
SET @sql = @sql + '[traffic_centre_id] [varchar](max) ''$.traffic_centre_id'',' + CHAR(13)
SET @sql = @sql + '[email] [varchar](max) ''$.email'',' + CHAR(13)
SET @sql = @sql + '[id_number] [varchar](max) ''$.id_number'',' + CHAR(13)
SET @sql = @sql + '[inactive_key] [varchar](max) ''$.inactive.key'',' + CHAR(13)
SET @sql = @sql + '[inactive_display] [varchar](max) ''$.inactive.display'',' + CHAR(13)
SET @sql = @sql + '[infrastructure_number] [varchar](max) ''$.infrastructure_number'',' + CHAR(13)
SET @sql = @sql + '[mobile_number] [varchar](max) ''$.mobile_number'',' + CHAR(13)
SET @sql = @sql + '[name] [varchar](max) ''$.name'',' + CHAR(13)
SET @sql = @sql + '[password] [varchar](max) ''$.password'',' + CHAR(13)
SET @sql = @sql + '[persal_number] [varchar](max) ''$.persal_number'',' + CHAR(13)
SET @sql = @sql + '[rank_key] [varchar](max) ''$.rank.key'',' + CHAR(13)
SET @sql = @sql + '[rank_display] [varchar](max) ''$.rank.display'',' + CHAR(13)
SET @sql = @sql + '[role_key] [varchar](max) ''$.role.key'',' + CHAR(13)
SET @sql = @sql + '[role_display] [varchar](max) ''$.role.display'',' + CHAR(13)
SET @sql = @sql + '[surname] [varchar](max) ''$.surname''' + CHAR(13)
--WITH End
SET @sql = @sql + ')' + CHAR(13)

EXEC(@SQL)

