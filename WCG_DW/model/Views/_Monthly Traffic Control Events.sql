




CREATE VIEW [model].[_Monthly Traffic Control Events] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   22-10-2019
-- Reason               :   Monthly Traffic Control Events
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
	,f.VehicleTypeKey						AS [VehicleTypeKey]
	,f.VehicleKey							AS [VehicleKey]
FROM WCG_DW.dbo.FactTrafficControlEvents f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimDate d1 WITH (NOLOCK) ON f.OpenDateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimTrafficControlEvent d2 WITH (NOLOCK) ON f.TrafficControlEventKey = d2.TrafficControlEventKey
WHERE d2.StatusCode = 'Completed'
AND d2.EventOpenDateTime IS NOT NULL
)

SELECT 
	 CalendarYearMonthKey					AS [CalendarYearMonthKey]
	,TrafficCentreKey						AS [TrafficCentreKey]
	,EventSource							AS [EventSource]
	,VehicleTypeKey							AS [VehicleTypeKey]
	,COUNT(DISTINCT VehicleKey)				AS [_VehicleCount]
	,COUNT(1)								AS [_EventCount]
FROM CTE
GROUP BY 
	  CalendarYearMonthKey
	 ,TrafficCentreKey
	 ,EventSource
	 ,VehicleTypeKey