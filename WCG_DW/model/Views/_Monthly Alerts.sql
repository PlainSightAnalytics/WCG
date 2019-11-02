








CREATE VIEW [model].[_Monthly Alerts] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   22-10-2019
-- Reason               :   Monthly Sightings
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

/* Remove duplicates */
WITH Alerts AS (
SELECT 
	 f.UpdatedDateKey
	,d1.CalendarYearMonthKey
	,f.CameraKey
	,f.VehicleKey
	,d3.VehicleTypeKey
	,f.AlertTypeKey
	--,d4.SpeedProfileBucketKey
	,f.AlertRecordID
	,f.AverageSpeed
	,ROW_NUMBER() OVER (
					PARTITION BY f.UpdatedDateKey, f.UpdatedTimeKey, f.VehicleKey, f.CameraKey, f.AlertTypeKey
					ORDER BY f.AlertRecordId) AS RowSequence
FROM WCG_DW.dbo.FactAlerts f
LEFT JOIN WCG_DW.dbo.DimDate d1 ON f.UpdatedDateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimVehicle d2 ON f.VehicleKey = d2.VehicleKey
LEFT JOIN WCG_DW.dbo.DimVehicleType d3 ON d2.VehicleCategoryCode = d3.VehicleCategoryCode and d2.VehicleUsageCode = d3.VehicleUsageCode
--LEFT JOIN WCG_DW.dbo.DimSpeedProfileBucket d4 WITH (NOLOCK) ON f.AverageSpeed BETWEEN d4.FromSpeed AND d4.ToSpeed

)

/* Group and Aggregate by Day */
,AlertsPerDay AS (
SELECT 
	 UpdatedDateKey
	,CalendarYearMonthKey
	,CameraKey
	,VehicleTypeKey
	,AlertTypeKey
	--,SpeedProfileBucketKey
	,COUNT(1)						AS [_AlertCount]
	,COUNT(DISTINCT VehicleKey)		AS [_VehicleCount]
	,GROUPING(CameraKey)			AS [AllCameras]
	,GROUPING(VehicleTypeKey)		AS [AllVehicleTypes]
	,GROUPING(AlertTypeKey)			AS [AllAlertTypes]
FROM Alerts 
WHERE RowSequence = 1
GROUP BY 
	 UpdatedDateKey
	,CalendarYearMonthKey 
	,ROLLUP(CameraKey)
	,ROLLUP(VehicleTypeKey)
	,ROLLUP(AlertTypeKey)
	--,ROLLUP(SpeedProfileBucketKey
)

/* Rollup to Month */
SELECT
	 ISNULL(CameraKey,-1)				AS [CameraKey]
	,ISNULL(VehicleTypeKey,-1)			AS [VehicleTypeKey]
	,ISNULL(CalendarYearMonthKey,-1)	AS [CalendarYearMonthKey]	
	,ISNULL(AlertTypeKey,-1)			AS [AlertTypeKey]
	,AllCameras							AS [AllCameras]
	,AllVehicleTypes					AS [AllVehicleTypes]
	,AllAlertTypes						AS [AllAlertTypes]
	,SUM([_AlertCount])					AS [_AlertCount]
	,SUM([_VehicleCount])				AS [_VehicleCount]
FROM AlertsPerDay s
GROUP BY 
	 CameraKey
	,VehicleTypeKey
	,AlertTypeKey
	,CalendarYearMonthKey
	,AllCameras
	,AllVehicleTypes
	,AllAlertTypes