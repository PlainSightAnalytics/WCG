
CREATE VIEW [model].[Script] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   20 Dec 2019 9:19:36 AM
-- Reason               :   Semantic View for dbo.DimScript
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ScriptKey] AS [ScriptKey]
	,[IsParentScript] AS [Is Parent Script]
	,[ParentScriptName] AS [Parent Script Name]
	,[ScriptName] AS [Script Name]
	,[ScriptOrder] AS [Script Order]
FROM WCG_DW.dbo.DimScript WITH (NOLOCK)