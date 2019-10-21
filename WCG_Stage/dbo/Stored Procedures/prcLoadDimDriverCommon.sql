CREATE PROCEDURE [dbo].[prcLoadDimDriverCommon]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	04-02-2019
-- Reason				:	Performs SCD Logic for DimDriver using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey, @SchemaName
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimDriver] -1, -1, 'pnd'
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT = -1,
@SchemaName VARCHAR(10)

AS

SET FMTONLY OFF
SET NOCOUNT ON

DECLARE
@RowCountInsert INT,
@RowCountUpdate INT,
@RowCountExtract INT

DECLARE @RowCounts TABLE
(mergeAction varchar(10));

IF @SchemaName = 'pnd'
BEGIN

	/* Confrom View */
	WITH conf AS (
	SELECT
		 Gender
		,IDDocumentNo
		,IDDocumentType
		,Initials
		,LicenseExpiryDate
		,LicenseNumber
		,LicenseType
		,Surname
	FROM WCG_STAGE.pnd.transformDimDriver 
	WHERE DeltaLogKey = @DeltaLogKey
	AND RowSequence = 1
	)

	/* Handle SCD1 Changes */
	MERGE INTO WCG_DW.dbo.DimDriver dim
	USING conf 
	ON (dim.[IDDocumentNo] = conf.[IDDocumentNo] ) 
	WHEN NOT MATCHED THEN /* New Records */
		INSERT (
				 Gender
				,IDDocumentNo
				,IDDocumentType
				,Initials
				,LicenseExpiryDate
				,LicenseNumber
				,LicenseType
				,Surname
				,DeltaLogKey
				,InsertAuditKey
				,UpdateAuditKey
				)
		VALUES (
				 conf.Gender
				,conf.IDDocumentNo
				,conf.IDDocumentType
				,conf.Initials
				,conf.LicenseExpiryDate
				,conf.LicenseNumber
				,conf.LicenseType
				,conf.Surname
				,@DeltaLogKey
				,@AuditKey
				,@AuditKey
				)
		--WHEN MATCHED 
		--AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
		--AND (
		--		dim.DateOfBirth				<> conf.DateOfBirth
		--	OR	dim.Gender					<> conf.Gender
		--	OR	dim.IDDocumentNo			<> conf.IDDocumentNo
		--	OR	dim.IDDocumentType			<> conf.IDDocumentType
		--	OR	dim.Initials				<> conf.Initials
		--	OR	dim.LicenseType				<> conf.LicenseType
		--	OR	dim.LicenseExpiryDate		<> conf.LicenseExpiryDate
		--	OR	dim.LicenseFirstDate		<> conf.LicenseFirstDate
		--	OR	dim.Surname					<> conf.Surname
		--	) 	/* Check if any Type 1 Fields have changed */
		--THEN 
		--	UPDATE 
		--	SET 
		--		/* Update Type 1 Fields */
		--		dim.DateOfBirth				= conf.DateOfBirth,
		--		dim.Gender					= conf.Gender,
		--		dim.IDDocumentNo			= conf.IDDocumentNo,
		--		dim.IDDocumentType			= conf.IDDocumentType,
		--		dim.Initials				= conf.Initials,
		--		dim.LicenseType				= conf.LicenseType,
		--		dim.LicenseExpiryDate		= conf.LicenseExpiryDate,
		--		dim.LicenseFirstDate		= conf.LicenseFirstDate,
		--		dim.Surname					= conf.Surname,
		--		/* Update System Fields */
		--		dim.UpdateAuditKey = @AuditKey,
		--		dim.RowIsInferred = 'N',
		--		dim.RowChangeReason = 
		--			CASE 
		--				WHEN dim.RowIsInferred = 'Y' THEN 'Inferred Member Arrived'
		--				ELSE 'SCD Type 1 Change'
		--			END
	OUTPUT $action into @rowcounts;			

	SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
	SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
	SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.pnd.transformDimDriver WHERE DeltaLogKey = @DeltaLogKey AND RowSequence = 1

END


/* Update Delta Log */
--UPDATE WCG_DW.dbo.DimDeltaLog
--SET 
--	LoadFlag = 1, 
--	RowCountInsert = @RowCountInsert, 
--	UpdateAuditKey = @AuditKey
--WHERE DeltaLogKey = @DeltaLogKey;
