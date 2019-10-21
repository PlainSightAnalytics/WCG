

CREATE PROCEDURE [dbo].[prcLoadFactPlannedShifts]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	24-06-2018
-- Reason				:	Load FactPlannedShifts using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactPlannedShifts -1, -1
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
@RowCountExtract INT

DECLARE @RowCounts TABLE
(mergeAction varchar(10));

WITH conf AS (
SELECT 
	 [RosterKey]
	,[ShiftDateKey]
	,[ShiftTimeKey]
	,[ShiftWeekKey]
	,[TrafficCentreKey]
	,[UserKey]
	,[IsAcknowledged]
	,[IsArchived]
	,[IsDeleted]
	,[IsUserShift]
	,[ShiftGUID]
	,[DeltaLogKey]
FROM [dbo].[LoadFactPlannedShifts] conf
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactPlannedShifts fact
USING conf
ON (fact.[ShiftGUID] = conf.[ShiftGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 [RosterKey]
	,[ShiftDateKey]
	,[ShiftTimeKey]
	,[ShiftWeekKey]
	,[TrafficCentreKey]
	,[UserKey]
	,[IsAcknowledged]
	,[IsArchived]
	,[IsDeleted]
	,[IsUserShift]
	,[ShiftGUID]
	,[DeltaLogKey]
	,[InsertAuditKey]
	,[UpdateAuditKey]
			)
	VALUES (
	 conf.[RosterKey]
	,conf.[ShiftDateKey]
	,conf.[ShiftTimeKey]
	,conf.[ShiftWeekKey]
	,conf.[TrafficCentreKey]
	,conf.[UserKey]
	,conf.[IsAcknowledged]
	,conf.[IsArchived]
	,conf.[IsDeleted]
	,conf.[IsUserShift]
	,conf.[ShiftGUID]
	,conf.[DeltaLogKey]
	,@AuditKey
	,@AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			 fact.[RosterKey]				= conf.[RosterKey]
			,fact.[ShiftDateKey]			= conf.[ShiftDateKey]
			,fact.[ShiftTimeKey]			= conf.[ShiftTimeKey]
			,fact.[ShiftWeekKey]			= conf.[ShiftWeekKey]
			,fact.[TrafficCentreKey]		= conf.[TrafficCentreKey]
			,fact.[UserKey]					= conf.[UserKey]
			,fact.[IsAcknowledged]			= conf.[IsAcknowledged]
			,fact.[IsArchived]				= conf.[IsArchived]			
			,fact.[IsDeleted]				= conf.[IsDeleted]				
			,fact.[IsUserShift]				= conf.[IsUserShift]	
			/* Update System Fields */
			,fact.UpdateAuditKey			= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformFactPlannedShifts WHERE DeltaLogKey = @DeltaLogKey

/* Update Delta Log 
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	RowCountUpdate = @RowCountUpdate,
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey*/






	



;



;
;
;






