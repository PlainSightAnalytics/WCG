
CREATE VIEW [model].[_Operation Assignments] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactOperationAssignments
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [OperationDateKey] AS [OperationDateKey]
	,[OperationKey] AS [OperationKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[UserKey] AS [UserKey]
	,[UniqueID] AS [Unique ID]
FROM WCG_DW.dbo.FactOperationAssignments WITH (NOLOCK)
