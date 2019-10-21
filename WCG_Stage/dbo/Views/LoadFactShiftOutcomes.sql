
CREATE VIEW [dbo].[LoadFactShiftOutcomes] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	28-10-2018
-- Reason				:	Load view for FactShiftOutcomes
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 ISNULL(d1.CriticalOutcomeTypeKey,-1)	AS CriticalOutcomeTypeKey
	,ISNULL(d2.DateKey,-1)					AS OperationsDateKey
	,ISNULL(d3.DateKey,-1)					AS ShiftDateKey
	,ISNULL(d4.ShiftKey,-1)					AS ShiftKey
	,ISNULL(d5.TrafficCentreKey,-1)			AS TrafficCentreKey
	,ISNULL(d6.UserKey,-1)					AS UserKey
	,tfm.IsStartedFillingIn					AS IsStartedFillingIn
	,tfm.UniqueID							AS UniqueID
	,tfm.VehicleCount						AS VehicleCount
	,tfm.DeltaLogKey						AS DeltaLogKey
FROM [WCG_Stage].[itis].[transformFactShiftOutcomes] tfm
LEFT JOIN [WCG_DW].[dbo].[DimCriticalOutcomeType]	d1	ON tfm.CriticalOutcomeMetricCode = d1.CriticalOutcomeMetricCode AND tfm.CriticalOutcomeTypeCode = d1.CriticalOutcomeTypeCode AND d1.VehicleType = tfm.VehicleType AND d1.IsSystemPopulated = tfm.IsSystemPopulated
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d2 ON tfm.OperationsDate = d2.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimDate]					d3 ON tfm.ShiftDate = d3.FullDate
LEFT JOIN [WCG_DW].[dbo].[DimShift]					d4 ON tfm.ShiftID = d4.ShiftID
LEFT JOIN [WCG_DW].[dbo].[DimTrafficCentre]			d5 ON tfm.TrafficCentreID = d5.TrafficCentreID
LEFT JOIN [WCG_DW].[dbo].[DimUser]					d6 ON tfm.UserID = d6.UserID








