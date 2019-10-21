
CREATE PROCEDURE [dbo].[prcLoadDimCamera]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	28-04-2016
-- Reason				:	Performs SCD Logic for DimCamera using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimCamera] -1
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
	 CameraGUID
	,CameraId
	,CameraLocation
	,CameraName
	,IsCountedInReport
	,IsMobileCamera
	,OperationalAreaGUID
	,OperationalArea
	,LaneId
	,SiteId
	,SpeedSection
	,SpeedSectionDescription
	,SpeedSectionDistance
	,SpeedSectionPoint
	,TrafficCentreGUID
	,TrafficCentre
	,TravelDirection
	,Route
	,RouteSequence
	,DistanceFromPreviousCamera
FROM WCG_STAGE.itis.transformDimCamera
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimCamera dim
USING  conf
ON (dim.CameraGUID = conf.CameraGUID)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 CameraGUID
		,CameraId
		,CameraLocation
		,CameraName
		,IsCountedInReport
		,IsMobileCamera
		,OperationalAreaGUID
		,OperationalArea
		,LaneId
		,SiteId
		,SpeedSection
		--,SpeedSectionDescription
		--,SpeedSectionDistance
		--,SpeedSectionPoint
		,TrafficCentreGUID
		,TrafficCentre
		,TravelDirection
		,Route
		,RouteSequence
		,DistanceFromPreviousCamera
		,InsertAuditKey
		,UpdateAuditKey
			)
	VALUES (
		 conf.CameraGUID
		,conf.CameraId
		,conf.CameraLocation
		,conf.CameraName
		,conf.IsCountedInReport
		,conf.IsMobileCamera
		,conf.OperationalAreaGUID
		,conf.OperationalArea
		,conf.LaneId
		,conf.SiteId
		,conf.SpeedSection
		--,conf.SpeedSectionDescription
		--,conf.SpeedSectionDistance
		--,conf.SpeedSectionPoint
		,conf.TrafficCentreGUID
		,conf.TrafficCentre
		,conf.TravelDirection
		,conf.Route
		,conf.RouteSequence
		,conf.DistanceFromPreviousCamera
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		dim.CameraId <> conf.CameraId
	OR	dim.CameraLocation <> conf.CameraLocation
	OR	dim.CameraName <> conf.CameraName
	OR	dim.IsCountedInReport <> conf.IsCountedInReport
	OR  dim.IsMobileCamera <> conf.IsMobileCamera
	OR	dim.OperationalAreaGUID <>	conf.OperationalAreaGUID
	OR	dim.OperationalArea <>	conf.OperationalArea
	OR	dim.LaneId <> conf.LaneId
	OR	dim.SiteId <> conf.SiteId
	OR	dim.SpeedSection <> conf.SpeedSection
	--OR	dim.SpeedSectionDescription <> conf.SpeedSectionDescription
	--OR	dim.SpeedSectionDistance <> conf.SpeedSectionDistance
	--OR	dim.SpeedSectionPoint <> conf.SpeedSectionPoint
	OR	dim.TrafficCentreGUID <> conf.TrafficCentreGUID
	OR	dim.TrafficCentre <> conf.TrafficCentre
	OR	dim.TravelDirection <> conf.TravelDirection
	OR	dim.Route <> conf.Route
	OR	dim.RouteSequence <> conf.RouteSequence
	OR	dim.DistanceFromPreviousCamera <> conf.DistanceFromPreviousCamera
	)
 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.CameraId = conf.CameraId,
			dim.CameraLocation = conf.CameraLocation,
			dim.CameraName = conf.CameraName,
			dim.IsCountedInReport = conf.IsCountedInReport,
			dim.IsMobileCamera = conf.IsMobileCamera,
			dim.OperationalAreaGUID = conf.OperationalAreaGUID,
			dim.OperationalArea = conf.OperationalArea,
			dim.LaneId = conf.LaneId,
			dim.SiteId = conf.SiteId,
			dim.SpeedSection = conf.SpeedSection,
			--dim.SpeedSectionDescription = conf.SpeedSectionDescription,
			--dim.SpeedSectionDistance = conf.SpeedSectionDistance,
			--dim.SpeedSectionPoint = conf.SpeedSectionPoint,
			dim.TrafficCentreGUID = conf.TrafficCentreGUID,
			dim.TrafficCentre = conf.TrafficCentre,
			dim.TravelDirection = conf.TravelDirection,
			dim.Route = conf.Route,
			dim.RouteSequence = conf.RouteSequence,
			dim.DistanceFromPreviousCamera = conf.DistanceFromPreviousCamera,
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimCamera

;




