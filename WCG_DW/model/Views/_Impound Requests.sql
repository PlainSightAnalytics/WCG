

CREATE VIEW [model].[_Impound Requests] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   08 Feb 2019 12:07:53 PM
-- Reason               :   Semantic View for dbo.FactImpoundRequests
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	15-07-2019
-- Reason               :	Added new column for Operations Day (OperationsDateKey)
------------------------------------------------------------------------------------------

SELECT 
	 [DriverKey] AS [DriverKey]
	,[ImpoundInstructionKey] AS [ImpoundInstructionKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[PoundFacilityKey] AS [PoundFacilityKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[TrafficControlEventKey] AS [TrafficControlEventKey]
	,[UpdateDateKey] AS [UpdateDateKey]
	,[UserKey] AS [UserKey]
	,[VehicleKey] AS [VehicleKey]
	,[ImpoundOverrideReason] AS [Impound Override Reason]
	,[ImpoundRequestStatus] AS [Impound Request Status]
	,[IsImpoundOverridden] AS [Is Impound Overridden]
	,[UniqueID] AS [Unique I D]
FROM WCG_DW.dbo.FactImpoundRequests WITH (NOLOCK)

