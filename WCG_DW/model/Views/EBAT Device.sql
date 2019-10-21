
CREATE VIEW [model].[EBAT Device] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:42 PM
-- Reason               :   Semantic View for dbo.DimEBATDevice
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [EBATDeviceKey] AS [EBATDeviceKey]
	,[CalibrationCertificate] AS [Calibration Certificate]
	,[CertificateDateOfIssue] AS [Certificate Date Of Issue]
	,[CertificateNumber] AS [Certificate Number]
	,[CreatedBy] AS [Created By]
	,[CreatedDate] AS [Created Date]
	,[DateOfNextCalibration] AS [Date Of Next Calibration]
	,[DeviceMake] AS [Device Make]
	,[DeviceManufacturer] AS [Device Manufacturer]
	,[DeviceModel] AS [Device Model]
	,[DeviceStatus] AS [Device Status]
	,[EBATDevice] AS [EBAT Device]
	,[EBATDeviceID] AS [EBAT Device ID]
	,[SerialNumber] AS [Serial Number]
FROM WCG_DW.dbo.DimEBATDevice WITH (NOLOCK)
