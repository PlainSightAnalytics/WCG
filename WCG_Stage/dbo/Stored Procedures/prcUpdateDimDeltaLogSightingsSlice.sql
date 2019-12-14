
CREATE PROCEDURE [dbo].[prcUpdateDimDeltaLogSightingsSlice]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-12-2019
-- Reason				:	Updates record on DimDeltaLog for SightingsSlice
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@DeltaLogKey, @AuditKey
-- Ouputs				:
-- Test					:	exec dbo.prcUpdateDimDeltaLogSightingsSlice 3016, 4051
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@DeltaLogKey		INT,
@AuditKey			INT = -1

AS

SET NOCOUNT ON

/* Declare Variables */
DECLARE 
@HighWaterMark AS VARCHAR(20), 
@RowCountStage AS INT,
@RowCountExcluded AS INT

/* Update DeltaLogKey */
UPDATE cle.SightingsSlice 
SET DeltaLogKey = @DeltaLogKey
WHERE DeltaLogKey IS NULL
OR DeltalogKey = 0

SELECT @RowCountStage = @@ROWCOUNT

SELECT @HighWaterMark = MAX(SightingRecordId) FROM cle.SightingsSlice

UPDATE WCG_DW.dbo.DimDeltaLog 
SET 
	RowCountStage = @RowCountStage, 
	HighWaterMark = @HighWaterMark
WHERE DeltaLogKey = @DeltaLogKey
;

;