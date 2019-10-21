
CREATE PROCEDURE [dbo].[prcLoadDimOperation]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	05-01-2019
-- Reason				:	Performs SCD Logic for DimOperation using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimOperation] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   Trevor Howe
-- Modified On			:   14-09-2019
-- Reason				:   New Fields (ASODRoadSection, AuthorisationDate, BriefingDoneBy, DebriefingDoneBy, IsDistrictSafetyPlan, 
--										IsRoadSafetyQualitySurvey, SightingVehicleRegistratonNo)
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT = -1

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
	 ActualStartTime
	,ActualStopTime
	,ApprovalComment
	,ApprovalDate
	,ASODRoadSection
	,AuthorisationDate
	,BriefingDoneBy
	,CancellationReason
	,CompletionComment
	,DebriefingDoneBy
	,IsDistrictSafetyPlan
	,IsRoadSafetyQualitySurvey
	,Location
	,OperationalOfficer
	,OperationType
	,OperationSubType
	,OperationDescription
	,OperationID
	,OperationStatus
	,PlannedStartTime
	,PlannedStopTime
	,Planner
	,SightingVehicleRegistrationNo
	,TrafficCentre
FROM WCG_STAGE.itis.transformDimOperation
WHERE Deltalogkey = @DeltaLogKey
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimOperation dim
USING conf
ON (dim.OperationID = conf.OperationID)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 ActualStartTime
			,ActualStopTime
			,ApprovalComment
			,ApprovalDate
			,ASODRoadSection
			,AuthorisationDate
			,BriefingDoneBy
			,CancellationReason
			,CompletionComment
			,DebriefingDoneBy
			,IsDistrictSafetyPlan
			,IsRoadSafetyQualitySurvey
			,Location
			,OperationalOfficer
			,OperationType
			,OperationSubType
			,OperationDescription
			,OperationID
			,OperationStatus
			,PlannedStartTime
			,PlannedStopTime
			,Planner
			,SightingVehicleRegistrationNo
			,TrafficCentre
			,InsertAuditKey
			,UpdateAuditKey
			)
	VALUES (
			 ActualStartTime
			,ActualStopTime
			,ApprovalComment
			,ApprovalDate
			,ASODRoadSection
			,AuthorisationDate
			,BriefingDoneBy
			,CancellationReason
			,CompletionComment
			,DebriefingDoneBy
			,IsDistrictSafetyPlan
			,IsRoadSafetyQualitySurvey
			,Location
			,OperationalOfficer
			,OperationType
			,OperationSubType
			,OperationDescription
			,OperationID
			,OperationStatus
			,PlannedStartTime
			,PlannedStopTime
			,Planner
			,SightingVehicleRegistrationNo
			,TrafficCentre
			,@AuditKey
			,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
			   ISNULL(dim.ActualStartTime,'')			<> ISNULL(conf.ActualStartTime,'')
			OR ISNULL(dim.ActualStopTime,'')			<> ISNULL(conf.ActualStopTime,'')
			OR ISNULL(dim.ApprovalComment,'')			<> ISNULL(conf.ApprovalComment,'')
			OR ISNULL(dim.ApprovalDate,'')				<> ISNULL(conf.ApprovalDate,'')
			OR dim.ASODRoadSection						<> conf.ASODRoadSection
			OR ISNULL(dim.AuthorisationDate,'')			<> ISNULL(conf.AuthorisationDate,'')
			OR dim.BriefingDoneBy						<> conf.BriefingDoneBy
			OR ISNULL(dim.CancellationReason,'')		<> ISNULL(conf.CancellationReason,'')
			OR ISNULL(dim.CompletionComment,'')			<> ISNULL(conf.CompletionComment,'')
			OR dim.DebriefingDoneBy						<> conf.DebriefingDoneBy
			OR dim.IsDistrictSafetyPlan					<> conf.IsDistrictSafetyPlan
			OR dim.IsRoadSafetyQualitySurvey			<> conf.IsRoadSafetyQualitySurvey
			OR dim.Location								<> conf.Location
			OR dim.OperationalOfficer					<> conf.OperationalOfficer
			OR dim.OperationType						<> conf.OperationType
			OR dim.OperationSubType						<> conf.OperationSubType
			OR dim.OperationDescription					<> conf.OperationDescription
			OR dim.OperationStatus						<> conf.OperationStatus
			OR ISNULL(dim.PlannedStartTime,'')			<> ISNULL(conf.PlannedStartTime,'')
			OR ISNULL(dim.PlannedStopTime,'')			<> ISNULL(conf.PlannedStopTime,'')
			OR dim.Planner								<> conf.Planner
			OR dim.SightingVehicleRegistrationNo		<> conf.SightingVehicleRegistrationNo
			OR dim.TrafficCentre						<> conf.TrafficCentre
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.ActualStartTime							= conf.ActualStartTime,
			dim.ActualStopTime							= conf.ActualStopTime,
			dim.ApprovalComment							= conf.ApprovalComment,
			dim.ApprovalDate							= conf.ApprovalDate,
			dim.ASODRoadSection							= conf.ASODRoadSection,
			dim.AuthorisationDate						= conf.AuthorisationDate,
			dim.BriefingDoneBy							= conf.BriefingDoneBy,
			dim.CancellationReason						= conf.CancellationReason,
			dim.CompletionComment						= conf.CompletionComment,
			dim.DebriefingDoneBy						= conf.DebriefingDoneBy,
			dim.IsDistrictSafetyPlan					= conf.IsDistrictSafetyPlan,
			dim.IsRoadSafetyQualitySurvey				= conf.IsRoadSafetyQualitySurvey,
			dim.Location								= conf.Location,
			dim.OperationalOfficer						= conf.OperationalOfficer,
			dim.OperationType							= conf.OperationType,
			dim.OperationSubType						= conf.OperationSubType,
			dim.OperationDescription					= conf.OperationDescription,
			dim.OperationStatus							= conf.OperationStatus,
			dim.PlannedStartTime						= conf.PlannedStartTime,
			dim.PlannedStopTime							= conf.PlannedStopTime,
			dim.Planner									= conf.Planner,
			dim.SightingVehicleRegistrationNo			= conf.SightingVehicleRegistrationNo,
			dim.TrafficCentre							= conf.TrafficCentre,
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimOperation




;
;
;

;
