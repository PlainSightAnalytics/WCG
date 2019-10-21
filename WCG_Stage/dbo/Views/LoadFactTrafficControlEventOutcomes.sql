



CREATE VIEW [dbo].[LoadFactTrafficControlEventOutcomes] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	07-05-2018
-- Reason				:	Load view for FactTrafficControlEventOutcomes
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	13-01-2019
-- Reason				:	Added DriverKey, OpenDateKey, and OpenTimeKey
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.[DeviceKey],-1)				AS DeviceKey
	,ISNULL(d2.[DriverKey],-1)				AS DriverKey
	,ISNULL(d3.[MagistratesCourtKey],-1)	AS MagistratesCourtKey
	,ISNULL(d4.[DateKey],-1)				AS OperationsDateKey
	,ISNULL(d5.[DateKey],-1)				AS OpenDateKey
	,ISNULL(d6.[TimeKey],-1)				AS OpenTimeKey
	,ISNULL(d7.[Section56FormKey],-1)		AS Section56FormKey
	,ISNULL(d8.[TrafficCentreKey],-1)		AS TrafficCentreKey
	,ISNULL(d9.[TrafficControlEventKey],-1) AS TrafficControlEventKey
	,ISNULL(d10.[DateKey],-1)				AS UpdatedDateKey
	,ISNULL(d11.[TimeKey],-1)				AS UpdatedTimeKey
	,ISNULL(d12.[UserKey],-1)				AS UserKey
	,ISNULL(d13.[VehicleKey],-1)			AS VehicleKey
	,ISNULL(d14.[VehicleTypeKey],-1)		AS VehicleTypeKey
	,ISNULL(d15.[ViolationChargeKey],-1)	AS ViolationChargeKey
	,tfm.UniqueChargeID						AS UniqueChargeID
	,tfm.UniqueSection56FormID				AS UniqueSection56FormID
	,tfm.ChargeAmount						AS ChargeAmount
	,tfm.[DeltaLogKey]						AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactTrafficControlEventOutcomes] tfm WITH (NOLOCK)
LEFT JOIN [WCG_DW].[dbo].[DimDevice]				d1  WITH (NOLOCK) ON tfm.DeviceGUID = d1.DeviceID
LEFT JOIN [WCG_DW].[dbo].[DimDriver]				d2  WITH (NOLOCK) ON tfm.IDDocumentNo = d2.IDDocumentNo
LEFT JOIN [WCG_DW].[dbo].[DimMagistratesCourt]		d3  WITH (NOLOCK) ON tfm.MagistratesCourtGUID = d3.MagistratesCourtID
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d4  WITH (NOLOCK) ON tfm.OperationsDate = d4.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d5  WITH (NOLOCK) ON tfm.OpenDate = d5.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTime]					d6  WITH (NOLOCK) ON tfm.OpenTime = d6.FullTime
LEFT JOIN [WCG_DW].[dbo].[DimSection56Form]			d7  WITH (NOLOCK) ON tfm.Section56FormGUID = d7.Section56FormGUID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]			d8  WITH (NOLOCK) ON tfm.TrafficCentreGUID = d8.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficControlEvent]	d9  WITH (NOLOCK) ON tfm.TrafficControlEventGUID = d9.TrafficControlEventGUID
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d10  WITH (NOLOCK) ON tfm.UpdatedDate = d10.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTime]					d11  WITH (NOLOCK) ON tfm.UpdatedTime = d11.FullTime
LEFT JOIN [WCG_DW].[dbo].[DimUser]					d12  WITH (NOLOCK) ON tfm.UserGUID = d12.UserID
LEFT JOIN [WCG_DW].[dbo].[DimVehicle]				d13  WITH (NOLOCK) ON tfm.RegistrationNo = d13.RegistrationNo
LEFT JOIN [WCG_DW].[dbo].[DimVehicleType]			d14  WITH (NOLOCK) ON tfm.VehicleCategoryCode = d14.VehicleCategoryCode AND tfm.VehicleUsageCode = d14.VehicleUsageCode
LEFT JOIN [WCG_DW].[dbo].[DimViolationCharge]		d15  WITH (NOLOCK) ON tfm.ChargeCodeGUID = d15.ChargeGUID










