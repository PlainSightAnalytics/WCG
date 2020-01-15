
CREATE VIEW [model].[Object] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   23 Dec 2019 10:47:53 AM
-- Reason               :   Semantic View for dbo.DimObject
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ObjectKey] AS [ObjectKey]
	,[CreateDateTime] AS [Create Date Time]
	,[LastModifiedDateTime] AS [Last Modified Date Time]
	,[ObjectFullName] AS [Object Full Name]
	,[ObjectLocation] AS [Object Location]
	,[ObjectName] AS [Object Name]
	,[ObjectType] AS [Object Type]
	,[ObjectTypeOrder] AS [Object Type Order]
	,[ParentObject] AS [Parent Object]
	,[ParentObjectOrder] AS [Parent Object Order]
	,[SchemaName] AS [Schema Name]
FROM WCG_DW.dbo.DimObject WITH (NOLOCK)