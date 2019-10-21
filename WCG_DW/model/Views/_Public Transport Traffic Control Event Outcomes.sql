


CREATE VIEW [model].[_Public Transport Traffic Control Event Outcomes] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   20-04-2019
-- Reason               :   Traffic Control Event Outcomes filtered for Public Transport Only
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	24-07-2019
-- Reason               :	Add OperationsDateKey
------------------------------------------------------------------------------------------
WITH CTE AS (

	SELECT 
		 f.[DeviceKey]													AS [DeviceKey]
		,f.[DriverKey]													AS [DriverKey]
		,f.[MagistratesCourtKey]										AS [MagistratesCourtKey]
		,f.[OpenDateKey]												AS [OpenDateKey]
		,f.[OpenTimeKey]												AS [OpenTimeKey]
		,f.[OperationKey]												AS [OperationKey]
		,f.[OperationsDateKey]											AS [OperationsDateKey]
		,f.[Section56FormKey]											AS [Section56FormKey]
		,f.[TrafficCentreKey]											AS [TrafficCentreKey]
		,f.[TrafficControlEventKey]										AS [TrafficControlEventKey]
		,f.[UpdatedDateKey]												AS [UpdatedDateKey]
		,f.[UpdatedTimeKey]												AS [UpdatedTimeKey]
		,f.[UserKey]													AS [UserKey]
		,f.[VehicleKey]													AS [VehicleKey]
		,f.[VehicleTypeKey]												AS [VehicleTypeKey]
		,f.[ViolationChargeKey]											AS [ViolationChargeKey]
		,f.[UniqueChargeID]												AS [Unique Charge ID]
		,f.[UniqueSection56FormID]										AS [Unique Section 5 6 Form ID]
		,f.[ChargeAmount]												AS [_ChargeAmount]
		,CAST(d2.FullDate AS DATETIME) + CAST(d3.FullTime AS DATETIME)	AS TCEDateTime
		,d1.RegistrationNo												AS RegistrationNo
		,CAST(d4.Latitude AS NUMERIC(19,2))								AS LatitudeRange
		,CAST(d4.Longitude AS NUMERIC(19,2))							AS LongitudeRange
	FROM WCG_DW.dbo.FactTrafficControlEventOutcomes f WITH (NOLOCK)
	LEFT JOIN WCG_DW.dbo.DimVehicle d1 WITH (NOLOCK) ON f.VehicleKey = d1.VehicleKey
	LEFT JOIN WCG_DW.dbo.DimDate d2 WITH (NOLOCK) ON f.OpenDateKey = d2.DateKey
	LEFT JOIN WCG_DW.dbo.DimTime d3 WITH (NOLOCK) ON f.OpenTimeKey = d3.TimeKey
	LEFT JOIN WCG_DW.dbo.DimTrafficControlEvent d4 WITH (NOLOCK) ON f.TrafficControlEventKey = d4.TrafficControlEventKey
	WHERE
		f.UpdatedDateKey > 20181130
	AND (
		d1.VehicleCategoryCode = 'C'
	OR	d1.VehicleUsageCode = '02')
)

,GeoCTE AS (
SELECT
	GeoLocationKey
	,LatitudeRange
	,LongitudeRange
	,ROW_NUMBER() OVER (PARTITION BY LatitudeRange, LongitudeRange ORDER BY GeoLocationKey) AS RowSequence
FROM WCG_DW.dbo.DimGeoLocation
)

SELECT 
	 [DriverKey]								AS [DriverKey]
	,ISNULL(d6.GeoLocationKey,-1)				AS [GeoLocationKey]
	,[OpenDateKey]								AS [OpenDateKey]
	,[OpenTimeKey]								AS [OpenTimeKey]
	,[OperationsDateKey]						AS [OperationsDateKey]
	,[Section56FormKey]							AS [Section56FormKey]
	,[TrafficCentreKey]							AS [TrafficCentreKey]
	,[TrafficControlEventKey]					AS [TrafficControlEventKey]
	,ISNULL(d5.TripKey,-1)						AS [TripKey]
	,[UserKey]									AS [UserKey]
	,[VehicleKey]								AS [VehicleKey]
	,[ViolationChargeKey]						AS [ViolationChargeKey]
	,[_ChargeAmount]							AS [_ChargeAmount]
FROM CTE
LEFT JOIN WCG_DW.dbo.DimTrip d5 WITH (NOLOCK) ON cte.RegistrationNo = d5.RegistrationNo AND cte.TCEDateTime BETWEEN d5.StartTime AND d5.EndTime
LEFT JOIN GeoCTE d6 WITH (NOLOCK) ON cte.LatitudeRange = d6.LatitudeRange AND cte.LongitudeRange = d6.LongitudeRange AND d6.RowSequence = 1



