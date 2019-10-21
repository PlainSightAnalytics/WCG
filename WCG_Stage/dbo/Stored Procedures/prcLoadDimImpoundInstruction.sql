CREATE PROCEDURE [dbo].[prcLoadDimImpoundInstruction]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	04-02-2019
-- Reason				:	Performs SCD Logic for DimImpoundInstruction using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimImpoundInstruction] -1
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
	 CreateDate
	,HasJack
	,HasSpanners
	,HasWheelBrace
	,ImpoundDate
	,ImpoundInstructionID
	,ImpoundOfficer
	,ImpoundStatus
	,IncomingImpoundOfficerSignatureDate
	,IncomingVehicleOwnerSignatureDate
	,IsReleasedAsScrap
	,Location
	,OffenceCount
	,OffenceDate
	,OffenceFine
	,OfficerComments
	,OutgoingImpoundOfficerSignatureDate
	,OutgoingVehicleOwnerSignatureDate
	,OverrideReason
	,PoundFacility
	,ReleaseDate
	,ScrapReason
	,TrafficOfficer
	,ViolationType
	,WrittenNoticeNumber
FROM WCG_STAGE.pnd.transformDimImpoundInstruction
WHERE DeltaLogKey = @DeltaLogKey
	)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimImpoundInstruction dim
USING conf
ON (dim.ImpoundInstructionID = conf.ImpoundInstructionID)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 CreateDate
		,HasJack
		,HasSpanners
		,HasWheelBrace
		,ImpoundDate
		,ImpoundInstructionID
		,ImpoundOfficer
		,ImpoundStatus
		,IncomingImpoundOfficerSignatureDate
		,IncomingVehicleOwnerSignatureDate
		,IsReleasedAsScrap
		,Location
		,OffenceCount
		,OffenceDate
		,OffenceFine
		,OfficerComments
		,OutgoingImpoundOfficerSignatureDate
		,OutgoingVehicleOwnerSignatureDate
		,OverrideReason
		,PoundFacility
		,ReleaseDate
		,ScrapReason
		,TrafficOfficer
		,ViolationType
		,WrittenNoticeNumber
		,DeltaLogKey
		,InsertAuditKey
		,UpdateAuditKey
			)
	VALUES (
		 conf.CreateDate
		,conf.HasJack
		,conf.HasSpanners
		,conf.HasWheelBrace
		,conf.ImpoundDate
		,conf.ImpoundInstructionID
		,conf.ImpoundOfficer
		,conf.ImpoundStatus
		,conf.IncomingImpoundOfficerSignatureDate
		,conf.IncomingVehicleOwnerSignatureDate
		,conf.IsReleasedAsScrap
		,conf.Location
		,conf.OffenceCount
		,conf.OffenceDate
		,conf.OffenceFine
		,conf.OfficerComments
		,conf.OutgoingImpoundOfficerSignatureDate
		,conf.OutgoingVehicleOwnerSignatureDate
		,conf.OverrideReason
		,conf.PoundFacility
		,conf.ReleaseDate
		,conf.ScrapReason
		,conf.TrafficOfficer
		,conf.ViolationType
		,conf.WrittenNoticeNumber
		,@DeltaLogKey
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (

			dim.CreateDate											<> conf.CreateDate
		OR	dim.HasJack												<> conf.HasJack
		OR	dim.HasSpanners											<> conf.HasSpanners
		OR	dim.HasWheelBrace										<> conf.HasWheelBrace
		OR	ISNULL(dim.ImpoundDate,'')								<> ISNULL(conf.ImpoundDate,'')
		OR	dim.ImpoundOfficer										<> conf.ImpoundOfficer
		OR	dim.ImpoundStatus										<> conf.ImpoundStatus
		OR	ISNULL(dim.IncomingImpoundOfficerSignatureDate,'')		<> ISNULL(conf.IncomingImpoundOfficerSignatureDate,'')
		OR	ISNULL(dim.IncomingVehicleOwnerSignatureDate,'')		<> ISNULL(conf.IncomingVehicleOwnerSignatureDate,'')
		OR	dim.IsReleasedAsScrap									<> conf.IsReleasedAsScrap
		OR	dim.Location											<> conf.Location
		OR	dim.OffenceCount										<> conf.OffenceCount
		OR	ISNULL(dim.OffenceDate,'')								<> ISNULL(conf.OffenceDate,'')
		OR	dim.OffenceFine											<> conf.OffenceFine
		OR	ISNULL(dim.OfficerComments,'')							<> ISNULL(conf.OfficerComments,'')
		OR	ISNULL(dim.OutgoingImpoundOfficerSignatureDate,'')		<> ISNULL(conf.OutgoingImpoundOfficerSignatureDate,'')
		OR	ISNULL(dim.OutgoingVehicleOwnerSignatureDate,'')		<> ISNULL(conf.OutgoingVehicleOwnerSignatureDate,'')
		OR	ISNULL(dim.OverrideReason,'')							<> ISNULL(conf.OverrideReason,'')
		OR	dim.PoundFacility										<> conf.PoundFacility
		OR	ISNULL(dim.ReleaseDate,'')								<> ISNULL(conf.ReleaseDate,'')
		OR	ISNULL(dim.ScrapReason,'')								<> ISNULL(conf.ScrapReason,'')
		OR	dim.TrafficOfficer										<> conf.TrafficOfficer
		OR	dim.ViolationType										<> conf.ViolationType
		OR	dim.WrittenNoticeNumber									<> conf.WrittenNoticeNumber

		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */

		 dim.CreateDate												= conf.CreateDate
		,dim.HasJack												= conf.HasJack
		,dim.HasSpanners											= conf.HasSpanners
		,dim.HasWheelBrace											= conf.HasWheelBrace
		,dim.ImpoundDate											= conf.ImpoundDate
		,dim.ImpoundInstructionID									= conf.ImpoundInstructionID
		,dim.ImpoundOfficer											= conf.ImpoundOfficer
		,dim.ImpoundStatus											= conf.ImpoundStatus
		,dim.IncomingImpoundOfficerSignatureDate					= conf.IncomingImpoundOfficerSignatureDate
		,dim.IncomingVehicleOwnerSignatureDate						= conf.IncomingVehicleOwnerSignatureDate
		,dim.IsReleasedAsScrap										= conf.IsReleasedAsScrap
		,dim.Location												= conf.Location
		,dim.OffenceCount											= conf.OffenceCount
		,dim.OffenceDate											= conf.OffenceDate
		,dim.OffenceFine											= conf.OffenceFine
		,dim.OfficerComments										= conf.OfficerComments
		,dim.OutgoingImpoundOfficerSignatureDate					= conf.OutgoingImpoundOfficerSignatureDate
		,dim.OutgoingVehicleOwnerSignatureDate						= conf.OutgoingVehicleOwnerSignatureDate
		,dim.OverrideReason											= conf.OverrideReason
		,dim.PoundFacility											= conf.PoundFacility
		,dim.ReleaseDate											= conf.ReleaseDate
		,dim.ScrapReason											= conf.ScrapReason
		,dim.TrafficOfficer											= conf.TrafficOfficer
		,dim.ViolationType											= conf.ViolationType
		,dim.WrittenNoticeNumber									= conf.WrittenNoticeNumber
		,dim.UpdateAuditKey											= @AuditKey
		,dim.RowIsInferred											= 'N'
		,dim.RowChangeReason										= 
				CASE 
					WHEN dim.RowIsInferred = 'Y' THEN 'Inferred Member Arrived'
					ELSE 'SCD Type 1 Change'
				END
OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.pnd.transformDimImpoundInstruction


