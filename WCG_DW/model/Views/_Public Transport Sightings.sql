



CREATE VIEW [model].[_Public Transport Sightings] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   20-04-2019
-- Reason               :   Sightings filtered for Public Transport Only
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	24-07-2019
-- Reason               :	Add OperationsDateKey
------------------------------------------------------------------------------------------

WITH CTE AS (

SELECT 
	 f.[CameraKey]													AS [CameraKey]
	,f.[GeoLocationKey]												AS [GeoLocationKey]
	,f.[OperationsDateKey]											AS [OperationsDateKey]
	,f.[SightingDateKey]											AS [SightingDateKey]
	,f.[SightingTimeKey]											AS [SightingTimeKey]
	,f.[TrafficCentreKey]											AS [TrafficCentreKey]
	,f.[VehicleKey]													AS [VehicleKey]
	,f.[SightingRecordId]											AS [Sighting Record Id]
	,CAST(d2.FullDate AS DATETIME) + CAST(d3.FullTime AS DATETIME)	AS [SightingDateTime]
	,d1.RegistrationNo												AS [RegistrationNo]
	,ROW_NUMBER() OVER (
		PARTITION BY f.VehicleKey, f.SightingDateKey, f.SightingTimeKey 
		ORDER BY SightingRecordId
	)																AS [RowSequence]
	,d4.Route														AS [Route] 
	,d4.DistanceFromPreviousCamera									AS [DistanceFromPreviousCamera]
FROM WCG_DW.dbo.FactSightings f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimVehicle d1 WITH (NOLOCK) ON f.VehicleKey = d1.VehicleKey
LEFT JOIN WCG_DW.dbo.DimDate d2 WITH (NOLOCK) ON f.SightingDateKey = d2.DateKey
LEFT JOIN WCG_DW.dbo.DimTime d3 WITH (NOLOCK) ON f.SightingTimeKey = d3.TimeKey
LEFT JOIN WCG_DW.dbo.DimCamera d4 WITH (NOLOCK) ON f.CameraKey = d4.CameraKey
WHERE
	f.SightingDateKey > 20181130
AND (
	d1.VehicleCategoryCode = 'C'
OR	d1.VehicleUsageCode = '02')

)

SELECT
	 [CameraKey]					AS [CameraKey]
	,[GeoLocationKey]				AS [GeoLocationKey]
	,[OperationsDateKey]			AS [OperationsDateKey]
	,[SightingDateKey]				AS [SightingDateKey]
	,[SightingTimeKey]				AS [SightingTimeKey]
	,[TrafficCentreKey]				AS [TrafficCentreKey]
	,ISNULL(d4.TripKey,-1)			AS [TripKey]
	,[VehicleKey]					AS [VehicleKey]
	,DATEDIFF(SECOND,
				CASE
					WHEN cte.[Route] = LAG(cte.[Route]) OVER(PARTITION BY VehicleKey ORDER BY SightingDateTime)
						THEN LAG(SightingDateTime) OVER(PARTITION BY VehicleKey ORDER BY SightingDateTime)
					ELSE NULL
				END,
				SightingDateTime
	)  AS DurationSeconds
	,DistanceFromPreviousCamera		AS Distance
FROM CTE
LEFT JOIN WCG_DW.dbo.DimTrip d4 WITH (NOLOCK) ON cte.RegistrationNo = d4.RegistrationNo AND cte.SightingDateTime BETWEEN d4.StartTime AND d4.EndTime
WHERE RowSequence = 1


