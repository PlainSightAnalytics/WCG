
CREATE PROCEDURE [dbo].[prcLoadDimSection56Form]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-05-2018
-- Reason				:	Performs SCD Logic for DimSection56Form using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimSection56Form] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT

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
	 [CourtCode]
	,[CourtName]
	,[GeneratedDateTime]
	,[IsManualEntry]
	,[LicenceCode]
	,[Section56FormGUID]
	,[Section56Number]
	,[SubjectAge]
	,[SubjectFirstNames]
	,[SubjectGender]
	,[SubjectIDNumber]
	,[SubjectIDNumberForeign]
	,[SubjectNationality]
	,[SubjectSurname]
FROM WCG_STAGE.itis.transformDimSection56Form
WHERE RowSequence = 1
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimSection56Form dim
USING conf
ON (dim.[Section56FormGUID] = conf.[Section56FormGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 [CourtCode]
		,[CourtName]
		,[GeneratedDateTime]
		,[IsManualEntry]
		,[LicenceCode]
		,[Section56FormGUID]
		,[Section56Number]
		,[SubjectAge]
		,[SubjectFirstNames]
		,[SubjectGender]
		,[SubjectIDNumber]
		,[SubjectIDNumberForeign]
		,[SubjectNationality]
		,[SubjectSurname]
		,[InsertAuditKey]
		,[UpdateAuditKey]
	)
	VALUES (
		 conf.[CourtCode]
		,conf.[CourtName]
		,conf.[GeneratedDateTime]
		,conf.[IsManualEntry]
		,conf.[LicenceCode]
		,conf.[Section56FormGUID]
		,conf.[Section56Number]
		,conf.[SubjectAge]
		,conf.[SubjectFirstNames]
		,conf.[SubjectGender]
		,conf.[SubjectIDNumber]
		,conf.[SubjectIDNumberForeign]
		,conf.[SubjectNationality]
		,conf.[SubjectSurname]
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[CourtCode]						<> conf.[CourtCode]
		OR dim.[CourtName]						<> conf.[CourtName]
		OR ISNULL(dim.[GeneratedDateTime],'')	<> ISNULL(conf.[GeneratedDateTime],'')
		OR dim.[IsManualEntry]					<> conf.[IsManualEntry]
		OR dim.[LicenceCode]					<> conf.[LicenceCode]
		OR dim.[Section56Number]				<> conf.[Section56Number]
		OR dim.[SubjectAge]						<> conf.[SubjectAge]
		OR ISNULL(dim.[SubjectFirstNames],'')	<> ISNULL(conf.[SubjectFirstNames],'')
		OR dim.[SubjectGender]					<> conf.[SubjectGender]
		OR dim.[SubjectIDNumber]				<> conf.[SubjectIDNumber]
		OR dim.[SubjectIDNumberForeign]			<> conf.[SubjectIDNumberForeign]
		OR dim.[SubjectNationality]				<> conf.[SubjectNationality]
		OR dim.[SubjectSurname]					<> conf.[SubjectSurname]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[CourtCode]					 = conf.[CourtCode],
			dim.[CourtName]					 = conf.[CourtName],
			dim.[GeneratedDateTime]			 = conf.[GeneratedDateTime],
			dim.[IsManualEntry]				 = conf.[IsManualEntry],
			dim.[LicenceCode]				 = conf.[LicenceCode],
			dim.[Section56Number]			 = conf.[Section56Number],
			dim.[SubjectAge]				 = conf.[SubjectAge],
			dim.[SubjectFirstNames]			 = conf.[SubjectFirstNames],
			dim.[SubjectGender]				 = conf.[SubjectGender],
			dim.[SubjectIDNumber]			 = conf.[SubjectIDNumber],
			dim.[SubjectIDNumberForeign]	 = conf.[SubjectIDNumberForeign],
			dim.[SubjectNationality]		 = conf.[SubjectNationality],
			dim.[SubjectSurname]			 = conf.[SubjectSurname],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimSection56Form




;
;
;

;
;

