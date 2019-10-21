
CREATE VIEW [dbo].[LoadFactImpoundEvents] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-02-2019
-- Reason				:	Load view for FactImpoundEvents
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.[DriverKey],-1)				AS DriverKey
	,ISNULL(d2.[DateKey],-1)				AS ImpoundEventDateKey
	,ISNULL(d3.[TimeKey],-1)				AS ImpoundEventTimeKey
	,ISNULL(d4.[ImpoundInstructionKey],-1)	AS ImpoundInstructionKey
	,ISNULL(d5.JourneyUserKey,-1)			AS ImpoundJourneyUserKey
	,ISNULL(d6.[DateKey],-1)				AS OperationsDateKey
	,ISNULL(d7.PoundFacilityKey,-1)			AS PoundFacilityKey
	,ISNULL(d8.TrafficCentreKey,-1)			AS TrafficCentreKey
	,ISNULL(d9.VehicleKey,-1)				AS VehicleKey
	,tfm.ImpoundEvent						AS ImpoundEvent	
	,tfm.ImpoundEventDateTime				AS ImpoundEventDateTime
	,tfm.ImpoundInstructionID				AS UniqueID
	,tfm.[DeltaLogKey]						AS DeltaLogKey
FROM [WCG_Stage].[pnd].[transformFactImpoundEvents] tfm WITH (NOLOCK)
LEFT JOIN [WCG_DW].[dbo].[DimDriver] d1 WITH (NOLOCK) ON tfm.IDDocumentNumber = d1.IDDocumentNo
LEFT JOIN [WCG_DW].[dbo].[DimDate] d2 WITH (NOLOCK) ON tfm.ImpoundEventDate = d2.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTime] d3 WITH (NOLOCK) ON tfm.ImpoundEventTime = d3.FullTime
LEFT JOIN [WCG_DW].[dbo].[DimImpoundInstruction] d4 WITH (NOLOCK) ON tfm.ImpoundInstructionID = d4.ImpoundInstructionID
LEFT JOIN [WCG_DW].[dbo].[DimJourneyUser] d5 WITH (NOLOCK) ON tfm.ImpoundUserID = d5.JourneyUserID
LEFT JOIN [WCG_DW].[dbo].[DimDate] d6 WITH (NOLOCK) ON tfm.OperationsDate = d6.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimPoundFacility] d7 WITH (NOLOCK) ON tfm.PoundFacilityID = d7.PoundFacilityID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre] d8 WITH (NOLOCK) ON tfm.TrafficCentreID = d8.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimVehicle] d9 WITH (NOLOCK) ON tfm.RegistrationNo = d9.RegistrationNo






