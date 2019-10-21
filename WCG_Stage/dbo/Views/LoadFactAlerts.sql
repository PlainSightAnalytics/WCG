







CREATE VIEW [dbo].[LoadFactAlerts] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	28-04-2018
-- Reason				:	Load View for FactAlerts
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	12-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
     ISNULL(d1.[AlertTypeKey],-1)			AS AlertTypeKey
    ,ISNULL(d2.[CameraKey],-1)				AS CameraKey
    ,ISNULL(d3.[GeoLocationKey],-1)			AS GeoLocationKey
	,ISNULL(d4.[DateKey],-1)				AS OperationsDateKey
    ,ISNULL(d5.[TrafficCentreKey],-1)		AS TrafficCentreKey
	,ISNULL(d6.[DateKey],-1)				AS UpdatedDateKey
	,ISNULL(d7.[TimeKey],-1)				AS UpdatedTimeKey
	,ISNULL(d8.[VehicleKey],-1)				AS VehicleKey
	,tfm.AlertRecordId						AS AlertRecordId
    ,tfm.[AlertStatus]						AS AlertStatus
	,tfm.SourceAlertID						AS SourceAlertID
	,tfm.[SourceSystem]						AS SourceSystem
    ,tfm.[SpeedClassCode]					AS SpeedClassCode
    ,tfm.[VehicleCategory]					AS VehicleCategory
    ,tfm.[VehicleCategoryCode]				AS VehicleCategoryCode
    ,tfm.[VehicleUsage]						AS VehicleUsage
    ,tfm.[VehicleUsageCode]					AS VehicleUsageCode
    ,tfm.[AverageSpeed]						AS AverageSpeed
    ,tfm.[DurationAlert]					AS DurationAlert
	,tfm.[DurationPrimary]					AS DurationPrimary
    ,tfm.[SpeedLimit]						AS SpeedLimit
	,tfm.[DeltaLogKey]						AS DeltaLogKey
  FROM [WCG_Stage].[cle].[transformFactAlerts] as tfm	
  LEFT OUTER JOIN [WCG_DW].[dbo].[DimAlertType]			d1 ON tfm.[AlertTypeID] = d1.[AlertTypeID] AND tfm.[AlertSubtypeCode] = d1.[AlertSubtypeCode]
  LEFT OUTER JOIN [WCG_DW].[dbo].[DimCamera]			d2 ON tfm.CameraGUID = d2.CameraGUID
  LEFT OUTER JOIN [WCG_DW].[dbo].[DimGeoLocation]		d3 ON tfm.[LatitudeRange] = d3.[LatitudeRange] AND tfm.[LongitudeRange] = d3.[LongitudeRange]
  LEFT OUTER JOIN [WCG_DW].[dbo].[DimDate]				d4 ON tfm.OperationsDate = d4.FullDate
  LEFT OUTER JOIN [WCG_DW].[dbo].[DimTrafficCentre]		d5 ON tfm.TrafficCentreGUID = d5.TrafficCentreID
  LEFT OUTER JOIN [WCG_DW].[dbo].[DimDate]				d6 ON tfm.UpdatedDate = d6.FullDate
  LEFT OUTER JOIN [WCG_DW].[dbo].[DimTime]				d7 ON tfm.UpdatedTime = d7.FullTime
  LEFT OUTER JOIN [WCG_DW].[dbo].[DimVehicle]			d8 ON tfm.RegistrationNo = d8.RegistrationNo










