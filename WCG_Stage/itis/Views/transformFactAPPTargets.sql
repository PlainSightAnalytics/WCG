
CREATE VIEW [itis].[transformFactAPPTargets] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Transform view for FactAPPTargets
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 app_target_id							AS APPTargetGUID
	,traffic_centre_id						AS TrafficCentreGUID
	,EOMONTH(DATEFROMPARTS(year,number,1))	AS TargetDate
	,a.id									AS UniqueGUID
	,adjusted_target						AS AdjustedTarget
	,target									AS Target
	,a.DeltaLogKey							AS DeltaLogKey
FROM WCG_Stage.itis.[app_actual] a WITH (NOLOCK)
LEFT JOIN WCG_Stage.itis.[calendar_month] c ON a.calendar_month_id = c.id



