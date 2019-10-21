


CREATE VIEW [model].[_Public Transport Alerts] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   20-04-2019
-- Reason               :   Alerts filtered for Public Transport Only
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	24-07-2019
-- Reason               :	Add OperationsDateKey
------------------------------------------------------------------------------------------

WITH CTE AS (

SELECT 
	 f.AlertTypeKey													AS [AlertTypeKey]
	,f.[CameraKey]													AS [CameraKey]
	,f.[GeoLocationKey]												AS [GeoLocationKey]
	,f.[OperationsDateKey]											AS [OperationsDateKey]
	,f.[UpdatedDateKey]												AS [UpdatedDateKey]
	,f.[UpdatedTimeKey]												AS [UpdatedTimeKey]
	,f.[TrafficCentreKey]											AS [TrafficCentreKey]
	,f.[VehicleKey]													AS [VehicleKey]
	,f.[AlertRecordID]												AS [AlertRecordID]
	,CAST(d2.FullDate AS DATETIME) + CAST(d3.FullTime AS DATETIME)	AS AlertDateTime
	,d1.RegistrationNo												AS RegistrationNo
FROM WCG_DW.dbo.FactAlerts f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimVehicle d1 WITH (NOLOCK) ON f.VehicleKey = d1.VehicleKey
LEFT JOIN WCG_DW.dbo.DimDate d2 WITH (NOLOCK) ON f.UpdatedDateKey = d2.DateKey
LEFT JOIN WCG_DW.dbo.DimTime d3 WITH (NOLOCK) ON f.UpdatedTimeKey = d3.TimeKey
WHERE
	f.UpdatedDateKey > 20181130
AND (
	d1.VehicleCategoryCode = 'C'
OR	d1.VehicleUsageCode = '02')

)

SELECT
	 [AlertTypeKey]			AS [AlertTypeKey]
	,[CameraKey]			AS [CameraKey]
	,[GeoLocationKey]		AS [GeoLocationKey]
	,[OperationsDateKey]	AS [OperationsDateKey]
	,[UpdatedDateKey]		AS [UpdatedDateKey]
	,[UpdatedTimeKey]		AS [UpdatedTimeKey]
	,[TrafficCentreKey]		AS [TrafficCentreKey]
	,ISNULL(d4.TripKey,-1)	AS [TripKey]
	,[VehicleKey]			AS [VehicleKey]
FROM CTE
LEFT JOIN WCG_DW.dbo.DimTrip d4 WITH (NOLOCK) ON cte.RegistrationNo = d4.RegistrationNo AND cte.AlertDateTime BETWEEN d4.StartTime AND d4.EndTime



