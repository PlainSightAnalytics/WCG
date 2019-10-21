
CREATE PROCEDURE [dbo].[prcLoadFactTrafficControlEvents]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-05-2018
-- Reason				:	Load FactTrafficControlEvents
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactTrafficControlEventS -1, 25046
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   Trevor Howe
-- Modified On			:   26-08-2018
-- Reason				:   Added OpenDateKey and OpenTimeKey
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT

AS

DECLARE
@RowCountInsert INT

/* Delete existing Alert/Event type combinations */
;WITH cte AS (
SELECT
	UniqueAlertID
	,UniqueEventID
FROM WCG_Stage.dbo.LoadFactTrafficControlEvents WITH (NOLOCK)
WHERE DeltaLogKey = @DeltaLogKey
)

DELETE f
FROM WCG_DW.dbo.FactTrafficControlEvents f
INNER JOIN cte ON f.UniqueAlertID = cte.UniqueAlertID AND f.UniqueEventID = cte.UniqueEventID

/* Now Insert rows from Delta */
INSERT INTO WCG_DW.dbo.FactTrafficControlEvents (
	 AlertTypeKey
	,DeviceKey
	,DriverKey
	,MagistratesCourtKey
	,OpenDateKey
	,OpenTimeKey
	,OperationsDateKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UpdatedDateKey
	,UpdatedTimeKey
	,UserKey
	,VehicleKey
	,VehicleTypeKey
	,UniqueAlertID
	,UniqueEventID
	,InsertAuditKey
	,UpdateAuditKey
	,DeltaLogKey
)
SELECT
	 AlertTypeKey
	,DeviceKey
	,DriverKey
	,MagistratesCourtKey
	,OpenDateKey
	,OpenTimeKey
	,OperationsDateKey
	,TrafficCentreKey
	,TrafficControlEventKey
	,UpdatedDateKey
	,UpdatedTimeKey
	,UserKey
	,VehicleKey
	,VehicleTypeKey
	,UniqueAlertID
	,UniqueEventID
	,@AuditKey
	,@AuditKey
	,@DeltaLogKey
FROM WCG_Stage.dbo.LoadFactTrafficControlEvents WITH (NOLOCK)
WHERE DeltaLogKey = @DeltaLogKey

/* Store Inserted Rows */
SELECT @RowCountInsert = @@ROWCOUNT

/* Update Delta Log */
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey







	



;



;
;
;
;


