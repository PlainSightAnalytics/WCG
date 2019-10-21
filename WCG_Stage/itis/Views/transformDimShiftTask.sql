CREATE VIEW [itis].[transformDimShiftTask] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-10-2018
-- Reason				:	Transform view for DimShiftTask
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 CAST(ISNULL(t.description,'Unknown') AS VARCHAR(50))			AS ShiftTask
	,t.id															AS ShiftTaskID
	,CAST(ISNULL(t.measure,0) AS NUMERIC(19,2))						AS Measurement
	,CAST(ISNULL(t.period,'Unknown') AS VARCHAR(30))				AS MeasurementPeriod
	,CAST(ISNULL(t.task_type_display,'Unknown') AS VARCHAR(30))		AS ShiftTaskType
	,CAST(ISNULL(t.unit,'Unknown') AS VARCHAR(30))					AS MeasurementUnit
	,t.DeltaLogKey													AS DeltaLogKey
FROM itis.task_description t


