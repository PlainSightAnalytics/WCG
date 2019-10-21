

CREATE PROCEDURE [dbo].[prcLoadFactFlaggedVehicleAlerts]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	08-03-2019
-- Reason				:	Load FactFlaggedVehicleAlerts
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	prcLoadFactFlaggedVehicleAlerts -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------


@AuditKey INT

AS

DECLARE @RowCountInsert INT


DECLARE @RowCounts TABLE
(mergeAction varchar(10));

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactFlaggedVehicleAlerts fact
USING (
	SELECT * 
	FROM WCG_Stage.dbo.LoadFactFlaggedVehicleAlerts
	WHERE RowSequence = 1)  conf
ON (fact.[UniqueId] = conf.[UniqueId])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 CameraKey
	,FlaggedVehicleTripKey
	,GeoLocationKey
	,OperationsDateKey
	,SightingDateKey
	,SightingTimeKey
	,TrafficCentreKey
	,VehicleKey
	,FlagCount
	,FlagType
	,LastFlagDateTime
	,SightingRecordId
	,UniqueID
	,InsertAuditKey
	,UpdateAuditKey
			)
	VALUES (
	 conf.CameraKey
	,conf.FlaggedVehicleTripKey
	,conf.GeoLocationKey
	,conf.OperationsDateKey
	,conf.SightingDateKey
	,conf.SightingTimeKey
	,conf.TrafficCentreKey
	,conf.VehicleKey
	,conf.FlagCount
	,conf.FlagType
	,conf.LastFlagDateTime
	,conf.SightingRecordId
	,conf.UniqueID
	,@AuditKey
	,@AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			 fact.CameraKey					= conf.CameraKey
			,fact.FlaggedVehicleTripKey		= conf.FlaggedVehicleTripKey
			,fact.GeoLocationKey			= conf.GeoLocationKey
			,fact.OperationsDateKey			= conf.OperationsDateKey
			,fact.SightingDateKey			= conf.SightingDateKey
			,fact.SightingTimeKey			= conf.SightingTimeKey
			,fact.TrafficCentreKey			= conf.TrafficCentreKey
			,fact.VehicleKey				= conf.VehicleKey
			,fact.FlagCount					= conf.FlagCount
			,fact.FlagType					= conf.FlagType	
			,fact.LastFlagDateTime		    = conf.LastFlagDateTime
			,fact.SightingRecordId		    = conf.SightingRecordId

			/* Update System Fields */
			,fact.UpdateAuditKey			= @AuditKey
	OUTPUT $action into @rowcounts;		

/* Store Inserted Rows */
SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'







	



;


;
;
;

;
;
