



CREATE VIEW [cle].[transformFactFlaggedVehicleAlerts] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	08-03-2019
-- Reason				:	Transform view for FactFlaggedVehicleAlerts
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH CameraCTE AS (
SELECT
	Route
	,TrafficCentreGUID
	,SiteId
	,LaneId
	,RouteSequence
	,CameraName
	,ROW_NUMBER() OVER (PARTITION BY SiteId, CameraId, TrafficCentreGUID ORDER BY CameraKey DESC) AS RowSequence
FROM WCG_DW.dbo.DimCamera
WHERE Route <> 'Mobile'
AND CameraKey <> -1
)

,LatestSightingsCTE AS (
SELECT
	 s.VRN AS RegistrationNo
	,s.SightingRecordId
	,s.Timestamp AT TIME ZONE 'South Africa Standard Time' AS Timestamp
	,s.XCoord
	,s.YCoord
	,CAST(s.CameraId AS VARCHAR(20)) AS CameraId
	,CAST(s.LaneID AS VARCHAR(20)) AS LaneId
	,c.Route
	,c.RouteSequence
	,ROW_NUMBER() OVER (Partition BY VRN, Route ORDER BY timestamp DESC) AS RowSequence
FROM WCG_STAGE.cle.SightingsLatest s
LEFT JOIN CameraCTE c ON s.CameraId = c.SiteID AND CAST(s.LaneID AS VARCHAR(20)) = c.LaneID
)

,FlaggedVehiclesCTE AS (
SELECT
	 RegistrationNo
	 ,'Fatigue'			AS FlagType
	,COUNT(1)			AS FlagCount
	,MAX(EndTime)		AS LastFlagDateTime
FROM WCG_DW.dbo.DimFlaggedVehicleTrip
WHERE FlagFatique = 'Yes'
AND IsAlertSent = 'No'
GROUP BY RegistrationNo
UNION ALL
SELECT
	 RegistrationNo
	 ,'Speed'			AS FlagType
	,COUNT(1)			AS FlagCount
	,MAX(EndTime)		AS LastFlagDateTime
FROM WCG_DW.dbo.DimFlaggedVehicleTrip
WHERE FlagSpeeding = 'Yes'
AND IsAlertSent = 'No'
GROUP BY RegistrationNo
UNION ALL
SELECT
	 RegistrationNo
	 ,'Cloned'			AS FlagType
	,COUNT(1)			AS FlagCount
	,MAX(EndTime)		AS LastFlagDateTime
FROM WCG_DW.dbo.DimFlaggedVehicleTrip
WHERE FlagCloned = 'Yes'
AND IsAlertSent = 'No'
GROUP BY RegistrationNo
)


SELECT DISTINCT
	 s.RegistrationNo												AS [RegistrationNo]
	,s.SightingRecordId												AS [SightingRecordId]
	,CAST(s.Timestamp AS DATETIME)									AS [SightingDateTime]	
	,CAST(s.Timestamp AS DATE)										AS [SightingDate]
	,CAST(
		CASE
			WHEN 
				DATEPART(HOUR,[TimeStamp]) < 6 
			THEN 
				DATEADD(DAY,-1,[TimeStamp])
			ELSE [TimeStamp]
	END AS DATE)													AS [OperationsDate]
	,CAST(CAST(s.Timestamp AS TIME) AS VARCHAR(5))					AS [SightingTime]
	,s.CameraId														AS [CameraId]
	,s.LaneId														AS [LaneId]
    ,CAST([XCoord] AS NUMERIC(19,2))								AS [LatitudeRange]
	,CAST([YCoord] AS NUMERIC(19,2))								AS [LongitudeRange]
	,c.TrafficCentreGUID											AS [TrafficCentreGUID]
	,f.FlagType														AS [FlagType]
	,f.FlagCount													AS [FlagCount]
	,f.LastFlagDateTime												AS [LastFlagDateTime]
FROM LatestSightingsCTE s
INNER JOIN FlaggedVehiclesCTE f ON s.RegistrationNo = f.RegistrationNo
INNER JOIN CameraCTE c ON s.Route = c.Route
WHERE s.RowSequence = 1
