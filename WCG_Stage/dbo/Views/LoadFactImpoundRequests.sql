


CREATE VIEW [dbo].[LoadFactImpoundRequests] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	08-02-2019
-- Reason				:	Load view for FactImpoundRequests
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.[DriverKey],-1)				AS DriverKey
	,ISNULL(d2.[ImpoundInstructionKey],-1)	AS ImpoundInstructionKey
	,ISNULL(d3.DateKey,-1)					AS OperationsDateKey
	,ISNULL(d4.PoundFacilityKey,-1)			AS PoundFacilityKey
	,ISNULL(d5.TrafficCentreKey,-1)			AS TrafficCentreKey
	,ISNULL(d6.TrafficControlEventKey,-1)	AS TrafficControlEventKey
	,ISNULL(d7.DateKey,-1)					AS UpdateDateKey
	,ISNULL(d8.UserKey,-1)					AS UserKey
	,ISNULL(d9.VehicleKey,-1)				AS VehicleKey
	,tfm.ImpoundOverrideReason				AS ImpoundOverrideReason
	,tfm.ImpoundRequestStatus				AS ImpoundRequestStatus
	,tfm.IsImpoundOverridden				AS IsImpoundOverridden
	,tfm.UniqueID							AS UniqueID
	,tfm.[DeltaLogKey]						AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactImpoundRequests] tfm WITH (NOLOCK)
LEFT JOIN [WCG_DW].[dbo].[DimDriver] d1 WITH (NOLOCK) ON tfm.IDNo = d1.IDDocumentNo
LEFT JOIN [WCG_DW].[dbo].[DimImpoundInstruction] d2 WITH (NOLOCK) ON tfm.ImpoundInstructionID = d2.ImpoundInstructionID
LEFT JOIN [WCG_DW].[dbo].[DimDate] d3 WITH (NOLOCK) ON tfm.OperationsDate = d3.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimPoundFacility] d4 WITH (NOLOCK) ON tfm.PoundFacilityID = d4.PoundFacilityID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre] d5 WITH (NOLOCK) ON tfm.TrafficCentreID = d5.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficControlEvent] d6 WITH (NOLOCK) ON tfm.TrafficControlEventID = d6.TrafficControlEventGUID
LEFT JOIN [WCG_DW].[dbo].[DimDate] d7 WITH (NOLOCK) ON tfm.UpdateDate = d7.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimUser] d8 WITH (NOLOCK) ON tfm.UserID = d8.UserID
LEFT JOIN [WCG_DW].[dbo].[DimVehicle] d9 WITH (NOLOCK) ON tfm.RegistrationNo = d9.RegistrationNo


