CREATE PROCEDURE [dbo].[prcLoadDimVehicleCommon]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	04-02-2019
-- Reason				:	Performs SCD Logic for DimVehicle using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey, @SchemaName
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimVehicleTrafficControlEvent] -1, -1, 'pnd'
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT = -1,
@SchemaName VARCHAR(10)

AS

SET FMTONLY OFF
SET NOCOUNT ON

DECLARE
@RowCountInsert INT,
@RowCountUpdate INT,
@RowCountExtract INT

DECLARE @RowCounts TABLE
(mergeAction varchar(10));


IF @SchemaName = 'pnd'
BEGIN

	WITH conf AS (
	SELECT
	 Colour
	,Make
	,Model
	,RegistrationNo
	,VehicleCategory
	FROM WCG_STAGE.pnd.transformDimVehicle 
	WHERE DeltaLogKey = @DeltaLogKey
	AND RowSequence = 1
	)

	/* Handle SCD1 Changes */
	MERGE INTO WCG_DW.dbo.DimVehicle dim
	USING conf 
	ON (dim.[RegistrationNo] = conf.[RegistrationNo] COLLATE DATABASE_DEFAULT) 
	WHEN NOT MATCHED THEN /* New Records */
		INSERT (
				 Colour
				,Make
				,Model
				,RegistrationNo
				,VehicleCategory
				,DeltaLogKey
				,InsertAuditKey
				,UpdateAuditKey
				)
		VALUES (
				 conf.Colour
				,conf.Make
				,conf.Model
				,conf.RegistrationNo
				,conf.VehicleCategory
				,@DeltaLogKey
				,@AuditKey
				,@AuditKey
				)
		--WHEN MATCHED 
		--AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
		--AND (
		--	   (dim.Colour = 'Unknown' AND conf.Colour <> 'Unknown')
		--	OR (dim.Make = 'Unknown' AND conf.Make <> 'Unknown')
		--	OR (dim.Model = 'Unknown' AND conf.Model <> 'Unknown')
		--	OR (dim.VehicleUsage = 'Unknown' AND conf.VehicleUsage <> 'Unknown')
		--	) 	/* Check if any Type 1 Fields have changed */
		--THEN 
		--	UPDATE 
		--	SET 
		--		/* Update Type 1 Fields */
		--		dim.Colour =		CASE WHEN dim.Colour = 'Unknown' THEN conf.Colour COLLATE DATABASE_DEFAULT ELSE dim.Colour END,
		--		dim.Make =			CASE WHEN dim.Make = 'Unknown' THEN conf.Make COLLATE DATABASE_DEFAULT ELSE dim.Make END,
		--		dim.Model =			CASE WHEN dim.Model = 'Unknown' THEN conf.Model COLLATE DATABASE_DEFAULT ELSE dim.Model END,
		--		dim.VehicleUsage =	CASE WHEN dim.VehicleUsage = 'Unknown' THEN conf.VehicleUsage COLLATE DATABASE_DEFAULT ELSE dim.VehicleUsage END,
		--		/* Update System Fields */
		--		dim.UpdateAuditKey = @AuditKey,
		--		dim.RowIsInferred = 'N',
		--		dim.RowChangeReason = 
		--			CASE 
		--				WHEN dim.RowIsInferred = 'Y' THEN 'Inferred Member Arrived'
		--				ELSE 'SCD Type 1 Change'
		--			END
		OUTPUT $action into @rowcounts;			

		SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
		SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
		SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.pnd.transformDimVehicle WHERE DeltaLogKey = @DeltaLogKey AND RowSequence = 1
	
	END

/* Update Delta Log */
--UPDATE WCG_DW.dbo.DimDeltaLog
--SET 
--	LoadFlag = 1, 
--	RowCountInsert = @RowCountInsert, 
--	UpdateAuditKey = @AuditKey
--WHERE DeltaLogKey = @DeltaLogKey;
