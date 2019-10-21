

CREATE PROCEDURE [dbo].[prcLoadDimGeoLocation]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	18 June 2016
-- Reason				:	Performs SCD Logic for DimGeoLocation using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimGeoLocation] -1, -1
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

WITH conf AS (
SELECT
	 LongitudeRange
	,LatitudeRange
	,Longitude
	,Latitude
FROM WCG_STAGE.cle.transformDimGeoLocation
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimGeoLocation dim
USING conf
ON (dim.[LongitudeRange] = conf.[LongitudeRange] AND dim.[LatitudeRange] = conf.[LatitudeRange])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			[LongitudeRange], [LatitudeRange], [Longitude], [Latitude],
			DeltaLogKey, InsertAuditKey, UpdateAuditKey
			)
	VALUES (
			conf.[LongitudeRange], conf.[LatitudeRange], conf.[Longitude], conf.[Latitude],
			@DeltaLogKey, @AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[Longitude] <> conf.[Longitude]
		OR dim.[Latitude] <> conf.[Latitude]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[Longitude] = conf.[Longitude],
			dim.[Latitude] = conf.[Latitude],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.cle.transformDimGeoLocation WHERE DeltaLogKey = @DeltaLogKey





;
;
;



;