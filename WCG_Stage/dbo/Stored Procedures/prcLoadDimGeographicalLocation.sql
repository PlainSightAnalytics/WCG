CREATE PROCEDURE [dbo].[prcLoadDimGeographicalLocation]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	30-11-2019
-- Reason				:	Performs SCD Logic for DimGeographicalLocation using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimGeographicalLocation] -1, -1
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


/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimGeographicalLocation dim
USING dbo.conformDimGeographicalLocation conf
ON (dim.[Longitude] = conf.[Longitude] AND dim.[Latitude] = conf.[Latitude])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 Latitude
			,LatitudeRange
			,LocationName
			,LocationType
			,Longitude
			,LongitudeRange
			,Source
			,DeltaLogKey
			,InsertAuditKey
			,UpdateAuditKey
			)
	VALUES (
			 conf.Latitude
			,conf.LatitudeRange
			,conf.LocationName
			,conf.LocationType
			,conf.Longitude
			,conf.LongitudeRange
			,conf.Source
			,conf.DeltaLogKey
			,@AuditKey
			,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[LocationName] <> conf.[LocationName]
		OR dim.[LocationType] <> conf.[LocationType]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[LocationName] = conf.[LocationName],
			dim.[LocationType] = conf.[LocationType],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.dbo.conformDimGeographicalLocation





;
;
;



;