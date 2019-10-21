

CREATE PROCEDURE [dbo].[prcLoadDimVehicleHistory]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14-03-2018
-- Reason				:	Performs SCD Logic for DimVehicle using MERGE statement (History)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimVehicle] -1, -1
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
DELETE FROM WCG_STAGE.cle.conformDimVehicle

/* Insert into conform Table */
INSERT INTO WCG_STAGE.cle.conformDimVehicle
(Colour,ColourCode,Make,MakeCode,Model,ModelCode,RegistrationNo,VehicleCategory,VehicleCategoryCode,VehicleUsage,VehicleUsageCode)
SELECT
	 Colour
	,ColourCode
	,Make
	,MakeCode
	,Model
	,ModelCode
	,RegistrationNo
	,VehicleCategory
	,VehicleCategoryCode
	,VehicleUsage
	,VehicleUsageCode
FROM WCG_STAGE.cle.transformDimVehicleHistory
WHERE DeltaLogKey = @DeltaLogKey

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimVehicle dim
USING WCG_STAGE.cle.conformDimVehicle conf
ON (dim.[RegistrationNo] = conf.[RegistrationNo])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 Colour
			,ColourCode
			,Make
			,MakeCode
			,Model
			,ModelCode
			,RegistrationNo
			,VehicleCategory
			,VehicleCategoryCode
			,VehicleUsage
			,VehicleUsageCode
			,DeltaLogKey
			,InsertAuditKey
			,UpdateAuditKey
			)
	VALUES (
			 conf.Colour
			,conf.ColourCode
			,conf.Make
			,conf.MakeCode
			,conf.Model
			,conf.ModelCode
			,conf.RegistrationNo
			,conf.VehicleCategory
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
		   dim.Colour <> conf.Colour
		OR dim.ColourCode <> conf.ColourCode
		OR dim.Make <> conf.Make
		OR dim.MakeCode <> conf.MakeCode
		OR dim.Model <> conf.Model
		OR dim.ModelCode <> conf.ModelCode
		OR dim.VehicleCategory <> conf.VehicleCategory
		OR dim.VehicleCategoryCode <> conf.VehicleCategoryCode
		OR dim.VehicleUsage <> conf.VehicleUsage
		OR dim.VehicleUsageCode <> conf.VehicleUsageCode
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.Colour = conf.Colour,
			dim.ColourCode = conf.ColourCode,
			dim.Make = conf.Make,
			dim.MakeCode = conf.MakeCode,
			dim.Model = conf.Model,
			dim.ModelCode = conf.ModelCode,
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
DELETE FROM WCG_STAGE.cle.conformDimVehicle

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




