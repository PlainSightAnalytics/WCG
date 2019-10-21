

CREATE VIEW [model].[_EBAT Report] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   02 Sep 2018 11:40:51 AM
-- Reason               :   Semantic View for dbo.FactEBATReport
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	15-07-2019
-- Reason               :	Added new column for Operations Day (OperationsDateKey)
------------------------------------------------------------------------------------------

SELECT 
	 [DriverKey] AS [DriverKey]
	,[EBATDeviceKey] AS [EBATDeviceKey]
	,[EBATIncidentKey] AS [EBATIncidentKey]
	,[MagistratesCourtKey] AS [MagistratesCourtKey]
	,[OfficerKey] AS [OfficerKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[OperatorKey] AS [OperatorKey]
	,[ReportDateKey] AS [ReportDateKey]
	,[ReportTimeKey] AS [ReportTimeKey]
	,[VehicleKey] AS [VehicleKey]
	,[UniqueId] AS [Unique Id]
	,[NumberOfVehicles] AS [_NumberOfVehicles]
	,[ReadingResult] AS [_ReadingResult]
FROM WCG_DW.dbo.FactEBATReport WITH (NOLOCK)

