











CREATE VIEW [model].[_Freight Tracking] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   29 Sep 2018 4:51:16 PM
-- Reason               :   Semantic View for dbo.FactFreightTracking
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	23-08-2019
-- Reason               :	Added OperationsDateKey
------------------------------------------------------------------------------------------


WITH CTE AS (
SELECT 
     f.CameraKey
	,f.DateKey
	,f.GeoLocationKey
	,f.OperationsDateKey
	,f.TimeKey
	,f.TrafficCentreKey
	,f.TripKey
	,f.VehicleKey
	,f.Event
	,CAST(d1.FullDate AS DATETIME) + CAST(d2.FullTime AS DATETIME) AS EventDateTime
	,d3.Route
	,d3.DistanceFromPreviousCamera
FROM WCG_DW.dbo.FactFreightTracking f WITH (NOLOCK) 
LEFT JOIN WCG_DW.dbo.DimDate d1 WITH (NOLOCK) ON f.DateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimTime d2 WITH (NOLOCK) ON f.TimeKey = d2.TimeKey
LEFT JOIN WCG_DW.dbo.DimCamera d3 WITH (NOLOCK) ON f.CameraKey = d3.CameraKey 
)

SELECT 
	 CameraKey
	,DateKey
	,GeoLocationKey
	,OperationsDateKey
	,TimeKey
	,TrafficCentreKey
	,TripKey
	,VehicleKey
	,Event
	,DATEDIFF(SECOND,
				CASE
					WHEN Route = LAG(Route) OVER(PARTITION BY VehicleKey ORDER BY EventDateTime)
						THEN LAG(EventDateTime) OVER(PARTITION BY VehicleKey ORDER BY EventDateTime)
					ELSE NULL
				END,
				EventDateTime
	)  AS DurationSeconds
	,CASE
		WHEN Event <> 'Sighting' THEN NULL
		ELSE DistanceFromPreviousCamera
	END AS Distance
FROM CTE
