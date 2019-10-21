

CREATE VIEW [itis].[transformDimRoster] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	05-05-2018
-- Reason				:	Transform view for DimRosterGroup
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	10-04-2019
-- Reason				:	Updated RosterStatus to cater for nulls
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 CAST(ISNULL(r.archived_display,'No') AS VARCHAR(3))	AS [IsArchived]
	,CAST(ISNULL(r.deleted_display,'No') AS VARCHAR(3))		AS [IsDeleted]
	,CAST(r.display AS VARCHAR(50))							AS [Roster]
	,CAST(ISNULL(rg.display,'Unknown') AS VARCHAR(100))		AS [RosterGroupDescription]
	,r.id													AS [RosterGUID]
	,CAST(ISNULL(rg.name,'Unknown') AS VARCHAR(50))			AS [RosterGroup]
	,CAST(ISNULL(ur.display,'Unknown') AS VARCHAR(50))		AS [RosterGroupReportsTo]
	,CAST(ISNULL(r.revised_display,'No') AS VARCHAR(3))		AS [IsRevised]
	,CAST(
		WCG_STAGE.dbo.ToProperCase(
			UPPER(ISNULL(r.status_key,'Unknown'))
		) AS VARCHAR(50))									AS [RosterStatus]
	,CAST(ISNULL(up.display,'Unknown') AS VARCHAR(50))		AS [RosterGroupPPI]
	,CAST(ISNULL(us.display,'Unknown') AS VARCHAR(50))		AS [RosterGroupSPI]
FROM [itis].[roster] r WITH (NOLOCK)
LEFT JOIN [itis].[roster_group] rg WITH (NOLOCK) ON r.[roster_group_id] = rg.[id]
LEFT JOIN [itis].[user] ur WITH (NOLOCK) ON rg.[reports_to_id] = ur.[id]
LEFT JOIN [itis].[user] up WITH (NOLOCK) ON rg.[user_ppi_id] = up.[id]
LEFT JOIN [itis].[user] us WITH (NOLOCK) ON rg.[user_spi_id] = us.[id]
