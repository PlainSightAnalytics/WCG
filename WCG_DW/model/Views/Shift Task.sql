
CREATE VIEW [model].[Shift Task] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   28 Oct 2018 1:35:42 PM
-- Reason               :   Semantic View for dbo.DimShiftTask
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ShiftTaskKey] AS [ShiftTaskKey]
	,[Measurement] AS [Measurement]
	,[MeasurementPeriod] AS [Measurement Period]
	,[MeasurementUnit] AS [Measurement Unit]
	,[ShiftTask] AS [Shift Task]
	,[ShiftTaskID] AS [Shift Task ID]
	,[ShiftTaskType] AS [Shift Task Type]
FROM WCG_DW.dbo.DimShiftTask WITH (NOLOCK)
