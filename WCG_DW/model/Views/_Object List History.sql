
CREATE VIEW [model].[_Object List History] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   23 Dec 2019 10:47:54 AM
-- Reason               :   Semantic View for dbo.FactObjectListHistory
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [CreateDateKey] AS [CreateDateKey]
	,[LastModifiedDateKey] AS [LastModifiedDateKey]
	,[ObjectKey] AS [ObjectKey]
	,[IsCurrent] AS [Is Current]
	,[LastModifiedDateTime] AS [Last Modified Date Time]
FROM WCG_DW.dbo.FactObjectListHistory WITH (NOLOCK)