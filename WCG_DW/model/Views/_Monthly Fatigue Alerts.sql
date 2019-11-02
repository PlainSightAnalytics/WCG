







CREATE VIEW [model].[_Monthly Fatigue Alerts] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   01-11-2019
-- Reason               :   Monthly Fatigue Alerts
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

/* Remove duplicates */
WITH FatigueAlerts AS (
SELECT 
	 SightingDateKey
	,d1.CalendarYearMonthKey
	,CameraKey
	,f.VehicleKey
	,d3.VehicleTypeKey
	,ROW_NUMBER() OVER (
					PARTITION BY f.SightingDateKey, f.SightingTimeKey, f.VehicleKey, f.CameraKey 
					ORDER BY f.SightingRecordId) AS RowSequence
FROM WCG_DW.dbo.FactFlaggedVehicleAlerts f
LEFT JOIN WCG_DW.dbo.DimDate d1 ON f.SightingDateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimVehicle d2 ON f.VehicleKey = d2.VehicleKey
LEFT JOIN WCG_DW.dbo.DimVehicleType d3 ON d2.VehicleCategoryCode = d3.VehicleCategoryCode and d2.VehicleUsageCode = d3.VehicleUsageCode

)

/* Group and Aggregate by Day */
,FatuqueAlertsByDay AS (
SELECT 
	 SightingDateKey
	,CalendarYearMonthKey
	,CameraKey
	,VehicleTypeKey
	,COUNT(1)						AS [_SightingCount]
	,COUNT(DISTINCT VehicleKey)		AS [_VehicleCount]
	,GROUPING(CameraKey)			AS [AllCameras]
	,GROUPING(VehicleTypeKey)		AS [AllVehicleTypes]
FROM FatigueAlerts 
WHERE RowSequence = 1
GROUP BY 
	 SightingDateKey
	,CalendarYearMonthKey 
	,ROLLUP(CameraKey)
	,ROLLUP(VehicleTypeKey)
)

/* Rollup to Month */
SELECT
	 ISNULL(CameraKey,-1)				AS [CameraKey]
	,ISNULL(VehicleTypeKey,-1)			AS [VehicleTypeKey]
	,ISNULL(CalendarYearMonthKey,-1)	AS [CalendarYearMonthKey]	
	,CAST(AllCameras AS INT)			AS [AllCameras]
	,CAST(AllVehicleTypes AS INT)		AS [AlVehicleTypes]
	,SUM([_SightingCount])				AS [_SightingCount]
	,SUM([_VehicleCount])				AS [_VehicleCount]
FROM FatuqueAlertsByDay s
GROUP BY 
	 CameraKey
	,VehicleTypeKey
	,CalendarYearMonthKey
	,AllCameras
	,AllVehicleTypes