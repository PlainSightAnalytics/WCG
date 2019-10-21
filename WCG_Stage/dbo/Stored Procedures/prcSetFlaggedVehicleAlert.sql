
CREATE PROCEDURE [dbo].[prcSetFlaggedVehicleAlert]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-03-2019
-- Reason				:	Upates alert notification fields on FactFlaggedVehicleAlerts and DimFlaggedVehicleTrip
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @RegistrationNo, @SightingRecordId, @FlagType, @TrafficCentreKey
-- Ouputs				:	None
-- Test					:	prcSetFlaggedVehicleAlert -1, 'CF230418-115693047-Fatigue-2'
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT = -1,
@RegistrationNo AS VARCHAR(20),
@SightingRecordId AS INT,
@FlagType AS VARCHAR(30),
@TrafficCentreKey AS INT

AS

/* Update FactFlaggedVehicleAlerts */
UPDATE 
WCG_DW.dbo.FactFlaggedVehicleAlerts
SET 
	IsAlertSent = 'Yes',
	AlertDeliveryDateTime = GETDATE(),
	UpdateAuditKey = @AuditKey
WHERE
	SightingRecordId = @SightingRecordId
AND TrafficCentreKey = @TrafficCentreKey
AND FlagType = @FlagType
AND ISNULL(IsAlertSent,'No') = 'No'

/* Update DimFlaggedVehicleTrip */
UPDATE
WCG_DW.dbo.DimFlaggedVehicleTrip
SET
	IsAlertSent = 'Yes',
	AlertDeliveryDateTime = GETDATE(),
	UpdateAuditKey = @AuditKey
WHERE
	RegistrationNo = @RegistrationNo
AND ISNULL(IsAlertSent,'No') = 'No'	

/* Insert into FlaggedVehicleAlertLog */
INSERT INTO WCG_STAGE.cle.FlaggedVehicleAlertLog
(RegistrationNo, SightingRecordId, FlagType, TrafficCentreKey, AlertDeliveryDateTime, AuditKey)
VALUES (@RegistrationNo, @SightingRecordId, @FlagType, @TrafficCentreKey, GETDATE(), @AuditKey)

