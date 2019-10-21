
CREATE PROCEDURE [dbo].[prcLoadFactFreightTracking]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	29-09-2018
-- Reason				:	Loads Vehicle Tracking Data for Taxis for Sightings, Alerts, and TCEs 
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadFactFreightTracking] -1, -1, 20171201
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT = -1,
@DeltaLogKey INT = -1,
@FirstDateKey INT = NULL

AS

DECLARE @StartDateTime AS DATETIME

IF @FirstDateKey IS NULL
	SELECT @FirstDateKey = DateKey FROM WCG_DW.dbo.DimDate WITH (NOLOCK) WHERE FullDate = DATEADD(Month,-3,CAST(GETDATE() AS DATE))

SELECT @StartDateTime = CAST(FullDate AS DATETIME) FROM WCG_DW.dbo.DimDate WITH (NOLOCK) WHERE DateKey = @FirstDateKey

/* Clear out existing table first */
TRUNCATE TABLE WCG_DW.dbo.FactFreightTracking

/* Sightings */
;WITH CTE AS (
SELECT
	 f.CameraKey				AS CameraKey
	,f.SightingDateKey			AS DateKey
	,f.GeoLocationKey			AS GeoLocationKey
	,f.OperationsDateKey		AS OperationsDateKey
	,f.SightingTimeKey			AS TimeKey
	,f.TrafficCentreKey			AS TrafficCentreKey
	,f.VehicleKey				AS VehicleKey
	,ROW_NUMBER() OVER (PARTITION BY f.VehicleKey, f.SightingDateKey, f.SightingTimeKey ORDER BY SightingRecordId DESC) AS SightingsSequence
FROM  WCG_DW.dbo.FactSightings f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimVehicle d1 WITH (NOLOCK) ON f.VehicleKey = d1.VehicleKey
WHERE SightingDateKey > @FirstDateKey
AND (d1.VehicleCategoryCode IN ('M','L'))
AND CameraKey <> -1
)

INSERT INTO  WCG_DW.dbo.FactFreightTracking (
	 CameraKey
	,DateKey
	,GeoLocationKey
	,OperationsDateKey
	,TimeKey
	,TrafficCentreKey
	,VehicleKey
	,Event
	,InsertAuditKey
	,UpdateAuditKey
	,DeltaLogKey
)
SELECT
	 CameraKey		
	,DateKey		
	,GeoLocationKey	
	,OperationsDateKey
	,TimeKey		
	,TrafficCentreKey		
	,VehicleKey				
	,'Sighting'	
	,@AuditKey
	,@AuditKey
	,@DeltaLogKey
FROM  CTE
WHERE SightingsSequence = 1


/* Alerts */
INSERT INTO  WCG_DW.dbo.FactFreightTracking (
	 CameraKey
	,DateKey
	,GeoLocationKey
	,OperationsDateKey
	,TimeKey
	,TrafficCentreKey
	,VehicleKey
	,Event
	,InsertAuditKey
	,UpdateAuditKey
	,DeltaLogKey
)
SELECT
	 f.CameraKey						AS CameraKey
	,f.UpdatedDateKey					AS DateKey
	,f.GeoLocationKey					AS GeoLocationKey
	,f.OperationsDateKey				AS OperationsDateKey
	,f.UpdatedTimeKey					AS TimeKey
	,f.TrafficCentreKey					AS TrafficCentreKey
	,f.VehicleKey						AS VehicleKey
	,CONCAT('Alert - ',d1.AlertType)	AS Event
	,@AuditKey
	,@AuditKey
	,@DeltaLogKey
FROM WCG_DW.dbo.FactAlerts f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimAlertType d1 WITH (NOLOCK) ON f.AlertTypeKey = d1.AlertTypeKey
LEFT JOIN WCG_DW.dbo.DimVehicle d2 WITH (NOLOCK) ON f.VehicleKey = d2.VehicleKey
WHERE UpdatedDateKey > @FirstDateKey 
AND (d2.VehicleCategoryCode IN ('M','L'))
AND CameraKey <> -1



/* Infer Geo Location from DimTrafficControlEvent */
;WITH conf AS (
SELECT DISTINCT 
	 CAST(e.Longitude AS NUMERIC(19,2))		AS [LongitudeRange]
	,CAST(e.Latitude AS NUMERIC(19,2))		AS [LatitudeRange]
	,CAST(e.Longitude AS NUMERIC(19,5))		AS [Longitude]
	,CAST(e.Latitude AS NUMERIC(19,5))		AS [Latitude]
FROM WCG_DW.dbo.FactTrafficControlEvents f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimTrafficControlEvent e WITH (NOLOCK) on f.TrafficControlEventKey = e.TrafficControlEventKey
LEFT JOIN WCG_DW.dbo.DimVehicle d2 WITH (NOLOCK) ON f.VehicleKey = d2.VehicleKey
WHERE OpenDateKey > @FirstDateKey
AND (d2.VehicleCategoryCode IN ('M','L')))

MERGE INTO WCG_DW.dbo.DimGeoLocation dim
USING conf
ON (dim.[LongitudeRange] = conf.[LongitudeRange] AND dim.[LatitudeRange] = conf.[LatitudeRange])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			[LongitudeRange], [LatitudeRange], [Longitude], [Latitude], InsertAuditKey, UpdateAuditKey, DeltaLogKey
			)
	VALUES (
			conf.[LongitudeRange], conf.[LatitudeRange], conf.[Longitude], conf.[Latitude], @AuditKey, @AuditKey, @DeltaLogKey
			);

