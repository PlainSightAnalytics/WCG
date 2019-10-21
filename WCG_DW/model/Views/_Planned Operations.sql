
CREATE VIEW [model].[_Planned Operations] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactPlannedOperations
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [OperationalOfficerUserKey] AS [OperationalOfficerUserKey]
	,[OperationKey] AS [OperationKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[PlannedDateKey] AS [PlannedDateKey]
	,[PlannerUserKey] AS [PlannerUserKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[UniqueID] AS [Unique ID]
FROM WCG_DW.dbo.FactPlannedOperations WITH (NOLOCK)
