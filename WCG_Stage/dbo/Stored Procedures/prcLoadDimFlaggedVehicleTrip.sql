CREATE PROCEDURE [dbo].[prcLoadDimFlaggedVehicleTrip]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	07-03-2019
-- Reason				:	Performs SCD Logic for DimFlaggedVehicleTrip using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimFlaggedVehicleTrip] -1
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
	 AverageSpeed
	,EndTime
	,FlagCloned
	,FlagFatique
	,FlagSpeeding
	,FlagTurnaround
	,FromToCamera
	,PreviousEndTime
	,PreviousToCurrentActualDuration
	,PreviousToCurrentCamera
	,PreviousToCurrentDistance
	,PreviousToCurrentExpectedDuration
	,PreviousToCurrentImpliedSpeed
	,RegistrationNo
	,Route
	,StartTime
	,TotalDistance
	,TripDuration
	,TurnaroundHours
FROM WCG_STAGE.cle.transformDimFlaggedVehicleTrip
WHERE RowSequence = 1
	)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimFlaggedVehicleTrip dim
USING conf
ON (dim.RegistrationNo = conf.RegistrationNo AND dim.StartTime = conf.StartTime)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 AverageSpeed
		,EndTime
		,FlagCloned
		,FlagFatique
		,FlagSpeeding
		,FlagTurnaround
		,FromToCamera
		,PreviousEndTime
		,PreviousToCurrentActualDuration
		,PreviousToCurrentCamera
		,PreviousToCurrentDistance
		,PreviousToCurrentExpectedDuration
		,PreviousToCurrentImpliedSpeed
		,RegistrationNo
		,Route
		,StartTime
		,TotalDistance
		,TripDuration
		,TurnaroundHours
		,InsertAuditKey
		,UpdateAuditKey
			)
	VALUES (
		 conf.AverageSpeed
		,conf.EndTime
		,conf.FlagCloned
		,conf.FlagFatique
		,conf.FlagSpeeding
		,conf.FlagTurnaround
		,conf.FromToCamera
		,conf.PreviousEndTime
		,conf.PreviousToCurrentActualDuration
		,conf.PreviousToCurrentCamera
		,conf.PreviousToCurrentDistance
		,conf.PreviousToCurrentExpectedDuration
		,conf.PreviousToCurrentImpliedSpeed
		,conf.RegistrationNo
		,conf.Route
		,conf.StartTime
		,conf.TotalDistance
		,conf.TripDuration
		,conf.TurnaroundHours
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
			ISNULL(dim.AverageSpeed,0)									<> ISNULL(conf.AverageSpeed,0)
		OR	ISNULL(dim.EndTime,'')										<> ISNULL(conf.EndTime,'')
		OR	dim.FlagCloned												<> conf.FlagCloned
		OR	dim.FlagFatique												<> conf.FlagFatique
		OR	dim.FlagSpeeding											<> conf.FlagSpeeding
		OR	dim.FlagTurnaround											<> conf.FlagTurnaround
		OR	dim.FromToCamera											<> conf.FromToCamera
		OR	ISNULL(dim.PreviousEndTime,'')								<> ISNULL(conf.PreviousEndTime,'')
		OR	ISNULL(dim.PreviousToCurrentActualDuration,0)				<> ISNULL(conf.PreviousToCurrentActualDuration,0)
		OR	ISNULL(dim.PreviousToCurrentCamera,'')						<> ISNULL(conf.PreviousToCurrentCamera,'')
		OR	ISNULL(dim.PreviousToCurrentDistance,0)					<> ISNULL(conf.PreviousToCurrentDistance,0)
		OR	ISNULL(dim.PreviousToCurrentExpectedDuration,0)			<> ISNULL(conf.PreviousToCurrentExpectedDuration,0)
		OR	ISNULL(dim.PreviousToCurrentImpliedSpeed,0)				<> ISNULL(conf.PreviousToCurrentImpliedSpeed,0)
		OR	dim.RegistrationNo											<> conf.RegistrationNo
		OR	dim.Route													<> conf.Route
		OR	ISNULL(dim.StartTime,'')									<> ISNULL(conf.StartTime,'')
		OR	ISNULL(dim.TotalDistance,0)								<> ISNULL(conf.TotalDistance,0)
		OR	ISNULL(dim.TripDuration,0)									<> ISNULL(conf.TripDuration,0)
		OR	ISNULL(dim.TurnaroundHours,0)								<> ISNULL(conf.TurnaroundHours,0)
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.AverageSpeed												= conf.AverageSpeed,
			dim.EndTime														= conf.EndTime,
			dim.FlagCloned													= conf.FlagCloned,
			dim.FlagFatique													= conf.FlagFatique,
			dim.FlagSpeeding												= conf.FlagSpeeding,
			dim.FlagTurnaround												= conf.FlagTurnaround,
			dim.FromToCamera												= conf.FromToCamera,
			dim.PreviousEndTime												= conf.PreviousEndTime,
			dim.PreviousToCurrentActualDuration								= conf.PreviousToCurrentActualDuration,
			dim.PreviousToCurrentCamera										= conf.PreviousToCurrentCamera,
			dim.PreviousToCurrentDistance									= conf.PreviousToCurrentDistance,
			dim.PreviousToCurrentExpectedDuration							= conf.PreviousToCurrentExpectedDuration,
			dim.PreviousToCurrentImpliedSpeed								= conf.PreviousToCurrentImpliedSpeed,
			dim.RegistrationNo												= conf.RegistrationNo,
			dim.Route														= conf.Route,
			dim.StartTime													= conf.StartTime,
			dim.TotalDistance												= conf.TotalDistance,
			dim.TripDuration												= conf.TripDuration,
			dim.TurnaroundHours												= conf.TurnaroundHours,
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.cle.transformFlaggedVehicles

