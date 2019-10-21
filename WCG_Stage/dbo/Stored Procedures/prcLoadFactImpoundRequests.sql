CREATE PROCEDURE [dbo].[prcLoadFactImpoundRequests]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	08-02-2019
-- Reason				:	Load FactImpoundRequests using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactImpoundRequests -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	15-07-2019
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
	 DriverKey
	,ImpoundInstructionKey
	,OperationsDateKey
	,PoundFacilityKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UpdateDateKey
	,UserKey
	,VehicleKey
	,ImpoundOverrideReason
	,ImpoundRequestStatus
	,IsImpoundOverridden
	,UniqueID
	,DeltaLogKey
FROM [dbo].[LoadFactImpoundRequests] conf
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactImpoundRequests fact
USING conf
ON (fact.[UniqueID] = conf.[UniqueID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 DriverKey
	,ImpoundInstructionKey
	,OperationsDateKey
	,PoundFacilityKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UpdateDateKey
	,UserKey
	,VehicleKey
	,ImpoundOverrideReason
	,ImpoundRequestStatus
	,IsImpoundOverridden
	,UniqueID
	,DeltaLogKey
	,[InsertAuditKey]
	,[UpdateAuditKey]
			)
	VALUES (
	 conf.DriverKey
	,conf.ImpoundInstructionKey
	,conf.OperationsDateKey
	,conf.PoundFacilityKey
	,conf.TrafficCentreKey
	,conf.TrafficControlEventKey
	,conf.UpdateDateKey
	,conf.UserKey
	,conf.VehicleKey
	,conf.ImpoundOverrideReason
	,conf.ImpoundRequestStatus
	,conf.IsImpoundOverridden
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

			 fact.DriverKey						= conf.DriverKey
			,fact.ImpoundInstructionKey			= conf.ImpoundInstructionKey
			,fact.PoundFacilityKey				= conf.PoundFacilityKey
			,fact.OperationsDateKey				= conf.OperationsDateKey
			,fact.TrafficCentreKey				= conf.TrafficCentreKey
			,fact.TrafficControlEventKey		= conf.TrafficControlEventKey
			,fact.UpdateDateKey					= conf.UpdateDateKey
			,fact.UserKey						= conf.UserKey
			,fact.VehicleKey					= conf.VehicleKey
			,fact.ImpoundOverrideReason			= conf.ImpoundOverrideReason
			,fact.ImpoundRequestStatus			= conf.ImpoundRequestStatus
			,fact.IsImpoundOverridden			= conf.IsImpoundOverridden
			,fact.DeltaLogKey					= conf.DeltaLogKey		

			/* Update System Fields */
			,fact.UpdateAuditKey				= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.[dbo].[LoadFactImpoundRequests] WHERE DeltaLogKey = @DeltaLogKey

/* Update Delta Log */
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	RowCountUpdate = @RowCountUpdate,
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey

/* Update for Missing Traffic Control Events */
UPDATE f 
SET TrafficControlEventKey = e.TrafficControlEventKey
-- SELECT *
FROM WCG_DW.dbo.FactImpoundRequests f
LEFT JOIN WCG_Stage.itis.impound_request r ON f.UniqueID = r.id
LEFT JOIN WCG_DW.dbo.DimTrafficControlEvent e ON r.event_id = e.TrafficControlEventGUID
WHERE 
	f.TrafficControlEventKey = -1
AND f.ImpoundRequestStatus = 'Completed'
AND e.TrafficControlEventKey IS NOT NULL







	



;



;
;
;






