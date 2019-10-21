
CREATE VIEW [model].[Critical Outcome Type] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   28 Oct 2018 1:35:42 PM
-- Reason               :   Semantic View for dbo.DimCriticalOutcomeType
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [CriticalOutcomeTypeKey] AS [CriticalOutcomeTypeKey]
	,[CriticalOutcomeMetric] AS [Critical Outcome Metric]
	,[CriticalOutcomeMetricCode] AS [Critical Outcome Metric Code]
	,[CriticalOutcomeType] AS [Critical Outcome Type]
	,[CriticalOutcomeTypeCode] AS [Critical Outcome Type Code]
	,[IsSystemPopulated] AS [Is System Populated]
	,[VehicleType] AS [Vehicle Type]
FROM WCG_DW.dbo.DimCriticalOutcomeType WITH (NOLOCK)
