
CREATE PROCEDURE [dbo].[prcLoadFactDeviceHistory]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	18-11-2019
-- Reason				:	Load FactDeviceHistory using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactDeviceHistory 175395, 30737
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

/* Truncate Table */
DELETE FROM itis.transformLastKnownLocation

/* Populate Table with rows from delta */
INSERT INTO itis.transformLastKnownLocation (
 id
,type
,updated_at
,display
,device_id
,traffic_centre_id
,user_id
,device_name
,device_number
,latitude
,longitude
,sent_on
,status_key
,status_display
,traffic_centre_name
,user_event_date
,user_event_id
,user_event_information
,user_event_source
,user_event_subtype
,user_event_type
,user_infrastructure_number
,user_name
,user_rank
,user_surname
,DeltaLogKey
,AuditKey
)
SELECT 
 id
,type
,updated_at
,display
,device_id
,traffic_centre_id
,user_id
,device_name
,device_number
,latitude
,longitude
,sent_on
,status_key
,status_display
,traffic_centre_name
,user_event_date
,user_event_id
,user_event_information
,user_event_source
,user_event_subtype
,user_event_type
,user_infrastructure_number
,user_name
,user_rank
,user_surname
,DeltaLogKey
,AuditKey
FROM itis.last_known_location
WHERE DeltaLogKey = @DeltaLogKey

/* Infer DimDeviceEvent */
exec dbo.prcLoadDimDeviceEvent @AuditKey, @DeltaLogKey

/* Merge into Fact Table */
;WITH conf AS (
SELECT 
	 DeviceKey
	,DeviceEventKey
	,EventDateKey
	,EventTimeKey
	,OperationKey
	,ShiftKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UserKey
	,Latitude
	,Longitude
	,EventSource
	,EventSubType
	,EventType
	,EventDateTime
	,EventStatus
	,EventValue
	,UniqueID
	,DeltaLogKey
FROM [dbo].[LoadFactDeviceHistory] conf
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactDeviceHistory fact
USING conf
ON (fact.UniqueID = conf.UniqueID)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 DeviceEventKey
	,DeviceKey
	,EventDateKey
	,EventTimeKey
	--,GeoLocationKey
	,OperationKey
	,ShiftKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UserKey
	,EventDateTime
	,EventStatus
	,EventValue
	,UniqueID
	,DeltaLogKey
	,InsertAuditKey
	,UpdateAuditKey
			)
	VALUES (
	 conf.DeviceEventKey
	,conf.DeviceKey
	,conf.EventDateKey
	,conf.EventTimeKey
	--,conf.GeoLocationKey
	,conf.OperationKey
	,conf.ShiftKey
	,conf.TrafficCentreKey
	,conf.TrafficControlEventKey
	,conf.UserKey
	,conf.EventDateTime
	,conf.EventStatus
	,conf.EventValue
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
			 fact.DeviceEventKey			= conf.DeviceEventKey
			,fact.DeviceKey					= conf.DeviceKey
			,fact.EventDateKey				= conf.EventDateKey
			,fact.EventTimeKey				= conf.EventTimeKey
			,fact.OperationKey				= conf.OperationKey
			,fact.ShiftKey					= conf.ShiftKey
			,fact.TrafficCentreKey			= conf.TrafficCentreKey
			,fact.TrafficControlEventKey	= conf.TrafficControlEventKey
			,fact.UserKey					= conf.UserKey
			--,fact.Latitude					= conf.Latitude
			--,fact.Longitude					= conf.Longitude
			,fact.EventDateTime				= conf.EventDateTime
			,fact.EventStatus				= conf.EventStatus
			,fact.EventValue				= conf.EventValue
			/* Update System Fields */
			,fact.UpdateAuditKey			= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformFactDeviceHistory

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