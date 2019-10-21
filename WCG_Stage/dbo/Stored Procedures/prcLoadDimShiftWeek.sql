

CREATE PROCEDURE [dbo].[prcLoadDimShiftWeek]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-05-2018
-- Reason				:	Performs SCD Logic for DimShiftWeek using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimShiftWeek] -1
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
	 [IsUserWeek]
	,[RosterWeek]
	,[ShiftWeek]
	,[ShiftWeekGUID]
	,[User]
	,[UserRole]
	,[WeekEndDate]
	,[WeekStartDate]
FROM WCG_STAGE.itis.transformDimShiftWeek
WHERE DeltaLogKey = @DeltaLogKey
AND RowSequence = 1

)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimShiftWeek dim
USING conf
ON (dim.[ShiftWeekGUID] = conf.[ShiftWeekGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 [IsUserWeek]
		,[RosterWeek]
		,[ShiftWeek]
		,[ShiftWeekGUID]
		,[User]
		,[UserRole]
		,[WeekEndDate]
		,[WeekStartDate]
		,[InsertAuditKey]
		,[UpdateAuditKey]
	)
	VALUES (
		 conf.[IsUserWeek]
		,conf.[RosterWeek]
		,conf.[ShiftWeek]
		,conf.[ShiftWeekGUID]
		,conf.[User]
		,conf.[UserRole]
		,conf.[WeekEndDate]
		,conf.[WeekStartDate]
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[IsUserWeek]					<> conf.[IsUserWeek]
		OR dim.[RosterWeek]					<> conf.[RosterWeek]
		OR dim.[ShiftWeek]					<> conf.[ShiftWeek]
		OR dim.[User]						<> conf.[User]
		OR dim.[UserRole]					<> conf.[UserRole]
		OR ISNULL(dim.[WeekEndDate],'')		<> ISNULL(conf.[WeekEndDate],'')
		OR ISNULL(dim.[WeekStartDate],'')	<> ISNULL(conf.[WeekStartDate],'')
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[IsUserWeek]			= conf.[IsUserWeek],
			dim.[RosterWeek]			= conf.[RosterWeek],
			dim.[ShiftWeek]				= conf.[ShiftWeek],
			dim.[User]					= conf.[User],
			dim.[UserRole]				= conf.[UserRole],
			dim.[WeekEndDate]			= conf.[WeekEndDate],
			dim.[WeekStartDate]			= conf.[WeekStartDate],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimShiftWeek

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
;


