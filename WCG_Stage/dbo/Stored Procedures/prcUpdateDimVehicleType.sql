

CREATE PROCEDURE [dbo].[prcUpdateDimVehicleType]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	04-03-2018
-- Reason				:	Update DimVehicleType from DimVehicle
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcUpdateDimVehicleType -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT

AS

/* Update DimVehicleType from DimVehicle */
WITH vehiclecte AS (
SELECT
	 ISNULL(NULLIF(VehicleCategory,''),'Unknown')	AS VehicleCategory
	,ISNULL(NULLIF(VehicleCategoryCode,''),'0')		AS VehicleCategoryCode
	,ISNULL(NULLIF(VehicleUsage,''),'Unknown')		AS VehicleUsage
	,ISNULL(NULLIF(VehicleUsageCode,''),'00')		AS VehicleUsageCode
	,ROW_NUMBER() OVER (PARTITION BY VehicleCategoryCode, VehicleUsageCode ORDER BY DeltalogKey DESC) AS RowNumber
FROM WCG_DW.dbo.DimVehicle
),

conf AS (
SELECT
	 VehicleCategory
	,VehicleCategoryCode
	,VehicleUsage
	,VehicleUsageCode
FROM vehiclecte
WHERE Rownumber = 1
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimVehicleType dim
USING conf
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
				END;			


;
;
;
;

