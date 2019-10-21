


CREATE VIEW [pnd].[transformFactImpoundEvents] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	03-02-2019
-- Reason				:	Transform view for FactImpoundEvents
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH CTE AS (
SELECT
	 driver_id_number																	AS [IDDocumentNumber]
	,CAST(created_at AS DATETIMEOFFSET)	AT TIME ZONE 'South Africa Standard Time'		AS [CREATED]
	,CAST(date_impounded AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard time'	AS [IMPOUNDED]
	,CAST(date_released AS DATETIMEOFFSET)	AT TIME ZONE 'South Africa Standard time'	AS [RELEASED]
	,ii.id																				AS [ImpoundInstructionID]
	,impound_officer_id																	AS [ImpoundUserID]
	,impound_id																			AS [PoundFacilityID]
	,vehicle_registration																AS [RegistrationNo]
	,i.traffic_centre_id																AS [TrafficCentreID]
	,ii.DeltaLogKey																		AS [DeltaLogKey]
FROM [WCG_Stage].[pnd].[impound_instruction] ii WITH (NOLOCK)
LEFT JOIN [WCG_Stage].[pnd].[impound] i			WITH (NOLOCK) ON ii.impound_id = i.id
)

SELECT 
	 [IDDocumentNumber]																	AS [IDDocumentNumber]
	,[ImpoundEvent]																		AS [ImpoundEvent]
	,CAST([ImpoundEventDateTime] AS DATETIME)											AS [ImpoundEventDateTime]
	,CAST([ImpoundEventDateTime] AS DATE)												AS [ImpoundEventDate]
	,CAST(SUBSTRING(CONVERT(VARCHAR(20),impoundEventDateTime,113),12,5) AS TIME)		AS [ImpoundEventTime]
	,CAST(
		CASE
			WHEN DATEPART(HOUR, ImpoundEventDateTime) < 6 
				THEN DATEADD(DAY,-1,ImpoundEventDateTime)
			ELSE ImpoundEventDateTime 
	 END AS DATE)																		AS [OperationsDate]
	,[ImpoundInstructionID]																AS [ImpoundInstructionID]
	,[ImpoundUserID]																	AS [ImpoundUserID]
	,[PoundFacilityID]																	AS [PoundFacilityID]
	,[RegistrationNo]																	AS [RegistrationNo]
	,[TrafficCentreID]																	AS [TrafficCentreID]
	,[DeltaLogKey]																		AS [DeltaLogKey]
FROM (
SELECT
	 [IDDocumentNumber]
	,[CREATED]
	,[IMPOUNDED]
	,[RELEASED]
	,[ImpoundInstructionID]
	,[ImpoundUserID]
	,[PoundFacilityID]
	,[RegistrationNo]
	,[TrafficCentreID]
	,[DeltaLogKey]
FROM CTE
) pvt
UNPIVOT  
   (ImpoundEventDateTime FOR ImpoundEvent IN   
      ([CREATED], [IMPOUNDED], [RELEASED])
) unpvt




