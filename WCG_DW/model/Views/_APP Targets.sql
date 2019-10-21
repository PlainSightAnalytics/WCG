
CREATE VIEW [model].[_APP Targets] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   26 May 2018 3:45:41 PM
-- Reason               :   Semantic View for dbo.FactAPPTargets
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [APPTargetKey] AS [APPTargetKey]
	,[TargetDateKey] AS [TargetDateKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[UniqueGUID] AS [Unique GUID]
	,[AdjustedTarget] AS [_AdjustedTarget]
	,[Target] AS [_Target]
FROM WCG_DW.dbo.FactAPPTargets WITH (NOLOCK)
