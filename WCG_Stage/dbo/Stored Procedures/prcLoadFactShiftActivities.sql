CREATE PROCEDURE [dbo].[prcLoadFactShiftActivities]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	21-10-2018
-- Reason				:	Load FactShiftActivities using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactShiftActivities -1, -1
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
	 GeoLocationKey
	,OperationsDateKey
	,ShiftActivityTypeKey
	,ShiftDateKey
	,ShiftKey
	,ShiftLocationKey
	,ShiftTaskKey
	,TrafficCentreKey
	,UserKey
	,DurationHours
	,ActivityComment
	,ActivityEndTime
	,ActivityStartTime
	,IsAdhocActivity
	,OtherLocation
	,UniqueID
	,DeltaLogKey
FROM [dbo].[LoadFactShiftActivities] conf
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactShiftActivities fact
USING conf
ON (fact.[UniqueID] = conf.[UniqueID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 GeoLocationKey
	,OperationsDateKey
	,ShiftActivityTypeKey
	,ShiftDateKey
	,ShiftKey
	,ShiftLocationKey
	,ShiftTaskKey
	,TrafficCentreKey
	,UserKey
	,DurationHours
	,ActivityComment
	,ActivityEndTime
	,ActivityStartTime
	,IsAdhocActivity
	,OtherLocation
	,UniqueID
	,DeltaLogKey
	,[InsertAuditKey]
	,[UpdateAuditKey]
			)
	VALUES (
	 conf.GeoLocationKey
	,conf.OperationsDateKey
	,conf.ShiftActivityTypeKey
	,conf.ShiftDateKey
	,conf.ShiftKey
	,conf.ShiftLocationKey
	,conf.ShiftTaskKey
	,conf.TrafficCentreKey
	,conf.UserKey
	,conf.DurationHours
	,conf.ActivityComment
	,conf.ActivityEndTime
	,conf.ActivityStartTime
	,conf.IsAdhocActivity
	,conf.OtherLocation
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

			 fact.GeoLocationKey		   = conf.GeoLocationKey
			,fact.OperationsDateKey		   = conf.OperationsDateKey
			,fact.ShiftActivityTypeKey	   = conf.ShiftActivityTypeKey
			,fact.ShiftDateKey			   = conf.ShiftDateKey
			,fact.ShiftKey				   = conf.ShiftKey
			,fact.ShiftLocationKey		   = conf.ShiftLocationKey
			,fact.ShiftTaskKey			   = conf.ShiftTaskKey
			,fact.TrafficCentreKey		   = conf.TrafficCentreKey
			,fact.UserKey				   = conf.UserKey
			,fact.DurationHours			   = conf.DurationHours
			,fact.ActivityComment		   = conf.ActivityComment
			,fact.ActivityEndTime		   = conf.ActivityEndTime
			,fact.ActivityStartTime		   = conf.ActivityStartTime
			,fact.IsAdhocActivity		   = conf.IsAdhocActivity
			,fact.OtherLocation			   = conf.OtherLocation
			,fact.DeltaLogKey			   = conf.DeltaLogKey

			/* Update System Fields */
			,fact.UpdateAuditKey			= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.[dbo].[LoadFactShiftActivities] WHERE DeltaLogKey = @DeltaLogKey

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






