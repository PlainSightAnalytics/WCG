






ALTER VIEW [dbo].[LoadFactTrafficControlEvents] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-05-2018
-- Reason				:	Load view for FactTrafficControls
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	26-08-2018
-- Reason				:	Added OpenDateKey and OpenTimeKey
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	02-09-2018
-- Reason				:	Added DriverKey
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-10-2019
-- Reason				:	Fix bug on foreign key to operations date (was still on OpenDate instead of OperationsDate)
--							Second Line.
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.[AlertTypeKey],-1)			AS AlertTypeKey
	,ISNULL(d2.[DeviceKey],-1)				AS DeviceKey
	,ISNULL(d3.[DriverKey],-1)				AS DriverKey
	,ISNULL(d4.[MagistratesCourtKey],-1)	AS MagistratesCourtKey
	,ISNULL(d5.[DateKey],-1)				AS OpenDateKey
	,ISNULL(d6.[TimeKey],-1)				AS OpenTimeKey
	,ISNULL(d7.[DateKey],-1)				AS OperationsDateKey
	,ISNULL(d8.[TrafficCentreKey],-1)		AS TrafficCentreKey
	,ISNULL(d9.[TrafficControlEventKey],-1) AS TrafficControlEventKey
	,ISNULL(d10.[DateKey],-1)				AS UpdatedDateKey
	,ISNULL(d11.[TimeKey],-1)				AS UpdatedTimeKey
	,ISNULL(d12.[UserKey],-1)				AS UserKey
	,ISNULL(d13.[VehicleKey],-1)			AS VehicleKey
	,ISNULL(d14.[VehicleTypeKey],-1)		AS VehicleTypeKey
	,tfm.UniqueAlertID						AS UniqueAlertID
	,tfm.UniqueEventID						AS UniqueEventID
	,tfm.[DeltaLogKey]						AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactTrafficControlEvents] tfm WITH (NOLOCK)
LEFT JOIN [WCG_DW].[dbo].[DimAlertType]				d1 WITH (NOLOCK) ON tfm.AlertSubTypeCode = d1.AlertSubTypeCode AND tfm.AlertTypeId = d1.AlertTypeId
LEFT JOIN [WCG_DW].[dbo].[DimDevice]				d2 WITH (NOLOCK) ON tfm.DeviceGUID = d2.DeviceID		
LEFT JOIN [WCG_DW].[dbo].[DimDriver]				d3 WITH (NOLOCK) ON tfm.IDDocumentNo = d3.IDDocumentNo
LEFT JOIN [WCG_DW].[dbo].[DimMagistratesCourt]		d4 WITH (NOLOCK) ON tfm.MagistratesCourtGUID = d4.MagistratesCourtID
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d5 WITH (NOLOCK) ON tfm.OpenDate = d5.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTime]					d6 WITH (NOLOCK) ON tfm.OpenTime = d6.FullTime
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d7 WITH (NOLOCK) ON tfm.OperationsDate = d7.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]			d8 WITH (NOLOCK) ON tfm.TrafficCentreGUID = d8.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficControlEvent]	d9 WITH (NOLOCK) ON tfm.TrafficControlEventGUID = d9.TrafficControlEventGUID
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d10 WITH (NOLOCK) ON tfm.UpdatedDate = d10.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTime]					d11 WITH (NOLOCK) ON tfm.UpdatedTime = d11.FullTime
LEFT JOIN [WCG_DW].[dbo].[DimUser]					d12 WITH (NOLOCK) ON tfm.UserGUID = d12.UserID
LEFT JOIN [WCG_DW].[dbo].[DimVehicle]				d13 WITH (NOLOCK) ON tfm.RegistrationNo = d13.RegistrationNo
LEFT JOIN [WCG_DW].[dbo].[DimVehicleType]			d14 WITH (NOLOCK) ON tfm.VehicleCategoryCode = d14.VehicleCategoryCode AND tfm.VehicleUsageCode = d14.VehicleUsageCode












