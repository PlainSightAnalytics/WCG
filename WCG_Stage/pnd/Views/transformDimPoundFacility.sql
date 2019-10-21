CREATE VIEW [pnd].[transformDimPoundFacility] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	03-02-2019
-- Reason				:	Transform view for DimPoundFacility
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 i.id							AS [PoundFacilityID]
	,ISNULL(lm.name,'Unknown')		AS [LocalMunicipality]
	,ISNULL(i.name,'Unknown')		AS [PoundFacility]
	,ISNULL(tc.name, 'Unknown')		AS [TrafficCentre]
FROM [WCG_Stage].[pnd].[impound] i					WITH (NOLOCK)
LEFT JOIN [WCG_Stage].[pnd].[local_municipality] lm WITH (NOLOCK) ON i.local_municipality_id = lm.id
LEFT JOIN [WCG_Stage].[pnd].[traffic_centre] tc		WITH (NOLOCK) ON i.traffic_centre_id = tc.id








