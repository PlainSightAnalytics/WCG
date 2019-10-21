CREATE PROCEDURE [dbo].[prcLoadDimShiftLocation]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-10-2018
-- Reason				:	Performs SCD Logic for DimShiftLocation using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimShiftLocation] -1, -1
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
	 Latitude
	,LocationType
	,Longitude
	,RoadNumber
	,ShiftLocation
	,ShiftLocationID
	,TrafficCentre
	,DeltaLogKey
FROM WCG_STAGE.itis.transformDimShiftLocation
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimShiftLocation dim
USING conf
ON (dim.[ShiftLocationID] = conf.[ShiftLocationID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 Latitude
		,LocationType
		,Longitude
		,RoadNumber
		,ShiftLocation
		,ShiftLocationID
		,TrafficCentre
		,InsertAuditKey
		,UpdateAuditKey
			)
	VALUES (
		 conf.Latitude
		,conf.LocationType
		,conf.Longitude
		,conf.RoadNumber
		,conf.ShiftLocation
		,conf.ShiftLocationID
		,conf.TrafficCentre
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.Latitude			<> conf.Latitude			 
		OR dim.LocationType		<> conf.LocationType		
		OR dim.Longitude		<> conf.Longitude		
		OR dim.RoadNumber		<> conf.RoadNumber		
		OR dim.ShiftLocation	<> conf.ShiftLocation	
		OR dim.TrafficCentre	<> conf.TrafficCentre	

		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.Latitude			= conf.Latitude,			 
			dim.LocationType		= conf.LocationType,		
			dim.Longitude			= conf.Longitude,		
			dim.RoadNumber			= conf.RoadNumber,		
			dim.ShiftLocation		= conf.ShiftLocation,	
			dim.TrafficCentre		= conf.TrafficCentre,	
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimShiftLocation

