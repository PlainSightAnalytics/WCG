




CREATE VIEW [model].[_Monthly Traffic Control Event Outcomes] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   22-10-2019
-- Reason               :   Monthly Traffic Control Event Outcomes
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

WITH CTE AS (
SELECT 
	 ISNULL(
		NULLIF(d1.CalendarYearMonthKey,0)		
		,FORMAT(d2.EventOpenDateTime,'yyyyMM')
		)									AS [CalendarYearMonthKey]
	,f.TrafficCentreKey						AS [TrafficCentreKey]
	,d2.EventSource							AS [EventSource]
	,f.VehicleKey							AS [VehicleKey]
	,f.ViolationChargeKey					AS [ViolationChargeKey]
	,f.VehicleTypeKey						AS [VehicleTypeKey]
	,f.ChargeAmount							AS [ChargeAmount]
FROM WCG_DW.dbo.FactTrafficControlEventOutcomes f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimDate d1 WITH (NOLOCK) ON f.OpenDateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimTrafficControlEvent d2 WITH (NOLOCK) ON f.TrafficControlEventKey = d2.TrafficControlEventKey
WHERE d2.StatusCode = 'Completed'
AND d2.EventOpenDateTime IS NOT NULL
)

SELECT 
	 CalendarYearMonthKey					AS [CalendarYearMonthKey]
	,TrafficCentreKey						AS [TrafficCentreKey]
	,EventSource							AS [EventSource]
	,ViolationChargeKey						AS [ViolationChargeKey]
	,VehicleTypeKey							AS [VehicleTypeKey]
	,SUM(ChargeAmount)						AS [_ChargeAmount]
	,COUNT(DISTINCT VehicleKey)				AS [_VehicleCount]
	,COUNT(1)								AS [_EventCount]
FROM CTE
GROUP BY 
	  CalendarYearMonthKey
	 ,TrafficCentreKey
	 ,EventSource
	 ,ViolationChargeKey
	 ,VehicleTypeKey