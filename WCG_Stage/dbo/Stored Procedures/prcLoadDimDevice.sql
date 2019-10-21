

CREATE PROCEDURE [dbo].[prcLoadDimDevice]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17 June 2016
-- Reason				:	Performs SCD Logic for DimDevice using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimDevice] -1
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
	 DeviceID
	,Device
	,DeviceType
	,TrafficCentreKey
	,CurrentUserKey
FROM WCG_STAGE.itis.transformDimDevice
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimDevice dim
USING  conf
ON (dim.[DeviceID] = conf.[DeviceID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			[DeviceID], [Device], [DeviceType], [TrafficCentreKey], [CurrentUserKey],
			InsertAuditKey, UpdateAuditKey
			)
	VALUES (
			conf.[DeviceID], conf.[Device], conf.[DeviceType], conf.[TrafficCentreKey], conf.[CurrentUserKey],
			@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[Device] <> conf.[Device]
		OR dim.[DeviceType] <> conf.[DeviceType]
		OR dim.[TrafficCentreKey] <> conf.[TrafficCentreKey]
		OR dim.[CurrentUserKey] <> conf.[CurrentUserKey]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[Device] = conf.[Device],
			dim.[DeviceType] = conf.[DeviceType],
			dim.[TrafficCentreKey] = conf.[TrafficCentreKey],
			dim.[CurrentUserKey] = conf.[CurrentUserKey],
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimDevice 



;
;
;
;