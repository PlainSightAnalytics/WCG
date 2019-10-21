CREATE VIEW [pnd].[transformDimTrafficCentre] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	03-02-2019
-- Reason				:	Transform view for DimTrafficCentre
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(ISNULL(email,'Unknown') AS VARCHAR(50))					AS [EmailAddress]
	,CAST(ISNULL(telephone_number,'Unknown') AS VARCHAR(20))		AS [TelephoneNo]
	,CAST(ISNULL(name,'Unknown') AS VARCHAR(50))					AS [TrafficCentre]
	,id																AS [TrafficCentreID]
FROM [WCG_Stage].[pnd].[traffic_centre] tc		WITH (NOLOCK)









