CREATE VIEW [model].[_Delta Log] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   23-12-2019
-- Reason               :   Semantic View for dbo.DimDeltaLog
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT
	 FORMAT(d.LogDate,'yyyyMMdd') AS LogDateKey
	,FORMAT(d.LogDate,'HHmm') AS LogTimeKey
	,ISNULL(o.ObjectKey,-1) AS DeltaObjectKey
	,d.DeltaLogKey
	,d.LoadFlag
	,d.HighWaterDateTime
	,RowCountSource
	,RowCountStage
	,RowCountInsert
	,RowCountUpdate
	,RowCountError
	,RowCountExcluded
FROM WCG_DW.dbo.DimDeltaLog d
LEFT JOIN WCG_DW.dbo.DimObject o ON d.SchemaName = o.SchemaName AND d.ObjectName = o.ObjectName