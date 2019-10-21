
CREATE PROCEDURE [dbo].[prcLoadFactSightingsSummary]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	19-02-2018
-- Reason				:	Load FactSightingsSummary
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	prcLoadFactSightingsSummary -1, 19863
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   Trevor Howe
-- Modified On			:	20-07-2019
-- Reason				:   Added new key for operations date (OperationsDateKey) and changed partitioning to operations date
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT

AS

/* CTE to get the unique Days in the Delta */
WITH Datecte AS (
SELECT
	DISTINCT OperationsDateKey
FROM WCG_DW.dbo.FactSightings
WHERE DeltaLogKey = @DeltaLogKey
)

/* Delete Rows for the same days in Delta */
DELETE f
FROM WCG_DW.dbo.FactSightingsSummary f
INNER JOIN Datecte cte on f.OperationsDateKey = cte.OperationsDateKey

/* CTE (again) to get the unique days in the Delta */
;WITH Datecte AS (
SELECT
	DISTINCT OperationsDateKey
FROM WCG_DW.dbo.FactSightings
WHERE DeltaLogKey = @DeltaLogKey
)

/* Insert Summary Rows from FactSightings */
, Factcte as (
SELECT 
	 f.CameraKey
	,f.GeoLocationKey
	,f.TrafficCentreKey
	,f.OperationsDateKey
	,f.SightingTimeKey
	,f.VehicleKey
	,vt.VehicleTypeKey
	,t.Hour24 + 1 AS Hour24
	,CASE WHEN ROW_NUMBER() OVER (PARTITION BY f.VehicleKey, f.OperationsDateKey ORDER BY f.SightingTimeKey) = 1 THEN 1 ELSE 0 END as VehicleCountDay
	,CASE WHEN ROW_NUMBER() OVER (PARTITION BY f.VehicleKey, f.CameraKey, f.OperationsDateKey ORDER BY f.SightingTimeKey) = 1 THEN 1 ELSE 0 END as VehicleCountDayCamera
	,CASE WHEN ROW_NUMBER() OVER (PARTITION BY f.VehicleKey, tc.RegionalArea, f.OperationsDateKey ORDER BY f.SightingTimeKey) = 1 THEN 1 ELSE 0 END as VehicleCountDayRegion
	,CASE WHEN ROW_NUMBER() OVER (PARTITION BY f.VehicleKey, f.TrafficCentreKey, f.OperationsDateKey ORDER BY f.SightingTimeKey) = 1 THEN 1 ELSE 0 END as VehicleCountDayTrafficCentre
	,CASE WHEN ROW_NUMBER() OVER (PARTITION BY f.VehicleKey, f.TrafficCentreKey, t.Hour24, f.OperationsDateKey ORDER BY f.SightingTimeKey) = 1 THEN 1 ELSE 0 END as VehicleCountDayTrafficCentreHour
	,CASE WHEN ROW_NUMBER() OVER (PARTITION BY f.VehicleKey, f.TrafficCentreKey, f.OperationsDateKey, t.[Shift] ORDER BY f.SightingTimeKey) = 1 THEN 1 ELSE 0 END as VehicleCountDayTrafficCentreShift
FROM WCG_DW.dbo.FactSightings f
INNER JOIN Datecte cte on f.OperationsDateKey = cte.OperationsDateKey
LEFT JOIN WCG_DW.dbo.DimTime t on f.SightingTimeKey = t.TimeKey
LEFT JOIN WCG_DW.dbo.DimTrafficCentre tc ON f.TrafficCentreKey = tc.TrafficCentreKey
LEFT JOIN WCG_DW.dbo.DimVehicle v ON f.VehicleKey = v.VehicleKey
LEFT JOIN WCG_DW.dbo.DimVehicleType vt ON v.VehicleCategoryCode = vt.VehicleCategoryCode AND v.VehicleUsageCode = vt.VehicleUsageCode
)

INSERT INTO WCG_DW.dbo.FactSightingsSummary (
	 CameraKey
	,GeoLocationKey
	,HourKey
	,OperationsDateKey
	,TrafficCentreKey
	,VehicleTypeKey
	,SightingsCount
	,VehicleCountDay
	,VehicleCountDayCamera
	,VehicleCountDayRegion
	,VehicleCountDayTrafficCentre
	,VehicleCountDayTrafficCentreHour
	,VehicleCountDayTrafficCentreShift
	,InsertAuditKey
	,UpdateAuditKey
	,DeltaLogKey
)
SELECT
	 CameraKey									AS CameraKey
	,GeoLocationKey								AS GeoLocationKey
	,Hour24										AS HourKey
	,OperationsDateKey							AS OperationsDateKey
	,TrafficCentreKey							AS TrafficCentreKey
	,ISNULL(VehicleTypeKey,-1)					AS VehicleTypeKey
	,COUNT(1)									AS SightingsCount
	,SUM(VehicleCountDay)						AS VehicleCountDay
	,SUM(VehicleCountDayCamera)					AS VehicleCountDayCamera
	,SUM(VehicleCountDayRegion)					AS VehicleCountDayRegion
	,SUM(VehicleCountDayTrafficCentre)			AS VehicleCountDayTrafficCentre
	,SUM(VehicleCountDayTrafficCentreHour)		AS VehicleCountDayTrafficCentreHour
	,SUM(VehicleCountDayTrafficCentreShift)		AS VehicleCountDayTrafficCentreShift
	,@AuditKey									AS InsertAuditKey
	,@AuditKey									AS UpdateAuditKey
	,@DeltaLogKey								AS DeltaLogKey
FROM Factcte f
GROUP BY OperationsDateKey, CameraKey, GeoLocationKey, Hour24, TrafficCentreKey, VehicleTypeKey
