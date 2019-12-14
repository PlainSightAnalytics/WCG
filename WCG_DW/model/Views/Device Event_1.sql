
CREATE VIEW [model].[Device Event] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   16 Nov 2019 6:07:43 AM
-- Reason               :   Semantic View for dbo.DimDeviceEvent
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [DeviceEventKey] AS [DeviceEventKey]
	,[EventSource] AS [Event Source]
	,[EventSubType] AS [Event Sub Type]
	,[EventType] AS [Event Type]
FROM WCG_DW.dbo.DimDeviceEvent WITH (NOLOCK)