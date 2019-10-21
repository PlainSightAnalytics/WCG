




CREATE VIEW [ebat].[transformDimOperator] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	12-08-2106
-- Reason				:	Transform view for DimOperator
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 u.[id]															AS [OperatorID]
	,CAST(u.[display] AS VARCHAR(50))								AS [Operator]
	,CAST(u.[name] AS VARCHAR(50))									AS [FirstName]
	,CAST(ISNULL([surname],'Unknown') AS VARCHAR(50))				AS [Surname]
	,CAST([role_display] AS VARCHAR(10))							AS [Role]
	,CAST(ISNULL([ebat_operator_display],'No') AS VARCHAR(50))		AS [IsOperator]
	,CAST(
		CASE
			WHEN ISNULL([id_number],'') = '' THEN 'Unknown'
			ELSE [id_number]
		END  AS VARCHAR(20))										AS [IDNumber]
	,CAST(ISNULL([infrastructure_number],'Unknown') AS VARCHAR(50))	AS [InfrastructureNumber]
	,CAST(ISNULL([operator_certificate],'Unknown') AS VARCHAR(50))	AS [OperatorCertificate]
	,CAST(ISNULL(c.[display],'Unknown') AS VARCHAR(50))				AS [Centre]
	,CAST(ISNULL(m.[display],'Unknown') AS VARCHAR(50))				AS [Municipality]
	,CAST(ISNULL(d.[display],'Unknown') AS VARCHAR(50))				AS [District]
	,CAST(ISNULL(p.[display],'Unknown') AS VARCHAR(50))				AS [Province]
	,CAST(ISNULL(r.[display],'Unknown') AS VARCHAR(50))				AS [RegionalArea]
	,CAST(ISNULL(a.[display],'Unknown') AS VARCHAR(50))				AS [Authority]
FROM [WCG_Stage].[ebat].[user] u WITH (NOLOCK)
LEFT OUTER JOIN [ebat].[centre] as c on u.centre_id = c.[id]
LEFT OUTER JOIN [ebat].[municipality] as m on c.municipality_id = m.[id]
LEFT OUTER JOIN [ebat].[district] as d on m.district_id = d.[id]
LEFT OUTER JOIN [ebat].[province] as p on d.province_id = p.[id]
LEFT OUTER JOIN [ebat].[regional_area] as r on c.regional_area_id = r.[id]
LEFT OUTER JOIN [ebat].[authority] as a on r.authority_id = a.[id]












