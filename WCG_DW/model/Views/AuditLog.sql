
CREATE VIEW [model].[AuditLog]

AS

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   27-08-2018
-- Reason               :   Model view for dbo.AuditLog
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT 
	 AuditKey AS AuditLogKey
	,UPPER(CAST(ClientName AS VARCHAR(10))) AS ClientName
	,CONVERT(INT,CONVERT(VARCHAR(10),DateTimeStart,112)) AS DateKey
	,CONVERT(INT,CAST(REPLACE(CONVERT(TIME,DateTimeStart,105),':','') AS VARCHAR(4))) AS TimeKey
	,DateTimeStart
	,DateTimeStop
	,RowCountError
	,RowCountFinal
	,RowCountInitial
	,RowCountUpdate
	,SchemaName
	,ScriptName
	,Successful
	,TableName
FROM dbo.DimAudit WITH (NOLOCK)
WHERE AuditKey <> -1

