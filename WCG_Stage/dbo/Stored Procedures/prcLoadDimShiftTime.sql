

CREATE PROCEDURE [dbo].[prcLoadDimShiftTime]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-05-2018
-- Reason				:	Performs SCD Logic for DimShiftTime using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimShiftTime] -1
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
	 [DurationHours]
	,[EndTime]
	,[IsOffDuty]
	,[ShiftTime]
	,[ShiftTimeGUID]
	,[ShiftTimeSort]
	,[StartTime]
	,[TrafficCentre]
FROM WCG_STAGE.itis.transformDimShiftTime
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimShiftTime dim
USING conf
ON (dim.[ShiftTimeGUID] = conf.[ShiftTimeGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 [DurationHours]
		,[EndTime]
		,[IsOffDuty]
		,[ShiftTime]
		,[ShiftTimeGUID]
		,[ShiftTimeSort]
		,[StartTime]
		,[TrafficCentre]
		,[InsertAuditKey]
		,[UpdateAuditKey]
	)
	VALUES (
		 conf.[DurationHours]
		,conf.[EndTime]
		,conf.[IsOffDuty]
		,conf.[ShiftTime]
		,conf.[ShiftTimeGUID]
		,conf.[ShiftTimeSort]
		,conf.[StartTime]
		,conf.[TrafficCentre]
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[DurationHours]		<> conf.[DurationHours]
		OR dim.[EndTime]			<> conf.[EndTime]
		OR dim.[IsOffDuty]			<> conf.[IsOffDuty]
		OR dim.[ShiftTime]			<> conf.[ShiftTime]
		OR dim.[ShiftTimeSort]		<> conf.[ShiftTimeSort]
		OR dim.[StartTime]			<> conf.[StartTime]
		) 	/* [TrafficCentre]Check if any [TrafficCentre]Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[DurationHours]		= conf.[DurationHours],
			dim.[EndTime]			= conf.[EndTime],
			dim.[IsOffDuty]			= conf.[IsOffDuty],
			dim.[ShiftTime]			= conf.[ShiftTime],
			dim.[ShiftTimeSort]		= conf.[ShiftTimeSort],
			dim.[StartTime]			= conf.[StartTime],

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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimShiftTime




;
;
;

;
;


