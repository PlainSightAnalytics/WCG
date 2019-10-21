
CREATE PROCEDURE [dbo].[prcLoadFactAPPTargets]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Load FactAPPTargets using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactAppTargets -1, 27056
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
@RowCountExtract INT,
@MaxTargetDate DATE

DECLARE @RowCounts TABLE
(mergeAction varchar(10));

/* Get Latest Target Date */
SELECT @MaxTargetDate = MAX(TargetDate)
FROM WCG_Stage.itis.transformFactAPPTargets
WHERE DeltaLogKey = @DeltaLogKey

/* Infer any future Dates */
EXEC WCG_Stage.dbo.prcLoadDimDate @AuditKey, @MaxTargetDate

;WITH conf AS (
SELECT 
	 [APPTargetKey]
	,[TargetDateKey]
	,[TrafficCentreKey]
	,[UniqueGUID]
	,[AdjustedTarget]
	,[Target]
	,[DeltaLogKey] 
  FROM [dbo].[LoadFactAPPTargets] conf
  WHERE DeltalogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactAPPTargets fact
USING conf
ON (fact.[UniqueGUID] = conf.[UniqueGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 [APPTargetKey]
			,[TargetDateKey]
			,[TrafficCentreKey]
			,[UniqueGUID]
			,[AdjustedTarget]
			,[Target]
			,[DeltaLogKey]
			,[InsertAuditKey]
			,[UpdateAuditKey]
			)
	VALUES (
			 [APPTargetKey]
			,[TargetDateKey]
			,[TrafficCentreKey]
			,[UniqueGUID]
			,[AdjustedTarget]
			,[Target]
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
			,[TargetDateKey]		= conf.[TargetDateKey]
			,[TrafficCentreKey]		= conf.[TrafficCentreKey]
			,[AdjustedTarget]		= conf.[AdjustedTarget]
			,[Target]				= conf.[Target]
			/* Update System Fields */
			,fact.UpdateAuditKey	= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformFactAPPTargets

/* Update Delta Log 
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	RowCountUpdate = @RowCountUpdate,
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey
*/





	



;



;
;
;





