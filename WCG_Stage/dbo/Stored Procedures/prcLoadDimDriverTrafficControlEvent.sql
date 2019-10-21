CREATE PROCEDURE [dbo].[prcLoadDimDriverTrafficControlEvent]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	9 August 2016
-- Reason				:	Performs SCD Logic for DimVehicle using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimDriverTrafficControlEvent] -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
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
	 Country
	,DateOfBirth
	,Gender
	,IDDocumentNo
	,IDDocumentType
	,Initials
	,LicenseType
	,LicenseExpiryDate
	,LicenseFirstDate
	,Surname
FROM WCG_STAGE.itis.transformDimDriver 
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimDriver dim
USING conf 
ON (dim.[IDDocumentNo] = conf.[IDDocumentNo] ) 
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 Country
			,DateOfBirth
			,Gender
			,IDDocumentNo
			,IDDocumentType
			,Initials
			,LicenseType
			,LicenseExpiryDate
			,LicenseFirstDate
			,Surname
			,DeltaLogKey
			,InsertAuditKey
			,UpdateAuditKey
			)
	VALUES (
			 conf.Country
			,conf.DateOfBirth
			,conf.Gender
			,conf.IDDocumentNo
			,conf.IDDocumentType
			,conf.Initials
			,conf.LicenseType
			,conf.LicenseExpiryDate
			,conf.LicenseFirstDate
			,conf.Surname
			,@DeltaLogKey
			,@AuditKey
			,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
			dim.Country							<> conf.Country
		OR	ISNULL(dim.DateOfBirth,'')			<> ISNULL(conf.DateOfBirth,'')
		OR	dim.Gender							<> conf.Gender
		OR	dim.IDDocumentNo					<> conf.IDDocumentNo
		OR	dim.IDDocumentType					<> conf.IDDocumentType
		OR	dim.Initials						<> conf.Initials
		OR	dim.LicenseType						<> conf.LicenseType
		OR	ISNULL(dim.LicenseExpiryDate,'')	<> ISNULL(conf.LicenseExpiryDate,'')
		OR	ISNULL(dim.LicenseFirstDate,'')		<> ISNULL(conf.LicenseFirstDate,'')
		OR	dim.Surname					<> conf.Surname
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.Country					= conf.Country,
			dim.DateOfBirth				= conf.DateOfBirth,
			dim.Gender					= conf.Gender,
			dim.IDDocumentNo			= conf.IDDocumentNo,
			dim.IDDocumentType			= conf.IDDocumentType,
			dim.Initials				= conf.Initials,
			dim.LicenseType				= conf.LicenseType,
			dim.LicenseExpiryDate		= conf.LicenseExpiryDate,
			dim.LicenseFirstDate		= conf.LicenseFirstDate,
			dim.Surname					= conf.Surname,
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimDriver WHERE DeltaLogKey = @DeltaLogKey

/* Update Delta Log */
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey;
