

CREATE VIEW [cle].[transformDimFlaggedVehicleTrip] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	07-03-2019
-- Reason				:	Transform view for DimFlaggedVehicleTrip
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 CAST(AverageSpeed AS NUMERIC(11,6))					AS AverageSpeed
	,CAST(EndTime AS DATETIME)								AS EndTime
	,CAST(FlagCloned AS VARCHAR(3))							AS FlagCloned
	,CAST(FlagFatique AS VARCHAR(3))						AS FlagFatique
	,CAST(FlagSpeeding AS VARCHAR(3))						AS FlagSpeeding
	,CAST(FlagTurnaround AS VARCHAR(3))						AS FlagTurnaround
	,CAST(FromToCamera AS VARCHAR(100))						AS FromToCamera
	,CAST(PreviousEndTime AS DATETIME)						AS PreviousEndTime
	,CAST(PreviousToCurrentActualDuration AS INT)			AS PreviousToCurrentActualDuration
	,CAST(PreviousToCurrentCamera AS VARCHAR(100))			AS PreviousToCurrentCamera
	,CAST(PreviousToCurrentDistance	AS INT)					AS PreviousToCurrentDistance
	,CAST(PreviousToCurrentExpectedDuration AS INT)			AS PreviousToCurrentExpectedDuration
	,CAST(PreviousToCurrentImpliedSpeed	AS NUMERIC(11,6))	AS PreviousToCurrentImpliedSpeed
	,CAST(RegistrationNo AS VARCHAR(20))					AS RegistrationNo
	,CAST(Route	AS VARCHAR(30))								AS Route
	,CAST(StartTime	AS DATETIME)							AS StartTime
	,CAST(TotalDistance	AS INT)								AS TotalDistance
	,CAST(TripDuration AS INT)								AS TripDuration
	,CAST(TurnaroundHours AS INT)							AS TurnaroundHours
	,ROW_NUMBER() OVER (
		PARTITION BY RegistrationNo, StartTime 
		ORDER BY EndTime DESC)								AS RowSequence
FROM WCG_STAGE.cle.transformFlaggedVehicles


