CREATE VIEW [meta].[transformDimScript] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-12-2019
-- Reason				:	Transform view for DimScript
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

WITH ParentScriptCTE AS (
SELECT
DISTINCT ParentScriptName
FROM meta.PSChildScripts WITH (NOLOCK)
)

SELECT
	  CAST(s.ScriptName AS VARCHAR(100))								AS ScriptName
	 ,CAST(ISNULL(c.ParentScriptName,'Stand Alone') AS VARCHAR(100))	AS ParentScriptName
	 ,ISNULL(c.ScriptOrder,0)											AS ScriptOrder
	 ,CASE
		WHEN p.ParentScriptName IS NOT NULL THEN 'Yes'
		ELSE 'No'
	 END										AS IsParentScript
FROM meta.PSScripts s WITH (NOLOCK)
LEFT JOIN Meta.PSChildScripts c WITH (NOLOCK) ON s.ScriptName = c.ChildScriptName
LEFT JOIN ParentScriptCTE p ON s.ScriptName = p.ParentScriptName