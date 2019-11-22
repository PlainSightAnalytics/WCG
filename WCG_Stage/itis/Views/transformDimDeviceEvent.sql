CREATE VIEW [itis].[transformDimDeviceEvent] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	19-11-2019
-- Reason				:	Transform view for DimDeviceEvent from itis.last_known_location
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
----------------------------------------------------------------------------------------------------------------------------------------


SELECT DISTINCT
	 ISNULL(CAST(user_event_source AS VARCHAR(50)),'Unknown')			AS EventSource
	,ISNULL(CAST(user_event_subtype AS VARCHAR(50)),'Unknown')			AS EventSubType
	,ISNULL(CAST(user_event_type AS VARCHAR(50)),'Unknown')				AS EventType
	,l.DeltaLogKey														AS DeltaLogKey
FROM itis.transformLastKnownLocation l