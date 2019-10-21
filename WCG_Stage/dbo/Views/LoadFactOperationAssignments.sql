

CREATE VIEW [dbo].[LoadFactOperationAssignments] 

AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	13-01-2019
-- Reason				:	Load view for FactOperationAssignments
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.[DateKey],-1)				AS OperationDateKey
	,ISNULL(d2.[OperationKey],-1)			AS OperationKey
	,ISNULL(d3.[DateKey],-1)				AS OperationsDateKey
	,ISNULL(d4.[TrafficCentreKey],-1)		AS TrafficCentreKey
	,ISNULL(d5.[UserKey],-1)				AS UserKey
	,tfm.UniqueID							AS UniqueID
	,tfm.[DeltaLogKey]						AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactOperationAssignments] tfm
LEFT JOIN [WCG_DW].[dbo].[DimDate]				d1 ON tfm.OperationDate = d1.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimOperation]			d2 ON tfm.OperationID = d2.OperationID
LEFT JOIN [WCG_DW].[dbo].[DimDate]				d3 ON tfm.OperationsDate = d3.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]		d4 ON tfm.TrafficCentreID = d4.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimUser]				d5 ON tfm.UserID = d5.UserID















