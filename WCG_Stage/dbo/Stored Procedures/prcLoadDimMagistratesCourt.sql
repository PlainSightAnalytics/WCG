CREATE PROCEDURE [dbo].[prcLoadDimMagistratesCourt]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14 August 2016
-- Reason				:	Performs SCD Logic for DimMagisgtratesCourt using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimMagistratesCourt] -1
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
	 MagistratesCourtID
	,MagistratesCourt
FROM WCG_STAGE.ebat.transformDimMagistratesCourt
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimMagistratesCourt dim
USING conf
ON (dim.[MagistratesCourtID] = conf.[MagistratesCourtID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			[MagistratesCourtID], [MagistratesCourt],
			InsertAuditKey, UpdateAuditKey
			)
	VALUES (
			conf.[MagistratesCourtID], conf.[MagistratesCourt],
			@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[MagistratesCourt] <> conf.[MagistratesCourt]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[MagistratesCourt] = conf.[MagistratesCourt],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.ebat.transformDimMagistratesCourt




;
;
;

;
;