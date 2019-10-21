

CREATE VIEW [model].[_Impound Events] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   08 Feb 2019 8:59:49 AM
-- Reason               :   Semantic View for dbo.FactImpoundEvents
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	15-07-2019
-- Reason               :	Added new column for Operations Day (OperationsDateKey)
------------------------------------------------------------------------------------------

SELECT 
	 [DriverKey] AS [DriverKey]
	,[ImpoundEventDateKey] AS [ImpoundEventDateKey]
	,[ImpoundEventTimeKey] AS [ImpoundEventTimeKey]
	,[ImpoundInstructionKey] AS [ImpoundInstructionKey]
	,[ImpoundJourneyUserKey] AS [ImpoundJourneyUserKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[PoundFacilityKey] AS [PoundFacilityKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[VehicleKey] AS [VehicleKey]
	,[ImpoundEvent] AS [Impound Event]
	,[ImpoundEventDateTime] AS [Impound Event Date Time]
	,[UniqueID] AS [Unique ID]
FROM WCG_DW.dbo.FactImpoundEvents WITH (NOLOCK)

