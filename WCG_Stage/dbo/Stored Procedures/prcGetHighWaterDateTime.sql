

CREATE PROCEDURE [dbo].[prcGetHighWaterDateTime]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-06-2016
-- Reason				:	Gets High Water Datetime from DeltaLog for an object
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ClientName, @SchemaName, @ObjectName
-- Ouputs				:	@HighWaterDateTime
-- Test					:	uspGetHighWaterDateTime 'ITIS', 'dbo', 'activity', 1
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------
@ClientName			VARCHAR(50) = 'Unknown',
@SchemaName			VARCHAR(50) = 'Unknown',
@ObjectName			VARCHAR(50) = 'Unknown',
@HighWaterDateTime	VARCHAR(20) OUTPUT

AS

DECLARE @HighWaterDateTimeResult AS VARCHAR(20) 

SET NOCOUNT ON

/* Return HighWater Date  */
SELECT @HighWaterDateTimeResult = MAX(HighWaterDateTime)
FROM WCG_DW.dbo.DimDeltaLog
--WHERE LoadFlag = 1
WHERE ClientName = @ClientName
AND SchemaName = @SchemaName
AND ObjectName = @ObjectName

IF @HighWaterDateTimeResult IS NULL
	SELECT @HighWaterDateTime = '1900-01-01T00:00:00Z'
ELSE 
	SELECT @HighWaterDateTime = @HighWaterDateTimeResult










;
;