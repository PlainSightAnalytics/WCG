﻿

CREATE PROCEDURE [dbo].[prcGetHighWaterDateTimeLastKnownLocation]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	24-03-2019
-- Reason				:	Gets High Water Datetime from itis.last_known_location
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	None
-- Ouputs				:	@HighWaterDateTime
-- Test					:	prcGetHighWaterDateTimeLastKnownLocation 1
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@HighWaterDateTime	VARCHAR(20) OUTPUT

AS

DECLARE @HighWaterDateTimeResult AS VARCHAR(20) 

SET NOCOUNT ON

/* Remove data older than 48 hours */
DELETE
FROM itis.last_known_location
WHERE updated_at < DATEADD(d,-2,GETUTCDATE())

/* Return HighWater Date  */
SELECT @HighWaterDateTimeResult = MAX(updated_at)
FROM WCG_Stage.itis.last_known_location

IF @HighWaterDateTimeResult IS NULL
	SELECT @HighWaterDateTime = CONCAT(CONVERT(VARCHAR(19), DATEADD(d,-2,GETUTCDATE()) ,126),'Z')
ELSE 
	SELECT @HighWaterDateTime = @HighWaterDateTimeResult










;
;