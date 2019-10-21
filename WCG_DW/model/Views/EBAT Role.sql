
CREATE VIEW [model].[EBAT Role] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimEBATRole
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [EBATRoleKey] AS [EBATRoleKey]
	,[EBATRole] AS [EBAT Role]
FROM WCG_DW.dbo.DimEBATRole WITH (NOLOCK)
