
CREATE VIEW [model].[DeltaLog]

AS

------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   09-09-2018
-- Reason               :   Model view for dbo.DeltaLog
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT 
	 DeltaLogKey
	,UPPER(CAST(ClientName AS VARCHAR(10))) AS ClientName
	,CONVERT(INT,CONVERT(VARCHAR(10),LogDate,112)) AS DateKey
	,CONVERT(INT,CAST(REPLACE(CONVERT(TIME,LogDate,105),':','') AS VARCHAR(4))) AS TimeKey
	,SchemaName
	,ObjectName
	,LoadFlag
	,HighWaterDateTime
	,HighWaterMark
	,RowCountError
	,RowCountExcluded
	,RowCountInsert
	,RowCountSource
	,RowCountStage
	,RowCountUpdate
FROM dbo.DimDeltaLog WITH (NOLOCK)


