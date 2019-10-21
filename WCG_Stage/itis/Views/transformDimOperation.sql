





CREATE VIEW [itis].[transformDimOperation] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	05-01-2019
-- Reason				:	Transform view for DimOperation
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	14-09-2019
-- Reason				:	Increase size of Operation Sub Type to cater for multiple values
--						:   New Fields (ASODRoadSection, AuthorisationDate, BriefingDoneBy, DebriefingDoneBy, IsDistrictSafetyPlan, 
--										IsRoadSafetyQualitySurvey, SightingVehicleRegistratonNo)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 CAST(
		CAST(actual_operation_start_time AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)														AS [ActualStartTime]
	,CAST(
		CAST(actual_operation_stop_time AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)														AS [ActualStopTime]
	,CAST(approval_comment AS VARCHAR(1000))								AS [ApprovalComment]
	,CAST(
		CAST(approval_date AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)														AS [ApprovalDate]
	,CAST(ISNULL(a.display,'Not Applicable') AS VARCHAR(50))				AS [ASODRoadSection]
	,CAST(
		CAST(authorization_date AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)														AS [AuthorisationDate]
	,CAST(ISNULL(bu.display,'Unknown') AS VARCHAR(50))						AS [BriefingDoneBy]
	,CAST(reason_for_cancelation AS VARCHAR(100))							AS [CancellationReason]
	,CAST(completion_comment AS VARCHAR(1000))								AS [CompletionComment]
	,CAST(ISNULL(du.display,'Unknown') AS VARCHAR(50))						AS [DebriefingDoneBy]
	,CAST(ISNULL(o.dsp_operation_display,'No') AS VARCHAR(3))				AS [IsDistrictSafetyPlan]
	,CAST(ISNULL(o.rtqs_display,'No') AS VARCHAR(3))						AS [IsRoadSafetyQualitySurvey]
	,CAST(COALESCE(s.display,o.other_location,'Unknown') AS VARCHAR(100))	AS [Location]
	,CAST(ISNULL(oo.display,'Unknown') AS VARCHAR(100))						AS [OperationalOfficer]
	,CAST(ISNULL(general_type_display,'Unknown') AS VARCHAR(50))			AS [OperationType]
	,CAST(
		COALESCE(
			roadblock_type_display, 
			speed_operation_type_display,
			weigh_operation_type_display,
			'Unknown') AS VARCHAR(200))										AS [OperationSubType]
	,CAST(ISNULL(description,'Unknown') AS VARCHAR(100))					AS [OperationDescription]
	,o.id																	AS [OperationID]
	,CAST(ISNULL(o.status_display,'Unknown') AS VARCHAR(30))				AS [OperationStatus]
	,CAST(
		CAST(start_time AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)														AS [PlannedStartTime]
	,CAST(
		CAST(stop_time AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)														AS [PlannedStopTime]
	,CAST(ISNULL(p.display,'Unknown') AS VARCHAR(100))						AS [Planner]
	,CAST(ISNULL(vu.display,'Not Applicable') AS VARCHAR(50))				AS [SightingVehicleRegistrationNo]
	,CAST(ISNULL(t.display,'Unknown') AS VARCHAR(50))						AS [TrafficCentre]
	,o.DeltaLogKey															AS [DeltalogKey]
FROM itis.[operation] o					WITH (NOLOCK)
LEFT JOIN itis.[site] s					WITH (NOLOCK) ON o.location_id = s.id
LEFT JOIN itis.[user] oo				WITH (NOLOCK) ON o.operational_officer_id = oo.id
LEFT JOIN itis.[user] p					WITH (NOLOCK) ON o.planner_id = p.id
LEFT JOIN itis.[traffic_centre] t		WITH (NOLOCK) ON o.traffic_centre_id = t.id
LEFT JOIN itis.[asod_road_section] a	WITH (NOLOCK) ON o.asod_road_section_id = a.id
LEFT JOIN itis.[user] bu				WITH (NOLOCK) ON o.briefing_done_by_id = bu.id
LEFT JOIN itis.[user] du				WITH (NOLOCK) ON o.debriefing_done_by_id = du.id
LEFT JOIN itis.[user] vu				WITH (NOLOCK) ON o.vehicle_used_id = vu.id

