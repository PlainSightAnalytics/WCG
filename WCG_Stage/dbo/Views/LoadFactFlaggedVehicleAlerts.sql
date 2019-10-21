



CREATE VIEW [dbo].[LoadFactFlaggedVehicleAlerts] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	08-03-2019
-- Reason				:	Load View for FactVehicleAlerts
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

WITH CTE AS (
SELECT
     ISNULL(d1.[CameraKey],-1)					AS CameraKey
    ,ISNULL(d2.[GeoLocationKey],-1)				AS GeoLocationKey
	,ISNULL(d3.[DateKey],-1)					AS OperationsDateKey
	,ISNULL(d4.[DateKey],-1)					AS SightingDateKey
	,ISNULL(d5.[TimeKey],-1)					AS SightingTimeKey
    ,ISNULL(d6.[TrafficCentreKey],-1)			AS TrafficCentreKey
	,ISNULL(d7.[VehicleKey],-1)					AS VehicleKey
	,ISNULL(d8.[FlaggedVehicleTripKey],-1)		AS FlaggedVehicleTripKey
	,tfm.FlagType								AS FlagType
	,tfm.FlagCount								AS FlagCount
	,tfm.LastFlagDateTime						AS LastFlagDateTime
	,tfm.SightingRecordId						AS SightingRecordId
	,CAST(
		CONCAT(
			tfm.RegistrationNo,
			'-',
			tfm.SightingRecordId,
			'-',
			tfm.FlagType,
			'-',
			d6.TrafficCentreKey
			) AS VARCHAR(50))					AS UniqueId
FROM [WCG_Stage].[cle].[transformFactFlaggedVehicleAlerts] tfm	WITH (NOLOCK)
LEFT JOIN [WCG_DW].[dbo].[DimCamera]				d1 ON tfm.CameraId = d1.SiteID AND tfm.LaneId = d1.LaneID
LEFT JOIN [WCG_DW].[dbo].[DimGeoLocation]			d2 ON tfm.[LatitudeRange] = d2.[LatitudeRange] AND tfm.[LongitudeRange] = d2.[LongitudeRange]
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d3 ON tfm.OperationsDate = d3.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d4 ON tfm.SightingDate = d4.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTime]					d5 ON tfm.SightingTime = d5.FullTime
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]			d6 ON tfm.TrafficCentreGUID = d6.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimVehicle]				d7 ON tfm.RegistrationNo = d7.RegistrationNo
LEFT JOIN [WCG_DW].[dbo].[DimFlaggedVehicleTrip]	d8 ON tfm.RegistrationNo = d8.RegistrationNo AND tfm.LastFlagDateTime = d8.EndTime
)

SELECT
	 CameraKey
	,GeoLocationKey
	,OperationsDateKey
	,SightingDateKey
	,SightingTimeKey
	,TrafficCentreKey
	,VehicleKey
	,FlaggedVehicleTripKey
	,FlagType
	,FlagCount
	,LastFlagDateTime
	,SightingRecordId
	,UniqueId
	,ROW_NUMBER() OVER (PARTITION BY UniqueId ORDER BY FlaggedVehicleTripKey DESC) AS RowSequence
FROM CTE









