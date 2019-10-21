


CREATE PROCEDURE [dbo].[prcLoadDimAPPTarget]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Performs SCD Logic for DimAPPTarget using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimAPPTarget] -1
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
	 APPTargetGUID
	,APPTarget
	,OpenClosedStatus
FROM WCG_STAGE.itis.transformDimAPPTarget
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimAPPTarget dim
USING  conf
ON (dim.[APPTargetGUID] = conf.[APPTargetGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			[APPTargetGUID], [APPTarget], [OpenClosedStatus],
			InsertAuditKey, UpdateAuditKey
			)
	VALUES (
			conf.[APPTargetGUID], conf.[APPTarget], conf.[OpenClosedStatus],
			@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[APPTarget] <> conf.[APPTarget]
		OR dim.[OpenClosedStatus] <> conf.[OpenClosedStatus]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[APPTarget] = conf.[APPTarget],
			dim.[OpenClosedStatus] = conf.[OpenClosedStatus],
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimAPPTarget 



;
;
;
;
