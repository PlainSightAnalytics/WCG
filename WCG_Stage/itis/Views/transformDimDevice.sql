




CREATE VIEW [itis].[transformDimDevice] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-06-2016
-- Reason				:	Transform view for Device
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 [id]							AS [DeviceID]
	,[display]						AS [Device]
	,[name]							AS [DeviceType]
	,ISNULL(tc.TrafficCentreKey,-1)	AS [TrafficCentreKey]
	,ISNULL(u.UserKey,-1)			AS [CurrentUserKey]
	,d.DeltaLogKey					AS [DeltaLogKey]
FROM [WCG_Stage].[itis].[device] d
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre] tc ON d.traffic_centre_id = tc.TrafficCentreId
LEFT JOIN [WCG_DW].[dbo].[DimUser] u ON d.current_user_id = u.UserID








