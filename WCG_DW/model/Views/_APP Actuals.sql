

CREATE VIEW [model].[_APP Actuals] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   18 Aug 2018 8:17:13 AM
-- Reason               :   Semantic View for dbo.FactAPPActuals
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ActualDateKey] AS [ActualDateKey]
	,[APPTargetKey] AS [APPTargetKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[Comments] AS [Comments]
	,[UniqueGUID] AS [Unique GUID]
	,[PreliminaryActual] AS [_PreliminaryActual]
	,[VerifiedActual] AS [_VerifiedActual]
FROM WCG_DW.dbo.FactAPPActuals WITH (NOLOCK)

