






CREATE VIEW [ebat].[transformDimEBATDevice] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	12-08-2106
-- Reason				:	Transform view for DimEBATDevice
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	10-07-2019
-- Reason				:	Converted CreatedDate to GMT+2 (SA Time)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 [id]																AS [EBATDeviceID]
    ,CAST([display] AS VARCHAR(50))										AS [EBATDevice]
    ,CAST(ISNULL([calibration_certificate],'Unknown') AS VARCHAR(50))	AS [CalibrationCertificate]
    ,CAST([certificate_date_of_issue] AS DATE)							AS [CertificateDateOfIssue]
    ,CAST(ISNULL([certificate_number],'Unknown') AS VARCHAR(50))		AS [CertificateNumber]
	,CAST(
		CAST([created_at] AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATE)														AS [CreatedDate]
    ,CAST(ISNULL([created_by],'Unknown') AS VARCHAR(50))				AS [CreatedBy]
    ,CAST([date_of_next_calibration] AS DATE)							AS [DateOfNextCalibration]
    ,CAST([make] AS VARCHAR(50))										AS [DeviceMake]
    ,CAST([manufacturer] AS VARCHAR(50))								AS [DeviceManufacturer]
    ,CAST([model] AS VARCHAR(50))										AS [DeviceModel]
    ,CAST([serial] AS VARCHAR(50))										AS [SerialNumber]
    ,CAST([status_display] AS VARCHAR(50))								AS [DeviceStatus]
FROM [WCG_Stage].[ebat].[ebat_device]











