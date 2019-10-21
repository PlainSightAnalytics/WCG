
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

SET NOCOUNT ON/* Declare Variables */DECLARE @HighWaterDateTime AS VARCHAR(20), @RowCountStage AS INT,@RowCountExcluded AS INT/* CTE for ID's and Unique Dates */
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
WHERE stg.DeltaLogKey = @DeltaLogKeySELECT @RowCountExcluded = @@ROWCOUNTSELECT 	@HighWaterDateTime = MAX(updated_at), 	@RowCountStage = COUNT(1)FROM dbo.eventWHERE DeltaLogKey = @DeltaLogKeyUPDATE WCG_DW.dbo.DimDeltaLog SET 	RowCountStage = @RowCountStage, 	HighWaterDateTime = @HighWaterDateTime,	RowCountExcluded = @RowCountExcludedWHERE DeltaLogKey = @DeltaLogKey
;
;