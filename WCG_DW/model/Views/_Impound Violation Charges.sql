

CREATE VIEW [model].[_Impound Violation Charges]

AS 

------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   08 Feb 2019 8:59:49 AM
-- Reason               :   Semantic View for dbo.FactImpoundViolationCharges
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	15-07-2019
-- Reason               :	Added new column for Operations Day (OperationsDateKey)
------------------------------------------------------------------------------------------

SELECT 
	 [CreateDateKey] AS [CreateDateKey]
	,[DriverKey] AS [DriverKey]
	,[ImpoundInstructionKey] AS [ImpoundInstructionKey]
	,[ImpoundJourneyUserKey] AS [ImpoundJourneyUserKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[PoundFacilityKey] AS [PoundFacilityKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[VehicleKey] AS [VehicleKey]
	,[ViolationChargeKey] AS [ViolationChargeKey]
	,[UniqueID] AS [Unique ID]
FROM WCG_DW.dbo.FactImpoundViolationCharges WITH (NOLOCK)

