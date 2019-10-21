
CREATE VIEW [model].[Operation] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   14 Sep 2019 12:07:14 PM
-- Reason               :   Semantic View for dbo.DimOperation
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [OperationKey] AS [OperationKey]
	,[ActualStartTime] AS [Actual Start Time]
	,[ActualStopTime] AS [Actual Stop Time]
	,[ApprovalComment] AS [Approval Comment]
	,[ApprovalDate] AS [Approval Date]
	,[ASODRoadSection] AS [ASOD Road Section]
	,[AuthorisationDate] AS [Authorisation Date]
	,[BriefingDoneBy] AS [Briefing Done By]
	,[CancellationReason] AS [Cancellation Reason]
	,[CompletionComment] AS [Completion Comment]
	,[DebriefingDoneBy] AS [Debriefing Done By]
	,[IsDistrictSafetyPlan] AS [Is District Safety Plan]
	,[IsRoadSafetyQualitySurvey] AS [Is Road Safety Quality Survey]
	,[Location] AS [Location]
	,[OperationalOfficer] AS [Operational Officer]
	,[OperationDescription] AS [Operation Description]
	,[OperationID] AS [Operation ID]
	,[OperationStatus] AS [Operation Status]
	,[OperationSubType] AS [Operation Sub Type]
	,[OperationType] AS [Operation Type]
	,[PlannedStartTime] AS [Planned Start Time]
	,[PlannedStopTime] AS [Planned Stop Time]
	,[Planner] AS [Planner]
	,[SightingVehicleRegistrationNo] AS [Sighting Vehicle Registration No]
	,[TrafficCentre] AS [Traffic Centre]
FROM WCG_DW.dbo.DimOperation WITH (NOLOCK)
