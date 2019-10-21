

CREATE PROCEDURE [dbo].[prcLoadDimEBATIncident]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-10-2017
-- Reason				:	Performs SCD Logic for DimEBATIncident using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimEBATIncident] -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
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
	 AccidentIndicator
	,AccidentLocation
	,CaseNumber
	,EBATReportId
	,EBATStatus
	,NatureOfInjuries
	,NotSuccessfulReason
	,NumberOfVehicles
	,ProtocolNumber
	,ReadingResult
	,ReadingResultCategory
	,RecordNumber
	,ReferredIndicator
	,ReferredLocation
	,ReferredType
	,RoadSideActivity
	,SubjectDateOfBirth
	,SubjectFirstName
	,SubjectGender
	,SubjectIdentificationNumber
	,SubjectIdentificationType
	,SubjectInitials
	,SubjectOccupationSector
	,SubjectSurname
	,SubjectTelephoneNumber
	,VehicleColour
	,VehicleMake
	,VehicleRegistrationNumber
	,VehicleType
FROM WCG_STAGE.ebat.transformDimEBATIncident
WHERE DeltaLogKey = @DeltaLogKey
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimEBATIncident dim
USING conf
ON (dim.EBATReportId = conf.EBATReportId)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		AccidentIndicator,AccidentLocation,CaseNumber,EBATReportId,EBATStatus,NatureOfInjuries,NotSuccessfulReason,NumberOfVehicles,
		ProtocolNumber,ReadingResult,ReadingResultCategory,RecordNumber,ReferredIndicator,ReferredLocation,ReferredType,RoadSideActivity,
		SubjectDateOfBirth,SubjectFirstName,SubjectGender,SubjectIdentificationNumber,SubjectIdentificationType,SubjectInitials,
		SubjectOccupationSector,SubjectSurname,SubjectTelephoneNumber,VehicleColour,VehicleMake,VehicleRegistrationNumber,VehicleType,
		InsertAuditKey, UpdateAuditKey
			)
	VALUES (
		conf.AccidentIndicator,conf.AccidentLocation,conf.CaseNumber,conf.EBATReportId,conf.EBATStatus,conf.NatureOfInjuries,conf.NotSuccessfulReason,
		conf.NumberOfVehicles,conf.ProtocolNumber,conf.ReadingResult,conf.ReadingResultCategory,conf.RecordNumber,conf.ReferredIndicator,
		conf.ReferredLocation,conf.ReferredType,conf.RoadSideActivity,conf.SubjectDateOfBirth,conf.SubjectFirstName,conf.SubjectGender,
		conf.SubjectIdentificationNumber,conf.SubjectIdentificationType,conf.SubjectInitials,conf.SubjectOccupationSector,conf.SubjectSurname,
		conf.SubjectTelephoneNumber,conf.VehicleColour,conf.VehicleMake,conf.VehicleRegistrationNumber,conf.VehicleType,@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (

		   dim.AccidentIndicator			   <> conf.AccidentIndicator
		OR dim.AccidentLocation				   <> conf.AccidentLocation
		OR dim.CaseNumber					   <> conf.CaseNumber
		OR dim.EBATStatus					   <> conf.EBATStatus
		OR dim.NatureOfInjuries				   <> conf.NatureOfInjuries
		OR dim.NotSuccessfulReason			   <> conf.NotSuccessfulReason
		OR dim.NumberOfVehicles				   <> conf.NumberOfVehicles
		OR dim.ProtocolNumber				   <> conf.ProtocolNumber
		OR dim.ReadingResult				   <> conf.ReadingResult
		OR dim.ReadingResultCategory		   <> conf.ReadingResultCategory
		OR dim.RecordNumber					   <> conf.RecordNumber
		OR dim.ReferredIndicator			   <> conf.ReferredIndicator
		OR dim.ReferredLocation				   <> conf.ReferredLocation
		OR dim.ReferredType					   <> conf.ReferredType
		OR dim.RoadSideActivity				   <> conf.RoadSideActivity
		OR dim.SubjectDateOfBirth			   <> conf.SubjectDateOfBirth
		OR dim.SubjectFirstName				   <> conf.SubjectFirstName
		OR dim.SubjectGender				   <> conf.SubjectGender
		OR dim.SubjectIdentificationNumber	   <> conf.SubjectIdentificationNumber
		OR dim.SubjectIdentificationType	   <> conf.SubjectIdentificationType
		OR dim.SubjectInitials				   <> conf.SubjectInitials
		OR dim.SubjectOccupationSector		   <> conf.SubjectOccupationSector
		OR dim.SubjectSurname				   <> conf.SubjectSurname
		OR dim.SubjectTelephoneNumber		   <> conf.SubjectTelephoneNumber
		OR dim.VehicleColour				   <> conf.VehicleColour
		OR dim.VehicleMake					   <> conf.VehicleMake
		OR dim.VehicleRegistrationNumber	   <> conf.VehicleRegistrationNumber
		OR dim.VehicleType					   <> conf.VehicleType

		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */

			dim.AccidentIndicator			   = conf.AccidentIndicator,
			dim.AccidentLocation			   = conf.AccidentLocation,
			dim.CaseNumber					   = conf.CaseNumber,
			dim.EBATStatus					   = conf.EBATStatus,
			dim.NatureOfInjuries			   = conf.NatureOfInjuries,
			dim.NotSuccessfulReason			   = conf.NotSuccessfulReason,
			dim.NumberOfVehicles			   = conf.NumberOfVehicles,
			dim.ProtocolNumber				   = conf.ProtocolNumber,
			dim.ReadingResult				   = conf.ReadingResult,
			dim.ReadingResultCategory		   = conf.ReadingResultCategory,
			dim.RecordNumber				   = conf.RecordNumber,
			dim.ReferredIndicator			   = conf.ReferredIndicator,
			dim.ReferredLocation			   = conf.ReferredLocation,
			dim.ReferredType				   = conf.ReferredType,
			dim.RoadSideActivity			   = conf.RoadSideActivity,
			dim.SubjectDateOfBirth			   = conf.SubjectDateOfBirth,
			dim.SubjectFirstName			   = conf.SubjectFirstName,
			dim.SubjectGender				   = conf.SubjectGender,
			dim.SubjectIdentificationNumber	   = conf.SubjectIdentificationNumber,
			dim.SubjectIdentificationType	   = conf.SubjectIdentificationType,
			dim.SubjectInitials				   = conf.SubjectInitials,
			dim.SubjectOccupationSector		   = conf.SubjectOccupationSector,
			dim.SubjectSurname				   = conf.SubjectSurname,
			dim.SubjectTelephoneNumber		   = conf.SubjectTelephoneNumber,
			dim.VehicleColour				   = conf.VehicleColour,
			dim.VehicleMake					   = conf.VehicleMake,
			dim.VehicleRegistrationNumber	   = conf.VehicleRegistrationNumber,
			dim.VehicleType					   = conf.VehicleType,
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.ebat.transformDimOfficer





