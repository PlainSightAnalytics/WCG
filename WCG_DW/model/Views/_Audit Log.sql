

CREATE VIEW [model].[_Audit Log] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   23-12-2019
-- Reason               :   Semantic View for dbo.DimAuditLog
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

WITH CTE AS (
SELECT
	 AuditKey
	,DateTimeStart
	,DateTimeStop
	,RowCountInitial
	,RowCountFinal
	,RowCountInsert
	,TableName
	,ScriptName
	,CASE
		WHEN TableName LIKE 'Dim%' OR TableName LIKE 'Fact%' THEN 'dbo'
		ELSE SchemaName 
	END AS SchemaName
FROM WCG_DW.dbo.DimAudit
)

SELECT 
	 FORMAT(DateTimeStart,'yyyyMMdd') AS StartDateKey
	,FORMAT(DateTimeStart,'HHmm') AS StartTimeKey
	,ISNULL(o1.ObjectKey,-1) AS ExecuteObjectKey
	,ISNULL(o2.ObjectKey,-1) AS LoadObjectKey
	,a.AuditKey
	,DateTimeStart
	,DateTimeStop
	,RowCountInitial
	,RowCountFinal
	,RowCountInsert
FROM CTE a
LEFT JOIN WCG_DW.dbo.DimObject o1 ON a.ScriptName = o1.ObjectName
LEFT JOIN WCG_DW.dbo.DimObject o2 ON a.TableName = o2.ObjectName AND a.SchemaName = o2.SchemaName AND o2.ObjectType IN ('Stage Table','Dimension Table','Fact Table')