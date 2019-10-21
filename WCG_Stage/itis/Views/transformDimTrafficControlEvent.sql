






--USE [WCG_Stage]
--GO

--/****** Object:  View [itis].[transformDimTrafficControlEvent]    Script Date: 24 Apr 2019 2:07:43 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO












CREATE VIEW [itis].[transformDimTrafficControlEvent] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	07-05-2018
-- Reason				:	Transform view for TrafficControlEvent
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	26-08-2018
-- Reason				:	Fixed Date Time fields (added 2h for RSA time)
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	03-02-2019
-- Reason				:	Added new fields (DeparturePoint, Destination, ExpectedDurationMinutes, HasImpoundViolations, 
--											  ImpoundOffenceDateTime, Location, TravelDirection, IsPublicTansportSurveyCompleted, TripType
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	10-07-2019
-- Reason				:	Converted Date fields to GMT+2 (SA Time)
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	13-09-2019
-- Reason				:	Added new fields (EMSRepresentative, LandSafetySurveyRepresentative, RoadSafetyRepresentative)
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	07-10-2019
-- Reason				:	1. Changed Departure and Destination to refer to municipality instead of departure_point and fme_destination
--							2. Brought in additional text fields for location when a site has not been linked, then text fields are used
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 CAST(ISNULL(action_taken_display,'None') AS VARCHAR(50))					AS [ActionTaken]
	,CAST(ISNULL(alcohol_level,'N/A') AS VARCHAR(10))							AS [AlcoholLevel]
	,CAST(ISNULL(alcohol_screening_display,'') AS VARCHAR(30))					AS [AlcoholScreening]
	,CAST(
		CAST(completed_at AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [EventCompletionDateTime]
	,CAST(
		CAST(opened_at AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [EventOpenDateTime]
	,CAST(ISNULL(event_source_display,'Unknown') AS VARCHAR(50))				AS [EventSource]
	,CAST(ISNULL(force_close_reason,'Not Forced Closed') AS VARCHAR(50))		AS [ForcedCloseReason]
	,CAST(ISNULL(force_closed_type_display,'Not Applicable') AS VARCHAR(50))	AS [ForcedCloseType]
    ,CAST(CASE 
		WHEN [alcohol_and_drugs_key]=1 THEN 'Yes' 
		ELSE 'No' 
	END	AS VARCHAR(3))															AS [HasAlcoholAndDrugs]
	,CAST(CASE 
		WHEN [disregard_instructions_key]=1 THEN 'Yes' 
		ELSE 'No' 
	END	AS VARCHAR(3))															AS [HasDisregardedInstructions]
	,CAST(CASE 
		WHEN [driving_violations_key]=1 THEN 'Yes' 
		ELSE 'No' 
	END	AS VARCHAR(3))															AS [HasDrivingViolations]
	,CAST(ISNULL([has_moving_violation_display],'No') AS VARCHAR(3))			AS [HasMovingViolations]
	,CAST(ISNULL([has_no_ag_violations_display],'No') AS VARCHAR(3))			AS [HasNoAGViolations]
	,CAST(CASE
		WHEN [regulatory_signs_key]=1 THEN 'Yes' 
		ELSE 'No' 
	END	AS VARCHAR(3))															AS [HasRegulatorySigns]
	,CAST(CASE 
		WHEN [road_markings_key]=1 THEN 'Yes' 
		ELSE 'No' 
	END	AS VARCHAR(3))															AS [HasRoadMarkings]
	,CAST(CASE 
		WHEN [speed_violations_key]=1 THEN 'Yes' 
		ELSE 'No' 
	END	AS VARCHAR(3))															AS [HasSpeedViolations]
	,CAST(ISNULL([has_violation_display],'No') AS VARCHAR(3))					AS [HasViolation]
	,CAST(ISNULL([reviewed_enatis_feedback_display],'No') AS VARCHAR(3))		AS [IsEnatisFeedbackReviewed]
	,CAST(ISNULL(e.[gps_location_latitude],0) AS NUMERIC(19,5))					AS [Latitude]
	,CAST(ISNULL(e.[gps_location_longitude],0) AS NUMERIC(19,5))				AS [Longitude]
	,CAST(ISNULL(LTRIM([police_station]),'None') AS VARCHAR(50))				AS [PoliceStation]
	,CAST([status_display] AS VARCHAR(30))										AS [StatusCode]
	,e.id																		AS [TrafficControlEventGUID]
	,e.DeltaLogKey																AS [DeltaLogKey]
	-- 03/02/2019 - New Fields - Impoundment and Persons for Reward
	,CAST(COALESCE(dpm.name,dp.display,'Unknown') AS VARCHAR(50))				AS [DeparturePoint]
	,CAST(COALESCE(dm.name,fd.display,'Unknown') AS VARCHAR(50))				AS [Destination]
	,CAST(ISNULL(e.google_expected_duration_minutes,0.00) AS NUMERIC(11,2))		AS [ExpectedDurationMinutes]
	,CAST(ISNULL(has_impound_violations_display,'No') AS VARCHAR(3))			AS [HasImpoundViolations]
	,CAST(
		CASE
			WHEN SUBSTRING(datetime_impound_offence,1,3) IN ('Mon','Tue','Wed','Thu','Fri','Sat','Sun') 
				THEN SUBSTRING(datetime_impound_offence,4,20)
			ELSE datetime_impound_offence
		END AS DATETIME) 														AS [ImpoundOffenceDateTime]
	,CAST(COALESCE(s.location_name,e.location_name, 'Unknown') AS VARCHAR(50))	AS [Location]
	,CAST(ISNULL(e.direction_display,'Unknown') AS VARCHAR(20))					AS [TravelDirection]
	-- 06/04/2019 - New Fields - Road Safety, EMS, Land Management
	,CAST(arrival_time AS DATETIME)												AS [ArrivalTime]
	,CAST(blood_glucose_level AS NUMERIC(11,2))									AS [BloodGlucoseLevel]
	,CAST(blood_pressure_diastolic AS NUMERIC(11,2))							AS [BloodPressureDiastolic]
	,CAST(blood_pressure_systolic AS NUMERIC(11,2))								AS [BloodPressureSystolic]
	,CAST(ISNULL(break_taken_display,'No') AS VARCHAR(3))						AS [IsBrakeTaken]
	,CAST(ISNULL(public_transport_survey_completed_display,'No') AS VARCHAR(3))	AS [IsPublicTransportSurveyCompleted]
	,CAST(departure_time AS DATETIME) 											AS [DepartureTime]
	,CAST(ems_result_comments AS VARCHAR(1000))									AS [EMSComments]
	,CAST(
		CASE ems_testing_display
			WHEN 'No' THEN 'Not Tested'
			WHEN 'Yes' THEN 'Tested'
			WHEN 'Refuse' THEN 'Refused to Test'
			ELSE 'Not Tested'
		END AS VARCHAR(20))														AS [EMSTestingStatus]
	,CAST(heart_rate AS NUMERIC(11,2))											AS [HeartRate]
	,CAST(
		CONVERT(NUMERIC(11,2),
			ISNULL(number_of_passengers,0)
		) AS INT)																AS [NumberOfPassengers]
	,CAST(
		CONVERT(NUMERIC(11,2),
			ISNULL(number_of_people_wearing_seat_belts,0)
		) AS INT)																AS [NumberOfPeopleWearingSeatbelts]
	,CAST(place_brake_taken AS VARCHAR(50))										AS [BrakeTakenLocation]
	,CAST(road_safety_comments AS VARCHAR(1000))								AS [RoadSafetyComments]
	,CAST(
		CAST(road_safety_completed AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)															AS [RoadSafetyCompletedDateTime]
	,CAST(ISNULL(trip_type_display,'Not Recorded') AS VARCHAR(20))				AS [TripType]
	-- 13/09/2019 - New Fields - EMSRepresentative, LandTransportSurveyRepresentative, RoadSafetyRepresentative
	,CAST(ISNULL(eu.display,'Not Applicable') AS VARCHAR(50))					AS [EMSRepresentative]
	,CAST(ISNULL(lu.display,'Not Applicable') AS VARCHAR(50))					AS [LandTransportSurveyRepresentative]
	,CAST(ISNULL(ru.display,'Not Applicable') AS VARCHAR(50))					AS [RoadSafetyRepresentative]
FROM WCG_Stage.itis.[event] e WITH (NOLOCK)
LEFT JOIN WCG_Stage.itis.departure_point dp WITH (NOLOCK) ON e.departure_point_id = dp.id
LEFT JOIN WCG_Stage.itis.fme_destination fd WITH (NOLOCK) ON e.fme_destination_id = fd.id
LEFT JOIN WCG_Stage.itis.municipality dpm WITH (NOLOCK) ON e.departure_point_id = dpm.id
LEFT JOIN WCG_Stage.itis.municipality dm WITH (NOLOCK) ON e.fme_destination_id = dm.id
LEFT JOIN WCG_Stage.itis.[site] s WITH (NOLOCK) ON e.site_id = s.id
LEFT JOIN WCG_Stage.itis.[user] eu WITH (NOLOCK) ON e.ems_user_id = eu.id
LEFT JOIN WCG_Stage.itis.[user] lu WITH (NOLOCK) ON e.land_transport_survey_user_id = lu.id
LEFT JOIN WCG_Stage.itis.[user] ru WITH (NOLOCK) ON e.road_safety_user_id = ru.id







