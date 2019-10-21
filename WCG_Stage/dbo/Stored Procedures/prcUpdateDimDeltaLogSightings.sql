
CREATE PROCEDURE [dbo].[prcUpdateDimDeltaLogSightings]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-08-2016
-- Reason				:	Updates record on DimDeltaLog for Sightings
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@DeltaLogKey, @AuditKey
-- Ouputs				:
-- Test					:	exec dbo.prcUpdateDimDeltaLogSightings 3016, 4051
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
UPDATE cle.Sightings 
SET DeltaLogKey = @DeltaLogKey
WHERE DeltaLogKey IS NULL
OR DeltalogKey = 0

SELECT @RowCountStage = @@ROWCOUNT

SELECT @HighWaterMark = MAX(SightingRecordId) FROM cle.Sightings

UPDATE WCG_DW.dbo.DimDeltaLog 
SET 
	RowCountStage = @RowCountStage, 
	HighWaterMark = @HighWaterMark
WHERE DeltaLogKey = @DeltaLogKey
;

;



