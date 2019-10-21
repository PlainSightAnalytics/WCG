

CREATE PROCEDURE [dbo].[prcLoadDimAlertType]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17 June 2016
-- Reason				:	Performs SCD Logic for DimAlertType using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimAlertType] -1, -1
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
	 AlertSubtypeCode
	,AlertSubtype
	,AlertTypeDescription
	,AlertTypeID
	,AlertType
	,IsCountedInReport
FROM WCG_STAGE.cle.transformDimAlertType 
WHERE DeltaLogKey = @DeltaLogKey
AND RowNumber = 1)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimAlertType dim
USING conf
ON (dim.[AlertTypeID] = conf.[AlertTypeID] AND dim.[AlertSubtypeCode] = conf.[AlertSubtypeCode])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			[AlertTypeID], [AlertSubtypeCode], [AlertSubtype], [AlertType], [AlertTypeDescription] , [IsCountedInReport],
			InsertAuditKey, UpdateAuditKey
			)
	VALUES (
			conf.[AlertTypeID], conf.[AlertSubtypeCode], conf.[AlertSubtype], conf.[AlertType], conf.[AlertTypeDescription] , conf.[IsCountedInReport],
			@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[AlertSubtype] <> conf.[AlertSubtype]
		OR dim.[AlertType] <> conf.[AlertType]
		OR dim.[AlertTypeDescription] <> conf.[AlertTypeDescription]
		OR dim.[IsCountedInReport] <> conf.[IsCountedInReport]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[AlertSubtype] = conf.[AlertSubtype],
			dim.[AlertType] = conf.[AlertType],
			dim.[AlertTypeDescription] = conf.[AlertTypeDescription],
			dim.[IsCountedInReport] = conf.[IsCountedInReport],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.cle.transformDimAlertType WHERE DeltaLogKey = @DeltaLogKey





;
;
;



