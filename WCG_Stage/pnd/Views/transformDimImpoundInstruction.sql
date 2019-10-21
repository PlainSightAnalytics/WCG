





CREATE VIEW [pnd].[transformDimImpoundInstruction] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	03-02-2019
-- Reason				:	Transform view for DimImpoundInstruction
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	21-06-2019
-- Reason				:	Added NULL override (Unknown) for Violation Type
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	10-07-2019
-- Reason				:	Converted all dates to GMT+2 (SA Time)
--------------------------------------------------------------------------------------------------------------------------------------

WITH VehicleCTE AS (
	SELECT
		Id
		,CAST(COALESCE(license_number, vehicle_registration_number_captured) AS VARCHAR(20))	AS RegistrationNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)							AS RowSequence
	FROM [WCG_STAGE].[itis].[Vehicle] WITH (NOLOCK)
)

,TrafficControlEventCTE AS (
SELECT 
	 e.id
	,CAST(
		CASE
			WHEN SUBSTRING(datetime_impound_offence,1,3) IN ('Mon','Tue','Wed','Thu','Fri','Sat','Sun')
			THEN SUBSTRING(datetime_impound_offence,5,20)
		END AS DATETIME)								AS OffenceDate
	,v.RegistrationNo
	,u.display
	,ROW_NUMBER() OVER (PARTITION BY e.id ORDER BY e.updated_at DESC)	AS RowSequence
FROM [itis].[event] e			WITH (NOLOCK)
LEFT JOIN [itis].[user] u		WITH (NOLOCK) ON e.user_id = u.id
LEFT JOIN VehicleCTE v			WITH (NOLOCK) ON e.primary_vehicle_id = v.id
WHERE 
	datetime_impound_offence IS NOT NULL 
AND v.RegistrationNo IS NOT NULL
)

,ImpoundInstructionCTE AS (
SELECT 
	 CAST(
		CAST(created_at AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [CreateDate]
	,CAST(ISNULL(ii.jack_display,'No') AS VARCHAR(3))							AS [HasJack]
	,CAST(ISNULL(ii.spanners_display,'No') AS VARCHAR(3))						AS [HasSpanners]
	,CAST(ISNULL(ii.wheel_brace_display,'No') AS VARCHAR(3))					AS [HasWheelBrace]
	,CAST(
		CAST(date_impounded AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [ImpoundDate]
	,ii.id																		AS [ImpoundInstructionID]
	,CAST(	
		CASE	
			WHEN u.surname IS NULL THEN 'Unknown'
			ELSE CONCAT(u.surname,', ', u.name)
		END AS VARCHAR(50))														AS [ImpoundOfficer]
	,CAST(ii.status_display AS VARCHAR(50))										AS [ImpoundStatus]
	,CAST(
		CAST(incoming_impound_officer_signed_at AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [IncomingImpoundOfficerSignatureDate]
	,CAST(
		CAST(incoming_vehicle_owner_signed_at AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [IncomingVehicleOwnerSignatureDate]
	,CAST(ISNULL(ii.release_as_scrap_display,'No') AS VARCHAR(3))				AS [IsReleasedAsScrap]
	,CAST(ISNULL(ii.location,'Unknown') AS VARCHAR(50))							AS [Location]
	,ISNULL(ii.offence_count_key,0)												AS [OffenceCount]
	,CAST(
		CASE
			WHEN SUBSTRING(ii.date_of_offence,1,3) IN ('Mon','Tue','Wed','Thu','Fri','Sat','Sun')
			THEN SUBSTRING(ii.date_of_offence,5,20)
		END AS DATETIME)														AS [OffenceDate]
	,ISNULL(
		CAST(
			REPLACE(ii.offence_fine,'R','') AS NUMERIC(19,2))
			,0.00)																AS [OffenceFine]
	,CAST(ii.officer_comments AS VARCHAR(1000))									AS [OfficerComments]
	,CAST(
		CAST(outgoing_impound_officer_signed_at AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [OutgoingImpoundOfficerSignatureDate]
	,CAST(
		CAST(ii.outgoing_vehicle_owner_signed_at AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [OutgoingVehicleOwnerSignatureDate]
	,CAST(ii.override_reason AS VARCHAR(1000))									AS [OverrideReason]
	,CAST(ISNULL(i.name,'Unknown') AS VARCHAR(50))								AS [PoundFacility]
	,ii.vehicle_registration													AS [RegistrationNo]
	,CAST(
		CAST(ii.date_released AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [ReleaseDate]
	,CAST(ii.scrap_reason AS VARCHAR(1000))										AS [ScrapReason]
	,CAST(
		ISNULL(ii.violation_type_display,'Unknown') 
		AS VARCHAR(50))															AS [ViolationType]
	,CAST(ii.written_notice_number AS VARCHAR(50))								AS [WrittenNoticeNumber]
	,ii.DeltaLogKey																AS [DeltaLogKey]
FROM [WCG_Stage].[pnd].[impound_instruction] ii		WITH (NOLOCK)
LEFT JOIN [WCG_Stage].[pnd].[impound] i				WITH (NOLOCK) ON ii.impound_id = i.id
LEFT JOIN [WCG_Stage].[pnd].[user] u				WITH (NOLOCK) ON ii.impound_officer_id = u.id
)

SELECT
	 i.[CreateDate]
	,i.[HasJack]
	,i.[HasSpanners]
	,i.[HasWheelBrace]
	,i.[ImpoundDate]
	,i.[ImpoundInstructionID]
	,i.[ImpoundOfficer]
	,i.[ImpoundStatus]
	,i.[IncomingImpoundOfficerSignatureDate]
	,i.[IncomingVehicleOwnerSignatureDate]
	,i.[IsReleasedAsScrap]
	,i.[Location]
	,i.[OffenceCount]
	,i.[OffenceDate]
	,i.[OffenceFine]
	,i.[OfficerComments]
	,i.[OutgoingImpoundOfficerSignatureDate]
	,i.[OutgoingVehicleOwnerSignatureDate]
	,i.[OverrideReason]
	,i.[PoundFacility]
	,i.[ReleaseDate]
	,i.[ScrapReason]
	,CAST(ISNULL(e.display,'Unknown') AS VARCHAR(50)) AS [TrafficOfficer]
	,i.[ViolationType]
	,i.[WrittenNoticeNumber]
	,i.[DeltaLogKey]
FROM ImpoundInstructionCTE i
LEFT JOIN TrafficControlEventCTE e ON i.OffenceDate = e.OffenceDate AND i.RegistrationNo = e.RegistrationNo AND e.RowSequence = 1








