CREATE PROCEDURE [cle].[prcLoadVehicleEnquiryResponsesLatest]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-03-2019
-- Reason				:	Loads last Vehicle Flagging fields from  last 48 Hours Vehicle Enquiry Responses
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@DaysPrevious
-- Ouputs				:	@HighWaterDateTime
-- Test					:	cle.prcLoadVehicleEnquiryResponsesLatest 2,1
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@DaysPrevious INT = 2
,@LastVehicleEnquiryResponsesRecordId INT OUTPUT

AS

DECLARE 
	 @VehicleEnquiryResponseDateTime AS DATETIME = DATEADD(d,0-@DaysPrevious,GETDATE())
	,@RowCount AS INT

SET NOCOUNT ON


/* Check if there is data in VehicleEnquiryResponsesLatest */
SELECT @RowCount = COUNT(1) FROM cle.VehicleEnquiryResponsesLatest
WHERE CAST(Timestamp AS DATETIME) < @VehicleEnquiryResponseDateTime

IF @RowCount > 0 
BEGIN

	/* Get latest VehicleEnquiryResponses Record Id */
	SELECT @LastVehicleEnquiryResponsesRecordId = MAX(VehicleEnquiryResponseRecordId) FROM cle.VehicleEnquiryResponsesLatest

	/* Delete VehicleEnquiryResponses older than @DayPrevious days old  */
	DELETE 
	FROM cle.VehicleEnquiryResponsesLatest
	WHERE CAST(Timestamp AS DATETIME) < @VehicleEnquiryResponseDateTime

	RETURN

END

/* Check if there is data in VehicleEnquiryResponses */
SELECT @RowCount = COUNT(1) FROM cle.VehicleEnquiryResponses
WHERE CAST(Timestamp AS DATETIME) >= @VehicleEnquiryResponseDateTime

IF @RowCount > 0 
BEGIN

	/* Load Stage Table */
	INSERT INTO VehicleEnquiryResponsesLatest(
		 VehicleEnquiryResponseRecordId
		,Timestamp
		,LicenceNumber
		,VehicleUsageCode
		,CategoryCode
	)
	SELECT
		VehicleEnquiryResponseRecordId
		,Timestamp
		,LicenceNumber
		,VehicleUsageCode
		,CategoryCode
	FROM cle.VehicleEnquiryResponses
	WHERE timestamp > @VehicleEnquiryResponseDateTime

	/* Return Latest VehicleEnquiryResponsesDate */
	SELECT @LastVehicleEnquiryResponsesRecordId = MAX(VehicleEnquiryResponseRecordId) FROM cle.VehicleEnquiryResponsesLatest

END

ELSE

	/* Return Latest VehicleEnquiryResponsesDate */
	SELECT @LastVehicleEnquiryResponsesRecordId = MAX(VehicleEnquiryResponseRecordId) FROM cle.VehicleEnquiryResponses









;
;