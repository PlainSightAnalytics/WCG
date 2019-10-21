

CREATE VIEW [itis].[transformDimShiftActivityType] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-10-2018
-- Reason				:	Transform view for DimShiftActivityType
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT
	 CAST(a.activity_type_key AS VARCHAR(10))			AS ShiftActivityTypeCode
	,CAST(a.activity_type_display AS VARCHAR(30))		AS ShiftActivityType
	,a.DeltaLogKey										AS DeltaLogKey
from itis.activity a	
WHERE activity_type_key IS NOT NULL	


