﻿
CREATE PROCEDURE [dbo].[prcUpdateDimDeltaLogEvent]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14-06-2016
-- Reason				:	Updates record on DimDeltaLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@DeltaLogKey, @AuditKey, @StageTable
-- Ouputs				:
-- Test					:	exec dbo.prcUpdateDimDeltaLogEvent 3016, 4051
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@DeltaLogKey		INT,
@AuditKey			INT = -1

AS

SET NOCOUNT ON
;WITH CTE AS (
SELECT id, updated_at
FROM dbo.event
WHERE DeltaLogKey <> @DeltaLogKey
AND ExcludeFlag = 0)

/* Update Excluded Flag 1 = Same Id and Same Date, 2 = Same Id and Different Date */
UPDATE stg 
SET ExcludeFlag = 
	CASE 
		WHEN stg.updated_at <> cte.updated_at THEN 1 
		ELSE 2 
	END
FROM dbo.event stg
INNER JOIN CTE ON stg.id = cte.id
WHERE stg.DeltaLogKey = @DeltaLogKey
;
;