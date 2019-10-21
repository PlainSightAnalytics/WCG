


CREATE VIEW [ebat].[transformDimEBATRolePlayerUser] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	12-08-2106
-- Reason				:	Transform view for DimEBATRolePlayer from ebat.Operator
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	CAST(ISNULL(a.[display],'Unknown') AS VARCHAR(50))				AS [Authority]
	,CAST(ISNULL(c.[display],'Unknown') AS VARCHAR(50))				AS [CentreOrStation]
	,CAST(ISNULL(d.[display],'Unknown') AS VARCHAR(50))				AS [District]
	,u.[id]															AS [EBATRolePlayerID]
	,CAST(u.[name] AS VARCHAR(50))									AS [FirstName]
	,CAST(
		CASE
			WHEN ISNULL([id_number],'') = '' THEN 'Unknown'
			ELSE [id_number]
		END  AS VARCHAR(20))										AS [IDNumber]
	,CAST(ISNULL([infrastructure_number],'Unknown') AS VARCHAR(50))	AS [InfrastructureNumber]
	,CAST(ISNULL([ebat_operator_display],'No') AS VARCHAR(50))		AS [IsOperator]
	,CAST('Unknown' AS VARCHAR(20))									AS [MobileNumber]
	,CAST(ISNULL(m.[display],'Unknown') AS VARCHAR(50))				AS [Municipality]
	,CAST(ISNULL(p.[display],'Unknown') AS VARCHAR(50))				AS [Province]
	,CAST([role_display] AS VARCHAR(10))							AS [RankOrRole]
	,CAST(ISNULL([surname],'Unknown') AS VARCHAR(50))				AS [Surname]
FROM [WCG_Stage].[ebat].[user] u WITH (NOLOCK)
LEFT OUTER JOIN [ebat].[centre] as c on u.centre_id = c.[id]
LEFT OUTER JOIN [ebat].[municipality] as m on c.municipality_id = m.[id]
LEFT OUTER JOIN [ebat].[district] as d on m.district_id = d.[id]
LEFT OUTER JOIN [ebat].[province] as p on d.province_id = p.[id]
LEFT OUTER JOIN [ebat].[regional_area] as r on c.regional_area_id = r.[id]
LEFT OUTER JOIN [ebat].[authority] as a on r.authority_id = a.[id]














