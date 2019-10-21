
CREATE VIEW [model].[Traffic Control Event] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   13 Sep 2019 2:02:25 PM
-- Reason               :   Semantic View for dbo.DimTrafficControlEvent
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [TrafficControlEventKey] AS [TrafficControlEventKey]
	,[ActionTaken] AS [Action Taken]
	,[AlcoholLevel] AS [Alcohol Level]
	,[AlcoholScreening] AS [Alcohol Screening]
	,[ArrivalTime] AS [Arrival Time]
	,[BloodGlucoseLevel] AS [Blood Glucose Level]
	,[BloodPressureDiastolic] AS [Blood Pressure Diastolic]
	,[BloodPressureSystolic] AS [Blood Pressure Systolic]
	,[BrakeTakenLocation] AS [Brake Taken Location]
	,[DeparturePoint] AS [Departure Point]
	,[DepartureTime] AS [Departure Time]
	,[Destination] AS [Destination]
	,[EMSComments] AS [EMS Comments]
	,[EMSRepresentative] AS [EMS Representitive]
	,[EMSTestingStatus] AS [EMS Testing Status]
	,[EventCompletionDateTime] AS [Event Completion Date Time]
	,[EventOpenDateTime] AS [Event Open Date Time]
	,[EventSource] AS [Event Source]
	,[ExpectedDurationMinutes] AS [Expected Duration Minutes]
	,[ForcedCloseReason] AS [Forced Close Reason]
	,[ForcedCloseType] AS [Forced Close Type]
	,[HasAlcoholAndDrugs] AS [Has Alcohol And Drugs]
	,[HasDisregardedInstructions] AS [Has Disregarded Instructions]
	,[HasDrivingViolations] AS [Has Driving Violations]
	,[HasImpoundViolations] AS [Has Impound Violations]
	,[HasMovingViolations] AS [Has Moving Violations]
	,[HasNoAGViolations] AS [Has No A G Violations]
	,[HasRegulatorySigns] AS [Has Regulatory Signs]
	,[HasRoadMarkings] AS [Has Road Markings]
	,[HasSpeedViolations] AS [Has Speed Violations]
	,[HasViolation] AS [Has Violation]
	,[HeartRate] AS [Heart Rate]
	,[ImpoundOffenceDateTime] AS [Impound Offence Date Time]
	,[IsBrakeTaken] AS [Is Brake Taken]
	,[IsEnatisFeedbackReviewed] AS [Is Enatis Feedback Reviewed]
	,[IsPublicTransportSurveyCompleted] AS [Is Public Transport Survey Completed]
	,[LandTransportSurveyRepresentative] AS [Land Transport Survey Representative]
	,[Latitude] AS [Latitude]
	,[Location] AS [Location]
	,[Longitude] AS [Longitude]
	,[NumberOfPassengers] AS [Number Of Passengers]
	,[NumberOfPeopleWearingSeatbelts] AS [Number Of People Wearing Seatbelts]
	,[PoliceStation] AS [Police Station]
	,[RoadSafetyComments] AS [Road Safety Comments]
	,[RoadSafetyCompletedDateTime] AS [Road Safety Completed Date Time]
	,[RoadSafetyRepresentative] AS [Road Safety Representative]
	,[StatusCode] AS [Status Code]
	,[TrafficControlEventGUID] AS [Traffic Control Event GUID]
	,[TravelDirection] AS [Travel Direction]
	,[TripType] AS [Trip Type]
FROM WCG_DW.dbo.DimTrafficControlEvent WITH (NOLOCK)
