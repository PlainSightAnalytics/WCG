


CREATE VIEW [ebat].[transformDimEBATIncident] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-10-2017
-- Reason				:	Transform view for EBAT Incident
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(ISNULL([accident_display],'No') AS VARCHAR(3))							AS [AccidentIndicator]
	,CAST(ISNULL([accident_location],'Unknown') AS VARCHAR(50))						AS [AccidentLocation]
    ,CAST(ISNULL([cas_number],'Unknown') AS VARCHAR(20))							AS [CaseNumber]
	,[id]																			AS [EBATReportId]
	,CAST(ISNULL([status_display],'Unknown') AS VARCHAR(20))						AS [EBATStatus]
	,CAST(ISNULL([nature_of_injuries_display],'Unknown') AS VARCHAR(20))			AS [NatureOfInjuries]
	,CAST(ISNULL([not_successful_reason],'Unknown') AS VARCHAR(50))					AS [NotSuccessfulReason]
	,CAST(ISNULL([number_of_vehicles],0) AS INT)									AS [NumberOfVehicles]
	,CAST(ISNULL([protocol_number],'UNK') AS VARCHAR(10))							AS [ProtocolNumber]
	,CASE
		WHEN ISNULL([reading],'') = '' THEN 0
		ELSE CAST(replace([reading],'o',0) AS NUMERIC(19,2))
	END																				AS [ReadingResult]
	,CAST(ISNULL([result_display],'Unknown') AS VARCHAR(20))						AS [ReadingResultCategory]
	,CAST(ISNULL([record_number],'UNK') AS VARCHAR(20))								AS [RecordNumber]
	,CAST(ISNULL([referred_display],'No') AS VARCHAR(3))							AS [ReferredIndicator]
	,CAST(ISNULL([referred_location],'Unknown') AS VARCHAR(50))						AS [ReferredLocation]
	,CAST(ISNULL([referred_type_display],'Unknown') AS VARCHAR(20))					AS [ReferredType]
	,CAST(ISNULL([roadside_activity_display],'Unknown') AS VARCHAR(50))				AS [RoadSideActivity]
	,CAST([subject_date_of_birth] AS DATE)											AS [SubjectDateOfBirth]
	,CAST([subject_full_name] AS VARCHAR(50))										AS [SubjectFirstName]
	,CAST([subject_gender_display] AS VARCHAR(20))									AS [SubjectGender]
	,CAST(ISNULL([subject_id_number],'Unknown') AS VARCHAR(20))						AS [SubjectIdentificationNumber]
	,CAST(ISNULL([subject_identification_type_display],'Unknown') AS VARCHAR(30))	AS [SubjectIdentificationType]
	,CAST(ISNULL([subject_initials],'Unknown') AS VARCHAR(10))						AS [SubjectInitials]
	,CAST(ISNULL([subject_occupation_sector_display],'Unknown') AS VARCHAR(50))		AS [SubjectOccupationSector]
	,CAST(ISNULL([subject_surname],'Unknown') AS VARCHAR(50))						AS [SubjectSurname]
	,CAST(ISNULL([subject_tel_no],'Unknown') AS VARCHAR(15))						AS [SubjectTelephoneNumber]
	,CAST(ISNULL([vehicle_colour],'Unknown') AS VARCHAR(20))						AS [VehicleColour]
	,CAST(ISNULL([vehicle_make],'Unknown') AS VARCHAR(20))							AS [VehicleMake]
	,CAST(ISNULL([vehicle_registration_number],'Unknown') AS VARCHAR(20))			AS [VehicleRegistrationNumber]
	,CAST(ISNULL([vehicle_type_display],'Unknown') AS VARCHAR(20))					AS [VehicleType]
	,DeltaLogKey																	AS [DeltaLogKey]
FROM [WCG_Stage].[ebat].[ebat_report] 





















