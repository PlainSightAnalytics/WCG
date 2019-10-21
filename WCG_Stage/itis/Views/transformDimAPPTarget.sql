





CREATE VIEW [itis].[transformDimAPPTarget] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Transform view for APP Target
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 [id]										AS [APPTargetGUID]
	,[description]								AS [APPTarget]
	,ISNULL(status_display,'Closed')			AS [OpenClosedStatus]
	,DeltaLogKey								AS [DeltaLogKey]
FROM [WCG_Stage].[itis].[app_target]












