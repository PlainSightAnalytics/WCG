
CREATE VIEW [model].[Device] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:42 PM
-- Reason               :   Semantic View for dbo.DimDevice
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [DeviceKey] AS [DeviceKey]
	,[CurrentUserKey] AS [CurrentUserKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[Device] AS [Device]
	,[DeviceID] AS [Device ID]
	,[DeviceType] AS [Device Type]
FROM WCG_DW.dbo.DimDevice WITH (NOLOCK)
