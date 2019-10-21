CREATE VIEW [dbo].[LoadFactAPPTargets] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Load view for FactAPPTargets
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.[APPTargetKey],-1)			AS APPTargetKey
	,ISNULL(d2.[DateKey],-1)				AS TargetDateKey
	,ISNULL(d3.[TrafficCentreKey],-1)		AS TrafficCentreKey
	,tfm.UniqueGUID							AS UniqueGUID
	,tfm.AdjustedTarget						AS AdjustedTarget
	,tfm.Target								AS Target
	,tfm.[DeltaLogKey]						AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactAPPTargets] tfm
LEFT JOIN [WCG_DW].[dbo].[DimAPPTarget]			d1 ON tfm.APPTargetGUID = d1.APPTargetGUID
LEFT JOIN [WCG_DW].[dbo].[DimDate]				d2 ON tfm.TargetDate = d2.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]		d3 ON tfm.TrafficCentreGUID = d3.TrafficCentreID













