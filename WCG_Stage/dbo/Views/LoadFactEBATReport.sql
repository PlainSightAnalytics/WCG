







CREATE VIEW [dbo].[LoadFactEBATReport] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	15-08-2016
-- Reason				:	Load View for FactEBATReport
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-06-2018
-- Reason				:	Dropped Degens and Replaced with foreign key to EBATIncident
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	02-09-2018
-- Reason				:	Added DriverKey and VehicleKey
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.DriverKey,-1)			AS DriverKey
    ,ISNULL(d2.EBATDeviceKey,-1)		AS EBATDeviceKey
	,ISNULL(d3.EBATIncidentKey,-1)		AS EBATIncidentKey
    ,ISNULL(d4.MagistratesCourtKey,-1)	AS MagistratesCourtKey
    ,ISNULL(d5.OfficerKey,-1)			AS OfficerKey
	,ISNULL(d6.DateKey,-1)				AS OperationsDateKey
	,ISNULL(d7.OperatorKey,-1)			AS OperatorKey
	,ISNULL(d8.TimeKey,-1)				AS ReportTimeKey
	,ISNULL(d9.DateKey,-1)				AS ReportDateKey
	,ISNULL(d10.VehicleKey,-1)			AS VehicleKey
	,tfm.EBATReportId					AS UniqueID
	,tfm.NumberOfVehicles				AS NumberOfVehicles			
	,tfm.ReadingResult					AS ReadingResult				
	,tfm.RowNumber						AS RowNumber
	,tfm.DeltaLogKey					AS DeltaLogKey			
  FROM WCG_Stage.ebat.transformFactEBATReport AS tfm WITH (NOLOCK)
  LEFT JOIN WCG_DW.dbo.DimDriver			d1	WITH (NOLOCK) ON tfm.IDDocumentNo = d1.IDDocumentNo
  LEFT JOIN WCG_DW.dbo.DimEBATDevice		d2	WITH (NOLOCK) ON tfm.EBATDeviceID = d2.EBATDeviceID
  LEFT JOIN WCG_DW.dbo.DimEBATIncident		d3	WITH (NOLOCK) ON tfm.EBATReportId = d3.EBATReportId
  LEFT JOIN WCG_DW.dbo.DimMagistratesCourt	d4	WITH (NOLOCK) ON tfm.MagistratesCourtID = d4.MagistratesCourtID
  LEFT JOIN WCG_DW.dbo.DimOfficer			d5	WITH (NOLOCK) ON tfm.OfficerID= d5.OfficerId
  LEFT JOIN WCG_DW.dbo.DimDate				d6	WITH (NOLOCK) ON tfm.OperationsDate = d6.FullDate
  LEFT JOIN WCG_DW.dbo.DimOperator			d7	WITH (NOLOCK) ON tfm.OperatorID = d7.OperatorID
  LEFT JOIN WCG_DW.dbo.DimTime				d8	WITH (NOLOCK) ON tfm.Hour = d8.FullTime
  LEFT JOIN WCG_DW.dbo.DimDate				d9	WITH (NOLOCK) ON tfm.Date = d9.FullDate
  LEFT JOIN WCG_DW.dbo.DimVehicle			d10 WITH (NOLOCK) ON tfm.RegistrationNo = d10.RegistrationNo

















