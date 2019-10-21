
CREATE VIEW [model].[_Shift Outcomes] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactShiftOutcomes
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [CriticalOutcomeTypeKey] AS [CriticalOutcomeTypeKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[ShiftDateKey] AS [ShiftDateKey]
	,[ShiftKey] AS [ShiftKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[UserKey] AS [UserKey]
	,[IsStartedFillingIn] AS [Is Started Filling In]
	,[UniqueID] AS [Unique ID]
	,[VehicleCount] AS [_VehicleCount]
FROM WCG_DW.dbo.FactShiftOutcomes WITH (NOLOCK)
