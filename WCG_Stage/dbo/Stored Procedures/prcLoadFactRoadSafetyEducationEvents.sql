
CREATE PROCEDURE [dbo].[prcLoadFactRoadSafetyEducationEvents]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-04-2019
-- Reason				:	Load FactRoadSafetyEducationEvents using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactRoadSafetyEducationEvents -1, -1
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
	 CreateDateKey
	,CreateTimeKey
	,DriverKey
	,OperationsDateKey
	,RoadSafetyTopicKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UserKey
	,VehicleKey
	,UniqueID
	,DeltaLogKey
FROM [dbo].[LoadFactRoadSafetyEducationEvents] conf
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactRoadSafetyEducationEvents fact
USING conf
ON (fact.UniqueID = conf.UniqueID)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 CreateDateKey
	,CreateTimeKey
	,DriverKey
	,OperationsDateKey
	,RoadSafetyTopicKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UserKey
	,VehicleKey
	,UniqueID
	,DeltaLogKey
	,InsertAuditKey
	,UpdateAuditKey
			)
	VALUES (
	 conf.CreateDateKey
	,conf.CreateTimeKey
	,conf.DriverKey
	,conf.OperationsDateKey
	,conf.RoadSafetyTopicKey
	,conf.TrafficCentreKey
	,conf.TrafficControlEventKey
	,conf.UserKey
	,conf.VehicleKey
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
			 fact.CreateDateKey				= conf.CreateDateKey
			,fact.CreateTimeKey				= conf.CreateTimeKey
			,fact.DriverKey					= conf.DriverKey
			,fact.OperationsDateKey			= conf.OperationsDateKey
			,fact.RoadSafetyTopicKey		= conf.RoadSafetyTopicKey
			,fact.TrafficCentreKey			= conf.TrafficCentreKey
			,fact.TrafficControlEventKey	= conf.TrafficControlEventKey
			,fact.UserKey					= conf.UserKey
			,fact.VehicleKey				= conf.VehicleKey
			/* Update System Fields */
			,fact.UpdateAuditKey			= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformFactRoadSafetyEducationEvents WHERE DeltaLogKey = @DeltaLogKey

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






