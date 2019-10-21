



CREATE VIEW [ebat].[transformDimMagistratesCourt] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	12-08-2106
-- Reason				:	Transform view for DimMagistratesCourt
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 [id]											AS [MagistratesCourtID]
	,CAST(REPLACE([name], '''','') AS VARCHAR(50))	AS [MagistratesCourt]
FROM [WCG_Stage].[ebat].[magistrates_court] WITH (NOLOCK)










