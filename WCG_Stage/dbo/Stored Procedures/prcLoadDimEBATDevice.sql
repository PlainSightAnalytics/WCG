CREATE PROCEDURE [dbo].[prcLoadDimEBATDevice]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14 August 2016
-- Reason				:	Performs SCD Logic for DimMagisgtratesCourt using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimEBATDevice] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT

AS

SET FMTONLY OFF
SET NOCOUNT ON

DECLARE
@RowCountInsert INT,
@RowCountUpdate INT,
@RowCountExtract INT

DECLARE @RowCounts TABLE
(mergeAction varchar(10));

WITH conf AS (
SELECT
	 EBATDeviceID
	,EBATDevice
	,CalibrationCertificate
	,CertificateDateOfIssue
	,CertificateNumber
	,CreatedDate
	,CreatedBy
	,DateOfNextCalibration
	,DeviceMake
	,DeviceManufacturer
	,DeviceModel
	,SerialNumber
	,DeviceStatus
FROM WCG_STAGE.ebat.transformDimEBATDevice
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimEBATDevice dim
USING conf
ON (dim.[EBATDeviceID] = conf.[EBATDeviceID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 EBATDeviceID,EBATDevice,CalibrationCertificate,CertificateDateOfIssue,CertificateNumber,CreatedDate,CreatedBy
		 ,DateOfNextCalibration,DeviceMake,DeviceManufacturer,DeviceModel,SerialNumber,DeviceStatus,InsertAuditKey, UpdateAuditKey
			)
	VALUES (
		 EBATDeviceID,EBATDevice,CalibrationCertificate,CertificateDateOfIssue,CertificateNumber,CreatedDate,CreatedBy
		 ,DateOfNextCalibration,DeviceMake,DeviceManufacturer,DeviceModel,SerialNumber,DeviceStatus,@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		dim.[EBATDevice] <> conf.[EBATDevice]
		OR dim.[CalibrationCertificate] <> conf.[CalibrationCertificate]
		OR dim.[CertificateDateOfIssue] <> conf.[CertificateDateOfIssue]
		OR dim.[CertificateNumber] <> conf.[CertificateNumber]
		OR dim.[CreatedDate] <> conf.[CreatedDate]
		OR dim.[CreatedBy] <> conf.[CreatedBy]
		OR dim.[DateOfNextCalibration] <> conf.[DateOfNextCalibration]
		OR dim.[DeviceMake] <> conf.[DeviceMake]
		OR dim.[DeviceManufacturer] <> conf.[DeviceManufacturer]
		OR dim.[DeviceModel] <> conf.[DeviceModel]
		OR dim.[SerialNumber] <> conf.[SerialNumber]
		OR dim.[DeviceStatus] <> conf.[DeviceStatus]
		   
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[EBATDevice] = conf.[EBATDevice],
			dim.[CalibrationCertificate] = conf.[CalibrationCertificate],
			dim.[CertificateDateOfIssue] = conf.[CertificateDateOfIssue],
			dim.[CertificateNumber] = conf.[CertificateNumber],
			dim.[CreatedDate] = conf.[CreatedDate],
			dim.[CreatedBy] = conf.[CreatedBy],
			dim.[DateOfNextCalibration] = conf.[DateOfNextCalibration],
			dim.[DeviceMake] = conf.[DeviceMake],
			dim.[DeviceManufacturer] = conf.[DeviceManufacturer],
			dim.[DeviceModel] = conf.[DeviceModel],
			dim.[SerialNumber] = conf.[SerialNumber],
			dim.[DeviceStatus] = conf.[DeviceStatus],
			
			/* Update System Fields */
			dim.UpdateAuditKey = @AuditKey,
			dim.RowIsInferred = 'N',
			dim.RowChangeReason = 
				CASE 
					WHEN dim.RowIsInferred = 'Y' THEN 'Inferred Member Arrived'
					ELSE 'SCD Type 1 Change'
				END
OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.ebat.transformDimEBATDevice



;
;
;

;
;