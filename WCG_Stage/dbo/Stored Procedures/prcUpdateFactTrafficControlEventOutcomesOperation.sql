CREATE PROCEDURE [dbo].[prcUpdateFactTrafficControlEventOutcomesOperation]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-01-2019
-- Reason				:	Updates FactTrafficControlEventOutcomes with Operation based on time and officials involved
--							in the TCE
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcUpdateFactTrafficControlEventOutcomesOperation] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT

AS

WITH cte AS (
SELECT
	 o.OperationID									AS OperationId
	,o.OperationKey									AS OperationKey
	,ISNULL(o.ActualStartTime,o.PlannedStartTime)	AS FromTime
	,ISNULL(o.ActualStopTime,o.PlannedStopTime)		AS ToTime
	,f.user_id										AS OfficialID
from WCG_DW.dbo.DimOperation o WITH (NOLOCK)
inner join WCG_STAGE.itis.officials_involved_in_operation f on o.OperationID = f.operation_id
)

UPDATE f
SET OperationKey = cte.OperationKey
--SELECT f.*, cte.*
FROM WCG_DW.dbo.FactTrafficControlEventOutcomes f
LEFT JOIN WCG_DW.dbo.DimUser d1 ON f.UserKey = d1.UserKey
LEFT JOIN WCG_DW.dbo.DimDate d2 ON f.UpdatedDateKey = d2.DateKey
LEFT JOIN WCG_DW.dbo.DimTime d3 ON f.UpdatedTimeKey = d3.TimeKey
INNER JOIN cte on d1.UserID = cte.OfficialID and CAST(d2.FullDate AS DATETIME) + CAST(d3.FullTime AS DATETIME) between cte.FromTime and cte.ToTime