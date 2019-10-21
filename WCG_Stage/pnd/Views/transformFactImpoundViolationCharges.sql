


CREATE VIEW [pnd].[transformFactImpoundViolationCharges] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	03-02-2019
-- Reason				:	Transform view for FactImpoundViolationCharges
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH ImpoundInstructionCTE AS (
SELECT
	 ii.id
	,ii.created_at
	,ii.driver_id_number
	,ii.impound_officer_id
	,ii.impound_id
	,ii.vehicle_registration
	,i.traffic_centre_id
	,ROW_NUMBER() OVER (PARTITION BY ii.id ORDER BY ii.updated_at DESC) AS RowSequence
FROM [WCG_Stage].[pnd].[impound_instruction] ii WITH (NOLOCK)
LEFT JOIN [WCG_Stage].[pnd].[impound] i WITH (NOLOCK) ON ii.impound_id = i.id
)

,CTE AS (
SELECT
	 COALESCE(v.created_at,ii.created_at)					AS [CreateDate]
	,ii.driver_id_number									AS [IDDocumentNumber]	
	,v.impound_instruction_id								AS [ImpoundInstructionID]
	,ii.impound_officer_id									AS [ImpoundJourneyUserID]
	,ii.impound_id											AS [PoundFacilityID]
	,ii.vehicle_registration								AS [RegistrationNo]
	,ii.traffic_centre_id									AS [TrafficCentreID]
	,v.id													AS [UniqueID]
	,cc.id													AS [ViolationCodeID]
	,v.DeltaLogKey											AS [DeltaLogKey]
FROM [WCG_Stage].[pnd].[violation] v WITH (NOLOCK)
LEFT JOIN ImpoundInstructionCTE ii WITH (NOLOCK) ON v.impound_instruction_id = ii.id AND ii.RowSequence = 1
LEFT JOIN [WCG_Stage].[itis].[charge_code] cc WITH (NOLOCK) ON v.violation_code = cc.charge_code
)

SELECT
	 CAST(
		CAST(
			[CreateDate] AS DATETIMEOFFSET) 
				AT TIME ZONE 'South Africa Standard Time' AS DATE)					AS [CreateDate]
	,[IDDocumentNumber]																AS [IDDocumentNumber]	
	,[ImpoundInstructionID]															AS [ImpoundInstructionID]
	,[ImpoundJourneyUserID]															AS [ImpoundJourneyUserID]
	,CAST(
		CASE
			WHEN DATEPART(HOUR, CAST([CreateDate] 
					AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time') < 6 
				THEN DATEADD(DAY,-1,CAST([CreateDate] 
					AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time')
			ELSE CAST([CreateDate] 
				AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' 
	 END AS DATE)																	AS [OperationsDate]
	,[PoundFacilityID]																AS [PoundFacilityID]
	,[RegistrationNo]																AS [RegistrationNo]
	,[TrafficCentreID]																AS [TrafficCentreID]
	,[UniqueID]																		AS [UniqueID]
	,[ViolationCodeID]																AS [ViolationCodeID]
	,[DeltaLogKey]																	AS [DeltaLogKey]
FROM CTE


