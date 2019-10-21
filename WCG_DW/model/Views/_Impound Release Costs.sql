


CREATE VIEW [model].[_Impound Release Costs] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   08 Feb 2019 8:59:49 AM
-- Reason               :   Semantic View for dbo.FactImpoundReleaseCosts
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
	,[ReleaseDescription] AS [Release Description]
	,[ReleaseStatus] AS [Release Status]
	,[UniqueID] AS [Unique ID]
	,[AmountPaid] AS [_AmountPaid]
FROM WCG_DW.dbo.FactImpoundReleaseCosts WITH (NOLOCK)

