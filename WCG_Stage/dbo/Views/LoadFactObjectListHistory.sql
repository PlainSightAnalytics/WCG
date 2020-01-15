CREATE VIEW [dbo].[LoadFactObjectListHistory] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-12-2019
-- Reason				:	Load view for FactObjectListHistory
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 ISNULL(d2.DateKey,-1)								AS CreateDateKey
	,ISNULL(d3.DateKey,-1)								AS LastModifiedDateKey
	,ISNULL(d1.ObjectKey,-1)							AS ObjectKey
	,conf.LastModifiedDateTime							AS LastModifiedDateTime
FROM WCG_Stage.dbo.ConformDimObject conf
LEFT JOIN WCG_DW.dbo.DimObject d1 ON conf.ObjectFullName = d1.ObjectFullName
LEFT JOIN WCG_DW.dbo.DimDate d2 ON CAST(conf.CreateDateTime AS DATE) = d2.FullDate
LEFT JOIN WCG_DW.dbo.DimDate d3 ON CAST(conf.LastModifiedDateTime AS DATE) = d3.FullDate