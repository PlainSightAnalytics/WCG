



CREATE PROCEDURE [dbo].[prcLoadFactShiftTasks]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	21-10-2018
-- Reason				:	Load FactShiftTasks using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactShiftTasks -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
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
	 OperationsDateKey
	,ShiftDateKey
	,ShiftKey
	,ShiftLocationKey
	,ShiftTaskKey
	,TrafficCentreKey
	,UserKey
	,DurationHours
	,TaskTarget
	,IsAdHocTask
	,OtherLocation
	,TaskEndTime
	,TaskStartTime
	,UniqueID
	,DeltaLogKey
FROM [dbo].[LoadFactShiftTasks] conf
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactShiftTasks fact
USING conf
ON (fact.[UniqueID] = conf.[UniqueID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 OperationsDateKey
	,ShiftDateKey
	,ShiftKey
	,ShiftLocationKey
	,ShiftTaskKey
	,TrafficCentreKey
	,UserKey
	,DurationHours
	,TaskTarget
	,IsAdHocTask
	,OtherLocation
	,TaskEndTime
	,TaskStartTime
	,UniqueID
	,DeltaLogKey
	,[InsertAuditKey]
	,[UpdateAuditKey]
			)
	VALUES (
	 conf.OperationsDateKey
	,conf.ShiftDateKey
	,conf.ShiftKey
	,conf.ShiftLocationKey
	,conf.ShiftTaskKey
	,conf.TrafficCentreKey
	,conf.UserKey
	,conf.DurationHours
	,conf.TaskTarget
	,conf.IsAdHocTask
	,conf.OtherLocation
	,conf.TaskEndTime
	,conf.TaskStartTime
	,conf.UniqueID
	,conf.DeltaLogKey
	,@AuditKey
	,@AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */

			 fact.OperationsDateKey		   = conf.OperationsDateKey
			,fact.ShiftDateKey			   = conf.ShiftDateKey		
			,fact.ShiftKey				   = conf.ShiftKey			
			,fact.ShiftLocationKey		   = conf.ShiftLocationKey	
			,fact.ShiftTaskKey			   = conf.ShiftTaskKey		
			,fact.TrafficCentreKey		   = conf.TrafficCentreKey	
			,fact.UserKey				   = conf.UserKey		
			,fact.DurationHours			   = conf.DurationHours
			,fact.TaskTarget			   = conf.TaskTarget	
			,fact.IsAdHocTask			   = conf.IsAdHocTask		
			,fact.OtherLocation			   = conf.OtherLocation	
			,fact.TaskEndTime			   = conf.TaskEndTime
			,fact.TaskStartTime			   = conf.TaskStartTime	
			,fact.DeltaLogKey			   = conf.DeltaLogKey		

			/* Update System Fields */
			,fact.UpdateAuditKey			= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.[dbo].[LoadFactShiftTasks] WHERE DeltaLogKey = @DeltaLogKey

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






