




CREATE PROCEDURE [dbo].[prcUpdateDimDeltaLogVehicleEnquiryResponses]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-08-2016
-- Reason				:	Updates record on DimDeltaLog for VehicleEnquiryResponses
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@DeltaLogKey, @AuditKey
-- Ouputs				:
-- Test					:	exec dbo.prcUpdateDimDeltaLogVehicleEnquiryResponses 3016, 4051
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
UPDATE cle.VehicleEnquiryResponses 
SET DeltaLogKey = @DeltaLogKey
WHERE DeltaLogKey IS NULL
OR DeltalogKey = 0

SELECT @RowCountStage = @@ROWCOUNT

SELECT @HighWaterMark = MAX(VehicleEnquiryResponseRecordId) FROM cle.VehicleEnquiryResponses

UPDATE WCG_DW.dbo.DimDeltaLog 
SET 
	RowCountStage = @RowCountStage, 
	HighWaterMark = @HighWaterMark
WHERE DeltaLogKey = @DeltaLogKey
;

;





