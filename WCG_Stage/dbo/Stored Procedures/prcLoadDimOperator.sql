CREATE PROCEDURE [dbo].[prcLoadDimOperator]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14 August 2016
-- Reason				:	Performs SCD Logic for DimOperator using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimOperator] -1
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
	 [OperatorID]
	,[Operator]
	,[FirstName]
	,[Surname]
	,[Role]
	,[IsOperator]
	,[IDNumber]
	,[InfrastructureNumber]
	,[OperatorCertificate]
	,[Centre]
	,[Municipality]
	,[District]
	,[Province]
	,[RegionalArea]
	,[Authority]
FROM WCG_STAGE.ebat.transformDimOperator
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimOperator dim
USING conf
ON (dim.[OperatorID] = conf.[OperatorID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		[OperatorID],[Operator],[FirstName],[Surname],[Role],[IsOperator],[IDNumber],[InfrastructureNumber],[OperatorCertificate]
		,[Centre],[Municipality],[District],[Province],[RegionalArea],[Authority],[InsertAuditKey],[UpdateAuditKey])
	VALUES (
		 [OperatorID],[Operator],[FirstName],[Surname],[Role],[IsOperator],[IDNumber],[InfrastructureNumber],[OperatorCertificate]
		,[Centre],[Municipality],[District],[Province],[RegionalArea],[Authority],@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		dim.[Operator] <> conf.[Operator]
		OR dim.[FirstName] <> conf.[FirstName]
		OR dim.[Surname] <> conf.[Surname]
		OR dim.[Role] <> conf.[Role]
		OR dim.[IsOperator] <> conf.[IsOperator]
		OR dim.[IDNumber] <> conf.[IDNumber]
		OR dim.[InfrastructureNumber] <> conf.[InfrastructureNumber]
		OR dim.[OperatorCertificate] <> conf.[OperatorCertificate]
		OR dim.[Centre] <> conf.[Centre]
		OR dim.[Municipality] <> conf.[Municipality]
		OR dim.[District] <> conf.[District]
		OR dim.[Province] <> conf.[Province]
		OR dim.[RegionalArea] <> conf.[RegionalArea]
		OR dim.[Authority] <> conf.[Authority]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[Operator] = conf.[Operator],
			dim.[FirstName] = conf.[FirstName],
			dim.[Surname] = conf.[Surname],
			dim.[Role] = conf.[Role],
			dim.[IsOperator] = conf.[IsOperator],
			dim.[IDNumber] = conf.[IDNumber],
			dim.[InfrastructureNumber] = conf.[InfrastructureNumber],
			dim.[OperatorCertificate] = conf.[OperatorCertificate],
			dim.[Centre] = conf.[Centre],
			dim.[Municipality] = conf.[Municipality],
			dim.[District] = conf.[District],
			dim.[Province] = conf.[Province],
			dim.[RegionalArea] = conf.[RegionalArea],
			dim.[Authority] = conf.[Authority],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.ebat.transformDimOperator




;
;
;

;
;