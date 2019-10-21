
CREATE PROCEDURE [dbo].[prcGetHighWaterMarkAlerts]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	6 August 2016
-- Reason				:	Gets High Water Id from DeltaLog for Alerts
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ClientName, @SchemaName
-- Ouputs				:	@HighWaterDateTime
-- Test					:	prcGetHighWaterMarkAlerts 'ITIS', 'dbo',  1
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------
@ClientName			VARCHAR(50) = 'Unknown',
@SchemaName			VARCHAR(50) = 'Unknown',
@HighWaterMark		VARCHAR(20) OUTPUT

AS

DECLARE @HighWaterMarkResult AS INT 

SET NOCOUNT ON

/* Return HighWater Date  */
SELECT @HighWaterMarkResult = MAX(CAST(HighWaterMark AS INT))
FROM WCG_DW.dbo.DimDeltaLog
WHERE ClientName = @ClientName
AND SchemaName = @SchemaName
AND ObjectName = 'Alerts'

IF @HighWaterMarkResult IS NULL
	SELECT @HighWaterMark = '0'
ELSE 
	SELECT @HighWaterMark = CAST(@HighWaterMarkResult AS VARCHAR(20))










;

;


