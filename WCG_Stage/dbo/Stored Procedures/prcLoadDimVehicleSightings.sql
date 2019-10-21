
CREATE PROCEDURE [dbo].[prcLoadDimVehicleSightings]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	9 August 2016
-- Reason				:	Performs SCD Logic for DimVehicle using MERGE statement
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
(RegistrationNo)
SELECT
	 RegistrationNo
FROM WCG_STAGE.cle.transformDimVehicleSightings
WHERE DeltaLogKey = @DeltaLogKey
AND RowNumber = 1

--WITH conf AS (
--SELECT
--	RegistrationNo
--FROM WCG_STAGE.cle.transformDimVehicleSightings
--WHERE DeltaLogKey = @DeltaLogKey
--AND RowNumber = 1
--)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimVehicle dim
USING WCG_STAGE.cle.conformDimVehicle conf
ON (dim.[RegistrationNo] = conf.[RegistrationNo])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 RegistrationNo
			,DeltaLogKey
			,InsertAuditKey
			,UpdateAuditKey
			)
	VALUES (
			 conf.RegistrationNo
			,@DeltaLogKey
			,@AuditKey
			,@AuditKey
			)
	--WHEN MATCHED 
	--AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	--AND (
	--	   dim.Colour <> conf.Colour
	--	OR dim.Make <> conf.Make
	--	OR dim.Model <> conf.Model
	--	) 	/* Check if any Type 1 Fields have changed */
	--THEN 
	--	UPDATE 
	--	SET 
	--		/* Update Type 1 Fields */
	--		dim.Colour = conf.Colour,
	--		dim.Make = conf.Make,
	--		dim.Model = conf.Model,
	--		/* Update System Fields */
	--		dim.UpdateAuditKey = @AuditKey,
	--		dim.RowIsInferred = 'N',
	--		dim.RowChangeReason = 
	--			CASE 
	--				WHEN dim.RowIsInferred = 'Y' THEN 'Inferred Member Arrived'
	--				ELSE 'SCD Type 1 Change'
	--			END
OUTPUT $action into @rowcounts;			

/* Truncate conform Table */
DELETE FROM WCG_STAGE.cle.conformDimVehicle

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
--SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.cle.transformDimVehicleSightings WHERE DeltaLogKey = @DeltaLogKey





;
;
;

;




