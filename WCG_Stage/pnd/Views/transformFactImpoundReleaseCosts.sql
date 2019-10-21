




CREATE VIEW [pnd].[transformFactImpoundReleaseCosts] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	03-02-2019
-- Reason				:	Transform view for FactImpoundReleaseCosts
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH ImpoundInstructionCTE AS (
SELECT
	 ii.id
	,CAST(COALESCE(ii.created_at,ii.date_released) AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS CreateDate
	,ii.driver_id_number
	,ii.impound_officer_id
	,ii.impound_id
	,ii.vehicle_registration
	,i.traffic_centre_id
	,ROW_NUMBER() OVER (PARTITION BY ii.id ORDER BY ii.updated_at DESC) AS RowSequence
FROM [WCG_Stage].[pnd].[impound_instruction] ii WITH (NOLOCK)
LEFT JOIN [WCG_Stage].[pnd].[impound] i WITH (NOLOCK) ON ii.impound_id = i.id
)

SELECT
	 amount_paid					AS [AmountPaid]
	,CAST(CreateDate AS DATE)		AS [CreateDate]
	,ii.driver_id_number			AS [IDDocumentNumber]
	,rc.impound_instruction_id		AS [ImpoundInstructionID]
	,ii.impound_officer_id			AS [ImpoundJourneyUserID]
	,CAST(
		CASE
			WHEN DATEPART(HOUR, CreateDate) < 6 
				THEN DATEADD(DAY,-1,CreateDate)
			ELSE CreateDate 
	 END AS DATE)					AS [OperationsDate]
	,ii.impound_id					AS [PoundFacilityID]
	,ii.vehicle_registration		AS [RegistrationNo]
	,rc.description					AS [ReleaseDescription]
	,rc.status_display				AS [ReleaseStatus]
	,ii.traffic_centre_id			AS [TrafficCentreID]
	,rc.id							AS [UniqueID]
	,rc.DeltaLogKey					as [DeltaLogKey]
FROM [WCG_Stage].[pnd].[release_criteria] rc WITH (NOLOCK)
LEFT JOIN ImpoundInstructionCTE ii ON rc.impound_instruction_id = ii.id AND RowSequence = 1

