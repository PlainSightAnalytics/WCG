
CREATE VIEW [model].[Magistrates Court] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimMagistratesCourt
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [MagistratesCourtKey] AS [MagistratesCourtKey]
	,[MagistratesCourt] AS [Magistrates Court]
	,[MagistratesCourtID] AS [Magistrates Court ID]
FROM WCG_DW.dbo.DimMagistratesCourt WITH (NOLOCK)
