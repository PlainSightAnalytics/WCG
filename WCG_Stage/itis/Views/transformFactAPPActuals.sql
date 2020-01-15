


CREATE VIEW [itis].[transformFactAPPActuals] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Transform view for FactAPPActuals
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	18-08-2018
-- Reason				:	Added Comments (Combined TC and Verifier comments into one field)
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	07-02-2020
-- Reason				:	Replaced source for PreliminaryActual (was preliminary_actual now preliminary_actual_total)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 app_target_id							AS APPTargetGUID
	,traffic_centre_id						AS TrafficCentreGUID
	,EOMONTH(DATEFROMPARTS(year,number,1))	AS ActualDate
	,a.id									AS UniqueGUID
	,preliminary_actual_total				AS PreliminaryActual
	,verified_actual						AS VerifiedActual
	,NULLIF(CONCAT(
		a.tc_comment
		,CASE
			WHEN a.tc_comment IS NULL THEN NULL
			ELSE ' (TC)'
		END
		,CASE
			WHEN a.verifier_comment IS NULL THEN NULL
			ELSE ', '
		END
		,a.verifier_comment
		,CASE
			WHEN a.verifier_comment IS NULL THEN NULL
			ELSE ' (V)'
		END
	),'')										AS Comments
	,a.DeltaLogKey							AS DeltaLogKey
FROM WCG_Stage.itis.[app_actual] a WITH (NOLOCK)
LEFT JOIN WCG_Stage.itis.[calendar_month] c WITH (NOLOCK) ON a.calendar_month_id = c.id

