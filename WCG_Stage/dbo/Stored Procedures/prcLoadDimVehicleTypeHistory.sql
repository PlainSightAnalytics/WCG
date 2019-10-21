


CREATE PROCEDURE [dbo].[prcLoadDimVehicleTypeHistory]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14-03-2018
-- Reason				:	Performs SCD Logic for DimVehicleType using MERGE statement (History)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimVehicleType] -1, -1
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

/* Truncate conform Table */
DELETE FROM WCG_STAGE.cle.conformDimVehicleType

/* Insert into conform Table */
INSERT INTO WCG_STAGE.cle.conformDimVehicleType
(VehicleCategory, VehicleCategoryCode, VehicleUsage, VehicleUsageCode)
SELECT
	 VehicleCategory
	,VehicleCategoryCode
	,VehicleUsage
	,VehicleUsageCode
FROM WCG_STAGE.cle.transformDimVehicleTypeHistory
WHERE DeltaLogKey = @DeltaLogKey


/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimVehicleType dim
USING WCG_STAGE.cle.conformDimVehicleType conf
ON (dim.VehicleCategoryCode = conf.VehicleCategoryCode AND dim.VehicleUsageCode = conf.VehicleUsageCode)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 VehicleCategory
			,VehicleCategoryCode
			,VehicleUsage
			,VehicleUsageCode
			,DeltaLogKey
			,InsertAuditKey
			,UpdateAuditKey
			)
	VALUES (
			 conf.VehicleCategory
			,conf.VehicleCategoryCode
			,conf.VehicleUsage
			,conf.VehicleUsageCode
			,@DeltaLogKey
			,@AuditKey
			,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.VehicleCategory <> conf.VehicleCategory
		OR dim.VehicleCategoryCode <> conf.VehicleCategoryCode
		OR dim.VehicleUsage <> conf.VehicleUsage
		OR dim.VehicleUsageCode <> conf.VehicleUsageCode
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.VehicleCategory = conf.VehicleCategory,
			dim.VehicleCategoryCode = conf.VehicleCategoryCode,
			dim.VehicleUsage = conf.VehicleUsage,
			dim.VehicleUsageCode = conf.VehicleUsageCode,
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

/* Truncate conform Table */
DELETE FROM WCG_STAGE.cle.conformDimVehicleType







;
;
;

;





