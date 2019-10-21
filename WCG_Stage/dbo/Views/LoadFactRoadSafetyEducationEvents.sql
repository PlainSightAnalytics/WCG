
CREATE VIEW [dbo].[LoadFactRoadSafetyEducationEvents] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-04-2019
-- Reason				:	Load view for FactRoadSafetyEducationEvents
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	17-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.DateKey,-1)								AS CreateDateKey
	,ISNULL(d2.TimeKey,-1)								AS CreateTimeKey
	,ISNULL(d3.DriverKey,-1)							AS DriverKey
	,ISNULL(d4.DateKey,-1)								AS OperationsDateKey
	,ISNULL(d5.RoadSafetyTopicKey,-1)					AS RoadSafetyTopicKey
	,ISNULL(d6.TrafficCentreKey,-1)						AS TrafficCentreKey
	,ISNULL(d7.TrafficControlEventKey,-1)				AS TrafficControlEventKey
	,ISNULL(d8.UserKey,-1)								AS UserKey
	,ISNULL(d9.VehicleKey,-1)							AS VehicleKey
	,tfm.UniqueID										AS UniqueID
	,tfm.[DeltaLogKey]									AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactRoadSafetyEducationEvents] tfm WITH (NOLOCK)
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d1 WITH (NOLOCK) ON tfm.CreateDate = d1.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTime]					d2 WITH (NOLOCK) ON tfm.CreateTime = d2.FullTime
LEFT JOIN [WCG_DW].[dbo].[DimDriver]				d3 WITH (NOLOCK) ON tfm.IDDocumentNo = d3.IDDocumentNo
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d4 WITH (NOLOCK) ON tfm.CreateDate = d4.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimRoadSafetyTopic]		d5 WITH (NOLOCK) ON tfm.RoadSafetyTopicID = d5.RoadSafetyTopicID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]			d6 WITH (NOLOCK) ON tfm.TrafficCentreID = d6.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficControlEvent]	d7 WITH (NOLOCK) ON tfm.TrafficControlEventID = d7.TrafficControlEventGUID
LEFT JOIN [WCG_DW].[dbo].[DimUser]					d8 WITH (NOLOCK) ON tfm.CreatedByUserID = d8.UserID
LEFT JOIN [WCG_DW].[dbo].[DimVehicle]				d9 WITH (NOLOCK) ON tfm.RegistrationNo = d9.RegistrationNo