/* Traffic Control Events */
;WITH CTE AS (
SELECT
	 f.OpenDateKey						AS DateKey
	,ISNULL(g.GeoLocationKey,-1)		AS GeoLocationKey
	,f.OperationsDateKey				AS OperationsDateKey
	,MAX(f.OpenTimeKey)					AS TimeKey
	,f.TrafficCentreKey					AS TrafficCentreKey
	,f.VehicleKey						AS VehicleKey
	,SUM(f.ChargeAmount)				AS ChargeAmount
FROM WCG_DW.dbo.FactTrafficControlEventOutcomes f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimTrafficControlEvent e  WITH (NOLOCK) ON f.TrafficControlEventKey = e.TrafficControlEventKey
LEFT JOIN WCG_DW.dbo.DimGeoLocation g WITH (NOLOCK) ON g.LongitudeRange =  CAST(e.Longitude AS NUMERIC(19,2)) AND g.LatitudeRange = CAST(e.Latitude AS NUMERIC(19,2))
LEFT JOIN WCG_DW.dbo.DimVehicle d2 WITH (NOLOCK) ON f.VehicleKey = d2.VehicleKey
WHERE f.UpdatedDateKey > @FirstDateKey
AND (d2.VehicleCategoryCode IN ('M','L'))
GROUP BY f.OpenDateKey, f.OperationsDateKey, g.GeoLocationKey, f.TrafficCentreKey, f.VehicleKey)

INSERT INTO  WCG_DW.dbo.FactFreightTracking (
	 DateKey
	,GeoLocationKey
	,OperationsDateKey
	,TimeKey
	,TrafficCentreKey
	,VehicleKey
	,Event
	,InsertAuditKey
	,UpdateAuditKey
	,DeltaLogKey
)
SELECT
	 DateKey
	,GeoLocationKey
	,OperationsDateKey
	,TimeKey
	,TrafficCentreKey
	,VehicleKey
	,CASE
		WHEN ChargeAmount IS NOT NULL THEN 'TCE - Stopped and Fined'
		ELSE 'TCE - Stopped'
	END	
	,@AuditKey
	,@AuditKey
	,@DeltaLogKey
FROM CTE

/* Drop Foreign Key Constraints */
ALTER TABLE WCG_DW.[dbo].[FactFreightTracking]  DROP CONSTRAINT [FK_dbo_FactFreightTracking_TripKey]

/* Truncate DimTrip */
TRUNCATE TABLE WCG_DW.dbo.DimTripFreight

/* Insert Unknown Row */
SET IDENTITY_INSERT WCG_DW.dbo.DimTripFreight ON

INSERT INTO WCG_DW.dbo.DimTripFreight
(TripKey,Route,FromToCamera,RegistrationNo,EndTime,StartTime,TripDuration,TotalDistance,AverageSpeed,SpeedSectionCount,PreviousEndTime,TurnaroundHours,SpeedingFlag,FatiqueFlag,TurnaroundFlag)
VALUES (-1, 'Unknown', 'Unknown', 'Unknown', NULL, NULL, 0, 0, 0, 0, NULL, 0,'No', 'No', 'No')

SET IDENTITY_INSERT WCG_DW.dbo.DimTripFreight OFF

ALTER TABLE WCG_DW.[dbo].[FactFreightTracking]  WITH  CHECK  ADD CONSTRAINT [FK_dbo_FactFreightTracking_TripKey] FOREIGN KEY ([TripKey]) REFERENCES [dbo].[DimTripFreight] ([TripKey]) ON UPDATE  NO ACTION  ON DELETE  NO ACTION 

/* Insert Trip Rows */
INSERT INTO WCG_DW.dbo.DimTripFreight
(Route,FromToCamera,RegistrationNo,EndTime,StartTime,TripDuration,TotalDistance,AverageSpeed,SpeedSectionCount,PreviousEndTime,TurnaroundHours, SpeedingFlag,FatiqueFlag,TurnaroundFlag)
SELECT
Route,FromToCamera,RegistrationNo,EndTime,StartTime,TripDuration,TotalDistance,AverageSpeed,SpeedSectionCount,PreviousEndTime,TurnaroundHours, SpeedingFlag,FatiqueFlag,TurnaroundFlag
FROM WCG_Stage.cle.transformDimTripFreight
WHERE StartTime >= @StartDateTime


/* Update Fact table with Trip Key */
UPDATE f
SET TripKey = ISNULL(d5.TripKey,-1)
FROM
WCG_DW.dbo.FactFreightTracking f
LEFT JOIN WCG_DW.dbo.DimVehicle d1 ON f.VehicleKey = d1.VehicleKey
LEFT JOIN WCG_DW.model.[Camera Enhanced] d2 ON f.CameraKey = d2.CameraKey
LEFT JOIN WCG_DW.dbo.DimDate d3 ON f.DateKey = d3.DateKey
LEFT JOIN WCG_DW.dbo.DimTime d4 ON f.TimeKey = d4.TimeKey
LEFT JOIN WCG_DW.dbo.DimTripFreight d5 ON 
	d5.RegistrationNo = d1.RegistrationNo
AND CAST(d3.FullDate AS DATETIME) + CAST(d4.FullTime AS DATETIME) BETWEEN d5.StartTime AND d5.EndTime
