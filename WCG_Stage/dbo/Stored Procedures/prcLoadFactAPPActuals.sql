

CREATE PROCEDURE [dbo].[prcLoadFactAPPActuals]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Load FactAPPActuals using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactAppActuals -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   Trevor Howe
-- Modified On			:	18-08-2018
-- Reason				:   Added Comments
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
	 [APPTargetKey]
	,[ActualDateKey]
	,[TrafficCentreKey]
	,[Comments]
	,[UniqueGUID]
	,[PreliminaryActual]
	,[VerifiedActual]
	,[DeltaLogKey] 
  FROM [dbo].[LoadFactAPPActuals] conf
  WHERE Deltalogkey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactAPPActuals fact
USING conf
ON (fact.[UniqueGUID] = conf.[UniqueGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 [APPTargetKey]
			,[ActualDateKey]
			,[TrafficCentreKey]
			,[UniqueGUID]
			,[Comments]
			,[PreliminaryActual]
			,[VerifiedActual]
			,[DeltaLogKey]
			,[InsertAuditKey]
			,[UpdateAuditKey]
			)
	VALUES (
			 [APPTargetKey]
			,[ActualDateKey]
			,[TrafficCentreKey]
			,[UniqueGUID]
			,[Comments]
			,[PreliminaryActual]
			,[VerifiedActual]
			,[DeltaLogKey]
			,@AuditKey
			, @AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			 [APPTargetKey]			= conf.[APPTargetKey]
			,[ActualDateKey]		= conf.[ActualDateKey]
			,[TrafficCentreKey]		= conf.[TrafficCentreKey]
			,[Comments]				= conf.[Comments]
			,[PreliminaryActual]	= conf.[PreliminaryActual]
			,[VerifiedActual]		= conf.[VerifiedActual]
			/* Update System Fields */
			,fact.UpdateAuditKey	= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformFactAPPActuals WHERE DeltaLogKey = @DeltaLogKey

/* Update Delta Log */
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	RowCountUpdate = @RowCountUpdate,
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey






	



;



;
;
;






