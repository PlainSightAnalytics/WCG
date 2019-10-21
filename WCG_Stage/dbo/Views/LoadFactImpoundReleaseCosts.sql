

CREATE VIEW [dbo].[LoadFactImpoundReleaseCosts] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-02-2019
-- Reason				:	Load view for FactImpoundReleaseCosts
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.[DateKey],-1)				AS CreateDateKey
	,ISNULL(d2.[DriverKey],-1)				AS DriverKey
	,ISNULL(d3.[ImpoundInstructionKey],-1)	AS ImpoundInstructionKey
	,ISNULL(d4.JourneyUserKey,-1)			AS ImpoundJourneyUserKey
	,ISNULL(d5.DateKey,-1)					AS OperationsDateKey
	,ISNULL(d6.PoundFacilityKey,-1)			AS PoundFacilityKey
	,ISNULL(d7.TrafficCentreKey,-1)			AS TrafficCentreKey
	,ISNULL(d8.VehicleKey,-1)				AS VehicleKey
	,tfm.AmountPaid							AS AmountPaid	
	,tfm.ReleaseDescription					AS ReleaseDescription
	,tfm.ReleaseStatus						AS ReleaseStatus
	,tfm.UniqueID							AS UniqueID
	,tfm.[DeltaLogKey]						AS DeltaLogKey
FROM [WCG_Stage].[pnd].[transformFactImpoundReleaseCosts] tfm WITH (NOLOCK)
LEFT JOIN [WCG_DW].[dbo].[DimDate] d1 WITH (NOLOCK) ON tfm.CreateDate = d1.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimDriver] d2 WITH (NOLOCK) ON tfm.IDDocumentNumber = d2.IDDocumentNo
LEFT JOIN [WCG_DW].[dbo].[DimImpoundInstruction] d3 WITH (NOLOCK) ON tfm.ImpoundInstructionID = d3.ImpoundInstructionID
LEFT JOIN [WCG_DW].[dbo].[DimJourneyUser] d4 WITH (NOLOCK) ON tfm.ImpoundJourneyUserID = d4.JourneyUserID
LEFT JOIN [WCG_DW].[dbo].[DimDate] d5 WITH (NOLOCK) ON tfm.OperationsDate = d5.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimPoundFacility] d6 WITH (NOLOCK) ON tfm.PoundFacilityID = d6.PoundFacilityID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre] d7 WITH (NOLOCK) ON tfm.TrafficCentreID = d7.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimVehicle] d8 WITH (NOLOCK) ON tfm.RegistrationNo = d8.RegistrationNo



