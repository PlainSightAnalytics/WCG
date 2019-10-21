







CREATE VIEW [dbo].[LoadFactSightings] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-08-2016
-- Reason				:	Load View for FactSightings
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
     ISNULL(d1.[CameraKey],-1)				AS CameraKey
    ,ISNULL(d2.[GeoLocationKey],-1)			AS GeoLocationKey
	,ISNULL(d3.[DateKey],-1)				AS OperationsDateKey
	,ISNULL(d4.[DateKey],-1)				AS SightingDateKey
	,ISNULL(d5.[TimeKey],-1)				AS SightingTimeKey
	,ISNULL(d6.[TrafficCentreKey],-1)		AS TrafficCentreKey
    ,ISNULL(d7.[VehicleKey],-1)				AS VehicleKey
    ,tfm.[SightingRecordId]					AS SightingRecordId
    ,tfm.[PartyKey]							AS PartyKey
	,tfm.[DeltaLogKey]						AS DeltaLogKey
  FROM [WCG_Stage].[cle].[transformFactSightings]  tfm WITH (NOLOCK)
  LEFT JOIN [WCG_DW].[dbo].[DimCamera]				d1 WITH (NOLOCK) ON tfm.CameraGUID = d1.CameraGUID
  LEFT JOIN [WCG_DW].[dbo].[DimGeoLocation]			d2 WITH (NOLOCK) ON tfm.LatitudeRange = d2.LatitudeRange AND tfm.LongitudeRange = d2.LongitudeRange
  LEFT JOIN [WCG_DW].[dbo].[DimDate]				d3 WITH (NOLOCK) ON tfm.OperationsDate = d3.FullDate
  LEFT JOIN [WCG_DW].[dbo].[DimDate]				d4 WITH (NOLOCK) ON tfm.SightingDate = d4.FullDate
  LEFT JOIN [WCG_DW].[dbo].[DimTime]				d5 WITH (NOLOCK) ON tfm.SightingTime = d5.FullTime
  LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]		d6 WITH (NOLOCK) ON tfm.TrafficCentreGUID = d6.TrafficCentreID
  LEFT JOIN [WCG_DW].[dbo].[DimVehicle]				d7 WITH (NOLOCK) ON tfm.RegistrationNo = d7.RegistrationNo










