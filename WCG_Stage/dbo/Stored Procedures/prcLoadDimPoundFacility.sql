CREATE PROCEDURE [dbo].[prcLoadDimPoundFacility]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	04-02-2019
-- Reason				:	Performs SCD Logic for DimPoundFacility using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimPoundFacility] -1
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
	 PoundFacilityID
	,LocalMunicipality
	,PoundFacility
	,TrafficCentre
FROM WCG_STAGE.pnd.transformDimPoundFacility
	)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimPoundFacility dim
USING conf
ON (dim.PoundFacilityID = conf.PoundFacilityID)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 PoundFacilityID
		,LocalMunicipality
		,PoundFacility
		,TrafficCentre
		,InsertAuditKey
		,UpdateAuditKey
			)
	VALUES (
		 conf.PoundFacilityID
		,conf.LocalMunicipality
		,conf.PoundFacility
		,conf.TrafficCentre
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
			dim.LocalMunicipality		  <> conf.LocalMunicipality
		OR	dim.PoundFacility			  <> conf.PoundFacility
		OR	dim.TrafficCentre			  <> conf.TrafficCentre

		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.LocalMunicipality		  = conf.LocalMunicipality,
			dim.PoundFacility			  = conf.PoundFacility,
			dim.TrafficCentre			  = conf.TrafficCentre,
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.pnd.transformDimPoundFacility

