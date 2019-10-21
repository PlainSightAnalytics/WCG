


CREATE VIEW [model].[_Operation Traffic Control Events] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   28-06-2019
-- Reason               :   Semantic View for Operation TCE's and Section 56's
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	20-07-2019
-- Reason               :	Added OperationsDateKey from FactTrafficControlEvents
------------------------------------------------------------------------------------------

WITH OperationTCE AS (
	SELECT
		 f.TrafficControlEventKey
		,f.UserKey
		,CAST(d1.FullDate AS DATETIME) + CAST(d2.FullTime AS DATETIME) AS TCEDateTime
		,f.OperationsDateKey
		,f.OpenTimeKey
		,f2.ChargeAmount
		,f2.Section56FormKey
		,f2.UniqueChargeID
		,f2.ViolationChargeKey
	FROM WCG_DW.dbo.FactTrafficControlEvents f
	LEFT JOIN WCG_DW.dbo.DimDate d1 ON f.OpenDateKey = d1.DateKey
	LEFT JOIN WCG_DW.dbo.DimTime d2 ON f.OpenTimeKey = d2.TimeKey
	LEFT JOIN WCG_DW.dbo.FactTrafficControlEventOutcomes f2 ON f2.TrafficControlEventKey = f.TrafficControlEventKey
)

SELECT 
	 f.OperationDateKey							AS [OperationDateKey]
	,f.OperationKey								AS [OperationKey]
	,tce.OperationsDateKey						AS [OperationsDateKey]
	,tce.OpenTimeKey							AS [OpenTimeKey]
	,f.TrafficCentreKey							AS [TrafficCentreKey]
	,ISNULL(tce.TrafficControlEventKey,-1)		AS [TrafficControlEventKey]
	,ISNULL(tce.Section56FormKey,-1)			AS [Section56FormKey]
	,f.UserKey									AS [UserKey]
	,ISNULL(tce.ViolationChargeKey,-1)			AS [ViolationChargeKey]
	,tce.TCEDateTime							AS [EventDateTime]
	,tce.ChargeAmount							AS [ChargeAmount]
FROM WCG_DW.dbo.FactOperationAssignments f
LEFT JOIN WCG_DW.dbo.DimOperation d1 ON f.OperationKey = d1.OperationKey
LEFT JOIN WCG_DW.dbo.DimUser d2 ON f.UserKey = d2.UserKey
LEFT JOIN OperationTCE tce ON f.UserKey = tce.UserKey AND tce.TCEDateTime BETWEEN d1.ActualStartTime AND d1.ActualStopTime





