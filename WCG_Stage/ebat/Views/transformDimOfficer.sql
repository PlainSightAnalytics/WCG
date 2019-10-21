







CREATE VIEW [ebat].[transformDimOfficer] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	12-08-2106
-- Reason				:	Transform view for DimOfficer
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 o.[id]																					AS [OfficerID]
	,CAST(
		ISNULL(NULLIF(o.[display],''),'UNKNOWN') + 
		CASE
			WHEN ISNULL(o.[officer_infrastructure_number],'') = '' THEN ''
			ELSE ' (' + o.[officer_infrastructure_number] + ')'
		END AS VARCHAR(50))																	AS [Officer]
	,CAST(ISNULL([officer_full_name],'Unknown') AS VARCHAR(50))								AS [FirstNames]
	,CAST(ISNULL([officer_surname],'Unknown') AS VARCHAR(50))								AS [Surname]
	,CAST(ISNULL([officer_initials],'Unknown') AS VARCHAR(10))								AS [Initials]
	,CAST(ISNULL(r.[Name],'Unknown') AS VARCHAR(50))										AS [Rank]
	,CAST(ISNULL(NULLIF([officer_infrastructure_number],''),'Unknown') AS VARCHAR(20))		AS [InfrastructureNumber]
	,CAST(ISNULL([officer_id_number],'Unknown') AS VARCHAR(20))								AS [IDNumber]
	,CAST(ISNULL([officer_mobile_number],'Unknown') AS VARCHAR(20))							AS [MobileNumber]
	,CAST(ISNULL([other_authority],'Unknown') AS VARCHAR(50))								AS [OtherAuthority]
	,CAST(ISNULL([other_rank],'Unknown') AS VARCHAR(50))									AS [OtherRank]
	,CAST(ISNULL([other_station],'Unknown') AS VARCHAR(50))									AS [OtherStation]
	,CAST(ISNULL(s.[display],'Unknown') AS VARCHAR(50))										AS [Station]
	,CAST(ISNULL(a.[display],'Unknown') AS VARCHAR(50))										AS [Authority]
	,CAST(ISNULL(m.[display],'Unknown') AS VARCHAR(50))										AS [Municipality]
	,CAST(ISNULL(d.[display],'Unknown') AS VARCHAR(50))										AS [District]
	,CAST(ISNULL(p.[display],'Unknown') AS VARCHAR(50))										AS [Province]
	,o.DeltaLogKey																			AS [DeltaLogKey]
FROM [WCG_Stage].[ebat].[officer] o WITH (NOLOCK)
LEFT OUTER JOIN [WCG_Stage].[ebat].[rank] r WITH (NOLOCK) ON o.rank_id = r.id
LEFT OUTER JOIN [WCG_Stage].[ebat].[authority] a WITH (NOLOCK) ON o.[authority_id] = a.[id]
LEFT OUTER JOIN [WCG_Stage].[ebat].[province] p WITH (NOLOCK) ON a.[province_id] = p.[id]
LEFT OUTER JOIN [WCG_Stage].[ebat].[station] s WITH (NOLOCK) ON o.[station_id] = s.[id]
LEFT OUTER JOIN [WCG_Stage].[ebat].[municipality] m WITH (NOLOCK) ON s.[municipality_id] = m.[id]
LEFT OUTER JOIN [WCG_Stage].[ebat].[district] d WITH (NOLOCK) ON  m.[district_id] = d.[id]










