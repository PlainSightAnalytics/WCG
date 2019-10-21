CREATE PROCEDURE [cle].[prcLoadSightingsLatest]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-03-2019
-- Reason				:	Loads last Vehicle Flagging fields from  last 48 Hours Sightings
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@DaysPrevious
-- Ouputs				:	@HighWaterDateTime
-- Test					:	cle.prcLoadSightingsLatest 2,1
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@DaysPrevious INT = 2
,@LastSightingRecordId INT OUTPUT

AS

DECLARE 
	@SightingDateTime AS DATETIME = DATEADD(d,0-@DaysPrevious,GETDATE())
	,@RowCount AS INT

SET NOCOUNT ON

/* Check if there is data in SightingsLatest */
SELECT @RowCount = COUNT(1) FROM cle.SightingsLatest
WHERE CAST(Timestamp AS DATETIME) < @SightingDateTime

IF @RowCount > 0 
BEGIN

	/* Get latest Sighting Record Id */
	SELECT @LastSightingRecordId = MAX(SightingRecordID) FROM cle.SightingsLatest

	/* Delete Sioghtings older than @DayPrevious days old  */
	DELETE 
	FROM cle.SightingsLatest
	WHERE CAST(Timestamp AS DATETIME) < @SightingDateTime

	RETURN

END

/* Check if there is data in Sightings */
SELECT @RowCount = COUNT(1) FROM cle.Sightings
WHERE CAST(Timestamp AS DATETIME) >= @SightingDateTime

IF @RowCount > 0 
BEGIN

	/* Load Stage Table */
	INSERT INTO cle.SightingsLatest (
		SightingRecordId
		,ProviderId
		,CameraId
		,Timestamp
		,LaneID
		,XCoord
		,YCoord
		,VRN
	)
	SELECT
		SightingRecordId
		,ProviderId
		,CameraId
		,Timestamp
		,LaneID
		,XCoord
		,YCoord
		,VRN
	FROM cle.Sightings
	WHERE CAST(Timestamp AS DATETIME) >= @SightingDateTime

	/* Return Latest SightingDate */
	SELECT @LastSightingRecordId = MAX(SightingRecordID) FROM cle.SightingsLatest

END

ELSE

	/* Return Latest SightingDate */
	SELECT @LastSightingRecordId = MAX(SightingRecordID) FROM cle.Sightings












;
;
