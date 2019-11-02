



CREATE VIEW [model].[_Monthly Speed Profiles] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   22-10-2019
-- Reason               :   Monthly Sightings
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.CalendarYearMonthKey,-1)		AS [CalendarYearMonthKey]
	,ISNULL([CameraKey],-1)					AS [CameraKey]
	,ISNULL(SpeedProfileBucketKey,-1)		AS [SpeedProfileBucketKey]
	,ISNULL(VehicleTypeKey,-1)				AS [VehicleTypeKey]
	,SUM(VehicleCount)						AS [_VehicleCount]
FROM WCG_DW.dbo.FactSpeedProfiles f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimDate d1 WITH (NOLOCK) ON f.SightingDateKey = d1.DateKey
GROUP BY 
	 d1.CalendarYearMonthKey
	,[CameraKey]
	,SpeedProfileBucketKey
	,VehicleTypeKey