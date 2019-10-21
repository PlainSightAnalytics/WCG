
CREATE VIEW [dbo].[LoadFactPlannedOperations] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	13-04-2019
-- Reason				:	Load view for FactOperationAssignments
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	17-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 ISNULL(d1.[DateKey],-1)				AS PlannedDateKey
	,ISNULL(d2.[OperationKey],-1)			AS OperationKey
	,ISNULL(d3.[DateKey],-1)				AS OperationsDateKey
	,ISNULL(d4.[TrafficCentreKey],-1)		AS TrafficCentreKey
	,ISNULL(d5.[UserKey],-1)				AS PlannerUserKey
	,ISNULL(d6.[UserKey],-1)				AS OperationalOfficerUserKey
	,tfm.UniqueID							AS UniqueID
	,tfm.[DeltaLogKey]						AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactPlannedOperations] tfm
LEFT JOIN [WCG_DW].[dbo].[DimDate]				d1 ON tfm.PlannedDate = d1.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimOperation]			d2 ON tfm.OperationID = d2.OperationID
LEFT JOIN [WCG_DW].[dbo].[DimDate]				d3 ON tfm.PlannedDate = d3.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]		d4 ON tfm.TrafficCentreID = d4.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimUser]				d5 ON tfm.PlannerUserID = d5.UserID
LEFT JOIN [WCG_DW].[dbo].[DimUser]				d6 ON tfm.OperationalOfficerUserId = d6.UserID

