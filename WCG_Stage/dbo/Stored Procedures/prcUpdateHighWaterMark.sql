

CREATE PROCEDURE [dbo].[prcUpdateHighWaterMark]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14-06-2016
-- Reason				:	Updates or Creates High Water mark on DimDeltaLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ClientName, @SchemaName, @ObjectName, @HighWaterDateTime
-- Ouputs				:	@RowUpdated
-- Test					:	exec prcUpdateHighWaterMark 'WCG', 'ebat', 'authority', '2016-09-07T13:41:32Z'
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@ClientName			VARCHAR(50),
@SchemaName			VARCHAR(50),
@ObjectName			VARCHAR(50),
@HighWaterDateTime	VARCHAR(20),
@RowCountSource		INT,
@RowUpdated			INT OUTPUT,
@DeltaLogKey		INT = -1 OUTPUT

AS

MERGE INTO WCG_DW.dbo.DimDeltaLog dl
USING (SELECT @ClientName AS ClientName, @SchemaName AS SchemaName, @ObjectName AS ObjectName, @HighWaterDateTime AS HighWaterDateTime, @RowCountSource AS RowCountSource) prm
ON (dl.ClientName = prm.ClientName AND dl.SchemaName = prm.SchemaName AND dl.ObjectName = prm.ObjectName)

WHEN NOT MATCHED THEN
	INSERT (ClientName, SchemaName, ObjectName, HighWaterDateTime, LogDate, RowCountSource)
	VALUES (prm.ClientName, prm.SchemaName, prm.ObjectName, prm.HighWaterDateTime, GETDATE(), RowCountSource)

WHEN MATCHED 
	AND dl.HighWaterDateTime <> prm.HighWaterDateTime
	THEN 
		UPDATE 
			SET 
			HighWaterDateTime = prm.HighWaterDateTime,
			RowCountSource = prm.RowCountSource,
			LoadFlag = 0,
			LogDate = GETDATE();			

SET @RowUpdated = @@ROWCOUNT

SELECT @DeltaLogKey = DeltaLogKey 
FROM WCG_DW.dbo.DimDeltaLog
WHERE 
	ClientName = @ClientName
AND SchemaName = @SchemaName
AND ObjectName = @ObjectName






