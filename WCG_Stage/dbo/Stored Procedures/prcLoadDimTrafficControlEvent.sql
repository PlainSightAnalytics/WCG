


CREATE PROCEDURE [dbo].[prcLoadDimTrafficControlEvent]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	05-05-2018
-- Reason				:	Performs SCD Logic for DimTrafficControlEvent using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimTrafficControlEvent] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   Trevor Howe
-- Modified On			:   06-02-2019
-- Reason				:   New fields (ImpoundOffenceDateTime, DeparturePoint, TravelDirection, Destination, ExpectedDurationMinutes
--										HasImpoundViolations, Location, IsPublicSurveyCompleted, TripType
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT

AS

SET FMTONLY OFF
SET NOCOUNT ON

DECLARE
@RowCountInsert INT,
@RowCountUpdate INT,
@RowCountExtract INT

DECLARE @RowCounts TABLE
(mergeAction varchar(10));

WITH conf AS (
SELECT
	 [ActionTaken]
	,[AlcoholLevel]
	,[AlcoholScreening]
	,[EventCompletionDateTime]
	,[EventOpenDateTime]
	,[EventSource]
	,[ForcedCloseReason]
	,[ForcedCloseType]
	,[HasAlcoholAndDrugs]
	,[HasDisregardedInstructions]
	,[HasDrivingViolations]
	,[HasMovingViolations]
	,[HasNoAGViolations]
	,[HasRegulatorySigns]
	,[HasRoadMarkings]
	,[HasSpeedViolations]
	,[HasViolation]
	,[IsEnatisFeedbackReviewed]
	,[Latitude]
	,[Longitude]
	,[PoliceStation]
	,[StatusCode]
	,[TrafficControlEventGUID]
	-- New fields 06-02-2019
	,[ImpoundOffenceDateTime]
	,[DeparturePoint]
	,[TravelDirection]
	,[Destination]
	,[ExpectedDurationMinutes]
	,[HasImpoundViolations]
	,[Location]
	-- 06/04/2019 - New Fields - Road Safety, EMS, Land Management
	,[ArrivalTime]
	,[BloodGlucoseLevel]
	,[BloodPressureDiastolic]
	,[BloodPressureSystolic]
	,[IsBrakeTaken]
	,[IsPublicTransportSurveyCompleted]
	,[DepartureTime]
	,[EMSComments]
	,[EMSTestingStatus]
	,[HeartRate]
	,[NumberOfPassengers]
	,[NumberOfPeopleWearingSeatbelts]
	,[BrakeTakenLocation]
	,[RoadSafetyComments]
	,[RoadSafetyCompletedDateTime]
	,[TripType]
	-- 13/09/2019 - New Fields - EMSRepresentative, LandTransportSurveyRepresentative, RoadSafetyRepresentative
	,[EMSRepresentative]
	,[LandTransportSurveyRepresentative]
	,[RoadSafetyRepresentative]
FROM WCG_STAGE.itis.transformDimTrafficControlEvent
WHERE DeltaLogKey = @DeltaLogKey
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimTrafficControlEvent dim
USING conf
ON (dim.[TrafficControlEventGUID] = conf.[TrafficControlEventGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 [ActionTaken]
		,[AlcoholLevel]
		,[AlcoholScreening]
		,[EventCompletionDateTime]
		,[EventOpenDateTime]
		,[EventSource]
		,[ForcedCloseReason]
		,[ForcedCloseType]
		,[HasAlcoholAndDrugs]
		,[HasDisregardedInstructions]
		,[HasDrivingViolations]
		,[HasMovingViolations]
		,[HasNoAGViolations]
		,[HasRegulatorySigns]
		,[HasRoadMarkings]
		,[HasSpeedViolations]
		,[HasViolation]
		,[IsEnatisFeedbackReviewed]
		,[Latitude]
		,[Longitude]
		,[PoliceStation]
		,[StatusCode]
		,[TrafficControlEventGUID]
		-- New fields 06-02-2019
		,[ImpoundOffenceDateTime]
		,[DeparturePoint]
		,[TravelDirection]
		,[Destination]
		,[ExpectedDurationMinutes]
		,[HasImpoundViolations]
		,[Location]
		-- 06/04/2019 - New Fields - Road Safety, EMS, Land Management
		,[ArrivalTime]
		,[BloodGlucoseLevel]
		,[BloodPressureDiastolic]
		,[BloodPressureSystolic]
		,[IsBrakeTaken]
		,[IsPublicTransportSurveyCompleted]
		,[DepartureTime]
		,[EMSComments]
		,[EMSTestingStatus]
		,[HeartRate]
		,[NumberOfPassengers]
		,[NumberOfPeopleWearingSeatbelts]
		,[BrakeTakenLocation]
		,[RoadSafetyComments]
		,[RoadSafetyCompletedDateTime]
		,[TripType]
		-- 13/09/2019 - New Fields - EMSRepresentative, LandTransportSurveyRepresentative, RoadSafetyRepresentative
		,[EMSRepresentative]
		,[LandTransportSurveyRepresentative]
		,[RoadSafetyRepresentative]
		,[DeltaLogKey]
		,[InsertAuditKey]
		,[UpdateAuditKey]
	)
	VALUES (
		 conf.[ActionTaken]
		,conf.[AlcoholLevel]
		,conf.[AlcoholScreening]
		,conf.[EventCompletionDateTime]
		,conf.[EventOpenDateTime]
		,conf.[EventSource]
		,conf.[ForcedCloseReason]
		,conf.[ForcedCloseType]
		,conf.[HasAlcoholAndDrugs]
		,conf.[HasDisregardedInstructions]
		,conf.[HasDrivingViolations]
		,conf.[HasMovingViolations]
		,conf.[HasNoAGViolations]
		,conf.[HasRegulatorySigns]
		,conf.[HasRoadMarkings]
		,conf.[HasSpeedViolations]
		,conf.[HasViolation]
		,conf.[IsEnatisFeedbackReviewed]
		,conf.[Latitude]
		,conf.[Longitude]
		,conf.[PoliceStation]
		,conf.[StatusCode]
		,conf.[TrafficControlEventGUID]
		-- New fields 06-02-2019
		,conf.[ImpoundOffenceDateTime]
		,conf.[DeparturePoint]
		,conf.[TravelDirection]
		,conf.[Destination]
		,conf.[ExpectedDurationMinutes]
		,conf.[HasImpoundViolations]
		,conf.[Location]
		-- 06/04/2019 - New Fields - Road Safety, EMS, Land Management
		,conf.[ArrivalTime]
		,conf.[BloodGlucoseLevel]
		,conf.[BloodPressureDiastolic]
		,conf.[BloodPressureSystolic]
		,conf.[IsBrakeTaken]
		,conf.[IsPublicTransportSurveyCompleted]
		,conf.[DepartureTime]
		,conf.[EMSComments]
		,conf.[EMSTestingStatus]
		,conf.[HeartRate]
		,conf.[NumberOfPassengers]
		,conf.[NumberOfPeopleWearingSeatbelts]
		,conf.[BrakeTakenLocation]
		,conf.[RoadSafetyComments]
		,conf.[RoadSafetyCompletedDateTime]
		,conf.[TripType]
		-- 13/09/2019 - New Fields - EMSRepresentative, LandTransportSurveyRepresentative, RoadSafetyRepresentative
		,conf.[EMSRepresentative]
		,conf.[LandTransportSurveyRepresentative]
		,conf.[RoadSafetyRepresentative]
		,@DeltaLogKey
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[ActionTaken]								<> conf.[ActionTaken]
		OR dim.[AlcoholLevel]								<> conf.[AlcoholLevel]
		OR dim.[AlcoholScreening]							<> conf.[AlcoholScreening]
		OR ISNULL(dim.[EventCompletionDateTime],'')			<> ISNULL(conf.[EventCompletionDateTime],'')
		OR ISNULL(dim.[EventOpenDateTime],'')				<> ISNULL(conf.[EventOpenDateTime],'')
		OR dim.[EventSource]								<> conf.[EventSource]
		OR dim.[ForcedCloseReason]							<> conf.[ForcedCloseReason]
		OR dim.[ForcedCloseType]							<> conf.[ForcedCloseType]
		OR dim.[HasAlcoholAndDrugs]							<> conf.[HasAlcoholAndDrugs]
		OR dim.[HasDisregardedInstructions]					<> conf.[HasDisregardedInstructions]
		OR dim.[HasDrivingViolations]						<> conf.[HasDrivingViolations]
		OR dim.[HasMovingViolations]						<> conf.[HasMovingViolations]
		OR dim.[HasNoAGViolations]							<> conf.[HasNoAGViolations]
		OR dim.[HasRegulatorySigns]							<> conf.[HasRegulatorySigns]
		OR dim.[HasRoadMarkings]							<> conf.[HasRoadMarkings]
		OR dim.[HasSpeedViolations]							<> conf.[HasSpeedViolations]
		OR dim.[HasViolation]								<> conf.[HasViolation]
		OR dim.[IsEnatisFeedbackReviewed]					<> conf.[IsEnatisFeedbackReviewed]
		OR dim.[Latitude]									<> conf.[Latitude]
		OR dim.[Longitude]									<> conf.[Longitude]
		OR dim.[PoliceStation]								<> conf.[PoliceStation]
		OR dim.[StatusCode]									<> conf.[StatusCode]
		-- New fields 06-02-2019
		OR ISNULL(dim.[ImpoundOffenceDateTime],'')			<> ISNULL(conf.[ImpoundOffenceDateTime],'')
		OR dim.[DeparturePoint]								<> conf.[DeparturePoint]
		OR dim.[TravelDirection]							<> conf.[TravelDirection]
		OR dim.[Destination]								<> conf.[Destination]
		OR dim.[ExpectedDurationMinutes]					<> conf.[ExpectedDurationMinutes]
		OR dim.[HasImpoundViolations]						<> conf.[HasImpoundViolations]
		OR dim.[Location]									<> conf.[Location]
		-- 06/04/2019 - New Fields - Road Safety, EMS, Land Management
		OR dim.[ArrivalTime]								<> conf.[ArrivalTime]					
		OR dim.[BloodGlucoseLevel]							<> conf.[BloodGlucoseLevel]				
		OR dim.[BloodPressureDiastolic]						<> conf.[BloodPressureDiastolic]			
		OR dim.[BloodPressureSystolic]						<> conf.[BloodPressureSystolic]			
		OR dim.[IsBrakeTaken]								<> conf.[IsBrakeTaken]		
		OR dim.[IsPublicTransportSurveyCompleted]			<> conf.[IsPublicTransportSurveyCompleted]			
		OR dim.[DepartureTime]								<> conf.[DepartureTime]					
		OR dim.[EMSComments]								<> conf.[EMSComments]					
		OR dim.[EMSTestingStatus]							<> conf.[EMSTestingStatus]				
		OR dim.[HeartRate]									<> conf.[HeartRate]		
		OR ISNULL(dim.[NumberOfPassengers],'')				<> conf.[NumberOfPassengers]				
		OR ISNULL(dim.[NumberOfPeopleWearingSeatbelts],'')	<> conf.[NumberOfPeopleWearingSeatbelts]	
		OR dim.[BrakeTakenLocation]							<> conf.[BrakeTakenLocation]				
		OR dim.[RoadSafetyComments]							<> conf.[RoadSafetyComments]				
		OR dim.[RoadSafetyCompletedDateTime]				<> conf.[RoadSafetyCompletedDateTime]
		OR dim.[TripType]									<> conf.[TripType]	
		-- 13/09/2019 - New Fields - EMSRepresentative, LandTransportSurveyRepresentative, RoadSafetyRepresentative
		OR dim.[EMSRepresentative]							<> conf.[EMSRepresentative]
		OR dim.[LandTransportSurveyRepresentative]			<> conf.[LandTransportSurveyRepresentative]
		OR dim.[RoadSafetyRepresentative]					<> conf.[RoadSafetyRepresentative]

		) 	
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[ActionTaken]							= conf.[ActionTaken],
			dim.[AlcoholLevel]							= conf.[AlcoholLevel],
			dim.[AlcoholScreening]						= conf.[AlcoholScreening],
			dim.[EventCompletionDateTime]				= conf.[EventCompletionDateTime],
			dim.[EventOpenDateTime]						= conf.[EventOpenDateTime],
			dim.[EventSource]							= conf.[EventSource],
			dim.[ForcedCloseReason]						= conf.[ForcedCloseReason],
			dim.[ForcedCloseType]						= conf.[ForcedCloseType],
			dim.[HasAlcoholAndDrugs]					= conf.[HasAlcoholAndDrugs],
			dim.[HasDisregardedInstructions]			= conf.[HasDisregardedInstructions],
			dim.[HasDrivingViolations]					= conf.[HasDrivingViolations],
			dim.[HasMovingViolations]					= conf.[HasMovingViolations],
			dim.[HasNoAGViolations]						= conf.[HasNoAGViolations],
			dim.[HasRegulatorySigns]					= conf.[HasRegulatorySigns],
			dim.[HasRoadMarkings]						= conf.[HasRoadMarkings],
			dim.[HasSpeedViolations]					= conf.[HasSpeedViolations],
			dim.[HasViolation]							= conf.[HasViolation],
			dim.[IsEnatisFeedbackReviewed]				= conf.[IsEnatisFeedbackReviewed],
			dim.[Latitude]								= conf.[Latitude],
			dim.[Longitude]								= conf.[Longitude],
			dim.[PoliceStation]							= conf.[PoliceStation],
			dim.[StatusCode]							= conf.[StatusCode],
			-- New fields 06-02-2019
			dim.[ImpoundOffenceDateTime]				= conf.[ImpoundOffenceDateTime],
			dim.[DeparturePoint]						= conf.[DeparturePoint],
			dim.[TravelDirection]						= conf.[TravelDirection],
			dim.[Destination]							= conf.[Destination],
			dim.[ExpectedDurationMinutes]				= conf.[ExpectedDurationMinutes],
			dim.[HasImpoundViolations]					= conf.[HasImpoundViolations],
			dim.[Location]								= conf.[Location],		
			-- 06/04/2019 - New Fields - Road Safety, EMS, Land Management
			dim.[ArrivalTime]							= conf.[ArrivalTime],					
			dim.[BloodGlucoseLevel]						= conf.[BloodGlucoseLevel],				
			dim.[BloodPressureDiastolic]				= conf.[BloodPressureDiastolic],			
			dim.[BloodPressureSystolic]					= conf.[BloodPressureSystolic],			
			dim.[IsBrakeTaken]							= conf.[IsBrakeTaken],
			dim.[IsPublicTransportSurveyCompleted]		= conf.[IsPublicTransportSurveyCompleted],
			dim.[DepartureTime]							= conf.[DepartureTime],					
			dim.[EMSComments]							= conf.[EMSComments],					
			dim.[EMSTestingStatus]						= conf.[EMSTestingStatus],				
			dim.[HeartRate]								= conf.[HeartRate],	
			dim.[NumberOfPassengers]					= conf.[NumberOfPassengers],					
			dim.[NumberOfPeopleWearingSeatbelts]		= conf.[NumberOfPeopleWearingSeatbelts],	
			dim.[BrakeTakenLocation]					= conf.[BrakeTakenLocation],				
			dim.[RoadSafetyComments]					= conf.[RoadSafetyComments],				
			dim.[RoadSafetyCompletedDateTime]			= conf.[RoadSafetyCompletedDateTime],
			dim.[TripType]								= conf.[TripType],
		-- 13/09/2019 - New Fields - EMSRepresentative, LandTransportSurveyRepresentative, RoadSafetyRepresentative
			dim.[EMSRepresentative]						= conf.[EMSRepresentative],
			dim.[LandTransportSurveyRepresentative]		= conf.[LandTransportSurveyRepresentative],
			dim.[RoadSafetyRepresentative]				= conf.[RoadSafetyRepresentative],
			/* Update System Fields */
			dim.UpdateAuditKey = @AuditKey,
			dim.RowIsInferred = 'N',
			dim.RowChangeReason = 
			CASE 
				WHEN dim.RowIsInferred = 'Y' THEN 'Inferred Member Arrived'
				ELSE 'SCD Type 1 Change'
			END
OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimTrafficControlEvent WHERE DeltaLogKey = @DeltaLogKey




;
;
;

;
;


