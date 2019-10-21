CREATE PROCEDURE [dbo].[prcLoadFactOperationAssignments]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Load FactOperationAssignments using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactOperationAssignments -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	17-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
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
		 [OperationDateKey]
		,[OperationKey]
		,[OperationsDateKey]
		,[TrafficCentreKey]
		,[UserKey]
		,[UniqueID]
		,[DeltaLogKey] 
	 FROM [dbo].[LoadFactOperationAssignments] conf
	 WHERE Deltalogkey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactOperationAssignments fact
USING conf
ON (fact.[UniqueID] = conf.[UniqueID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 [OperationDateKey]
			,[OperationKey]
			,[OperationsDateKey]
			,[TrafficCentreKey]
			,[UserKey]
			,[UniqueID]
			,[DeltaLogKey]
			,[InsertAuditKey]
			,[UpdateAuditKey]
			)
	VALUES (
			 [OperationDateKey]
			,[OperationKey]
			,[OperationsDateKey]
			,[TrafficCentreKey]
			,[UserKey]
			,[UniqueID]
			,[DeltaLogKey]
			,@AuditKey
			, @AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			 [OperationDateKey]			= conf.[OperationDateKey]
			,[OperationKey]				= conf.[OperationKey]
			,[OperationsDateKey]		= conf.[OperationsDateKey]
			,[TrafficCentreKey]			= conf.[TrafficCentreKey]
			,[UserKey]					= conf.[UserKey]
			/* Update System Fields */
			,fact.UpdateAuditKey		= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformFactOperationAssignments WHERE DeltaLogKey = @DeltaLogKey

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






