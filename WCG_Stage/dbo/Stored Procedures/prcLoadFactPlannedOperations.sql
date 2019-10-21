CREATE PROCEDURE [dbo].[prcLoadFactPlannedOperations]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-05-2018
-- Reason				:	Load FactPlannedOperations using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactPlannedOperations -1, -1
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
		 PlannedDateKey
		,OperationKey
		,OperationsDateKey
		,TrafficCentreKey
		,PlannerUserKey
		,OperationalOfficerUserKey
		,UniqueID
		,DeltaLogKey
	 FROM [dbo].[LoadFactPlannedOperations] conf
	 WHERE Deltalogkey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactPlannedOperations fact
USING conf
ON (fact.[UniqueID] = conf.[UniqueID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 [PlannedDateKey]
			,[OperationKey]
			,[OperationsDateKey]
			,[TrafficCentreKey]
			,[PlannerUserKey]
			,[OperationalOfficerUserKey]
			,[UniqueID]
			,[DeltaLogKey]
			,[InsertAuditKey]
			,[UpdateAuditKey]
			)
	VALUES (
			 conf.[PlannedDateKey]
			,conf.[OperationKey]
			,conf.[OperationsDateKey]
			,conf.[TrafficCentreKey]
			,conf.[PlannerUserKey]
			,conf.[OperationalOfficerUserKey]
			,conf.[UniqueID]
			,[DeltaLogKey]
			,@AuditKey
			,@AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			[PlannedDateKey]					= conf.[PlannedDateKey],
			[OperationKey]						= conf.[OperationKey],
			[OperationsDateKey]					= conf.[OperationsDateKey],
			[TrafficCentreKey]					= conf.[TrafficCentreKey],
			[PlannerUserKey]					= conf.[PlannerUserKey],
			[OperationalOfficerUserKey]			= conf.[OperationalOfficerUserKey],
			/* Update System Fields */
			fact.UpdateAuditKey					= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformFactPlannedOperations WHERE DeltaLogKey = @DeltaLogKey

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






