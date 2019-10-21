


CREATE VIEW [dbo].[LoadFactAPPActuals] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Load view for FactAPPActuals
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	18-08-2018
-- Reason				:	Added Comments
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.[APPTargetKey],-1)			AS APPTargetKey
	,ISNULL(d2.[DateKey],-1)				AS ActualDateKey
	,ISNULL(d3.[TrafficCentreKey],-1)		AS TrafficCentreKey
	,tfm.Comments							AS Comments
	,tfm.UniqueGUID							AS UniqueGUID
	,tfm.PreliminaryActual					AS PreliminaryActual
	,tfm.VerifiedActual						AS VerifiedActual
	,tfm.[DeltaLogKey]						AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactAPPActuals] tfm
LEFT JOIN [WCG_DW].[dbo].[DimAPPTarget]			d1 ON tfm.APPTargetGUID = d1.APPTargetGUID
LEFT JOIN [WCG_DW].[dbo].[DimDate]				d2 ON tfm.ActualDate = d2.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]		d3 ON tfm.TrafficCentreGUID = d3.TrafficCentreID














