


CREATE VIEW [pnd].[transformDimJourneyUser] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	03-02-2019
-- Reason				:	Transform view for DimJourneyUser
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(ISNULL(u.persal_number,'Unknown') AS VARCHAR(30))			AS [EmployeeNumber]
	,CAST(u.name AS VARCHAR(30))									AS [FirstName]
	,CAST(ISNULL(u.id_number,'Unknown') AS VARCHAR(20))				AS [IDNumber]
	,CAST(ISNULL(u.infrastructure_number,'Unknown') AS VARCHAR(30))	AS [InfrastructureNumber]
,CAST(
		CASE
			WHEN u.inactive_display = 'Active' THEN 'Yes'
			ELSE 'No'
		END AS VARCHAR(3))											AS [IsActive]
	,CAST(u.mobile_number AS VARCHAR(20))							AS [MobileNo]
	,CAST(ISNULL(i.name,'Unknown') AS VARCHAR(50))					AS [PoundFacility]
	,CAST(ISNULL(u.rank_display,'Unknown') AS VARCHAR(30))			AS [Rank]
	,CAST(ISNULL(u.role_display,'Unknown') AS VARCHAR(30))			AS [Role]
	,CAST(ISNULL(u.surname,'Unknown') AS VARCHAR(50))				AS [Surname]
	,CAST(ISNULL(i.name,'Unknown') AS VARCHAR(50))					AS [TrafficCentre]
	,u.id															AS [JourneyUserID]
	,u.DeltaLogKey													AS [DeltaLogKey]
FROM [WCG_Stage].[pnd].[user] u						WITH (NOLOCK)
LEFT JOIN [WCG_Stage].[pnd].[impound] i				WITH (NOLOCK) ON u.impound_id = i.id
LEFT JOIN [WCG_Stage].[pnd].[traffic_centre] tc		WITH (NOLOCK) ON u.traffic_centre_id = tc.id









