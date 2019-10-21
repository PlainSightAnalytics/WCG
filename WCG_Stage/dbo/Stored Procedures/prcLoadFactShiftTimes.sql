


CREATE PROCEDURE [dbo].[prcLoadFactShiftTimes]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	21-10-2018
-- Reason				:	Load FactShiftTimes using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactShiftTimes -1, -1
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
	 [OperationsDateKey]
	,[RosterKey]
	,[ShiftDateKey]
	,[ShiftKey]
	,[ShiftTimeKey]
	,[ShiftWeekKey]
	,[TrafficCentreKey]
	,[UserKey]
	,[DurationHours]
	,[IsAcknowledged]
	,[IsArchived]
	,[IsDeleted]
	,[IsUserShift]
	,[UniqueID]
	,[DeltaLogKey]
FROM [dbo].[LoadFactShiftTimes] conf
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactShiftTimes fact
USING conf
ON (fact.[UniqueID] = conf.[UniqueID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 [OperationsDateKey]
	,[RosterKey]
	,[ShiftDateKey]
	,[ShiftKey]
	,[ShiftTimeKey]
	,[ShiftWeekKey]
	,[TrafficCentreKey]
	,[UserKey]
	,[DurationHours]
	,[IsAcknowledged]
	,[IsArchived]
	,[IsDeleted]
	,[IsUserShift]
	,[UniqueID]
	,[DeltaLogKey]
	,[InsertAuditKey]
	,[UpdateAuditKey]
			)
	VALUES (
	 conf.[OperationsDateKey]
	,conf.[RosterKey]
	,conf.[ShiftDateKey]
	,conf.[ShiftKey]
	,conf.[ShiftTimeKey]
	,conf.[ShiftWeekKey]
	,conf.[TrafficCentreKey]
	,conf.[UserKey]
	,conf.[DurationHours]
	,conf.[IsAcknowledged]
	,conf.[IsArchived]
	,conf.[IsDeleted]
	,conf.[IsUserShift]
	,conf.[UniqueID]
	,conf.[DeltaLogKey]
	,@AuditKey
	,@AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			 fact.[OperationsDateKey]		= conf.[OperationsDateKey]
			,fact.[RosterKey]				= conf.[RosterKey]
			,fact.[ShiftDateKey]			= conf.[ShiftDateKey]
			,fact.[ShiftKey]				= conf.[ShiftKey]
			,fact.[ShiftTimeKey]			= conf.[ShiftTimeKey]
			,fact.[ShiftWeekKey]			= conf.[ShiftWeekKey]
			,fact.[TrafficCentreKey]		= conf.[TrafficCentreKey]
			,fact.[UserKey]					= conf.[UserKey]
			,fact.[DurationHours]			= conf.[DurationHours]
			,fact.[IsAcknowledged]			= conf.[IsAcknowledged]
			,fact.[IsArchived]				= conf.[IsArchived]			
			,fact.[IsDeleted]				= conf.[IsDeleted]				
			,fact.[IsUserShift]				= conf.[IsUserShift]	
			/* Update System Fields */
			,fact.UpdateAuditKey			= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.[dbo].[LoadFactShiftTimes] WHERE DeltaLogKey = @DeltaLogKey

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






