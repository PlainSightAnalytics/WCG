









CREATE VIEW [cle].[transformFactSightings] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-08-2016
-- Reason				:	Transform view for FactSightings
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-01-2019
-- Reason				:	Added deduplication logic for Camera CTE
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH CameraCTE AS (
	SELECT
		 LaneId					AS LaneId
		,SiteId					AS SiteId
		,CameraID				AS CameraId
		,TrafficCentreGUID		AS TrafficCentreGUID
		,CameraGUID				AS CameraGUID
		,ROW_NUMBER() OVER (PARTITION BY CameraID ORDER BY LaneId, SiteId) AS RowSequence
	FROM WCG_DW.dbo.DimCamera
)


SELECT 
	 CAST(s.CameraId AS VARCHAR(10))													AS [SiteId]
	,CAST(s.LaneId AS VARCHAR(10))														AS [LaneId]
    ,ISNULL(c1.TrafficCentreGUID, c2.TrafficCentreGUID)									AS [TrafficCentreGUID]
    ,ISNULL(c1.CameraGUID, c2.CameraGUID)												AS [CameraGUID]
	,CAST(PartyKey AS VARCHAR(30))														AS [PartyKey]
	,CAST(SightingRecordId AS VARCHAR(15))												AS [SightingRecordId]
	,CAST(
		[TimeStamp] AT TIME ZONE 'South Africa Standard Time' 
		AS DATE)																		AS [SightingDate]
	,CAST(
		FORMAT(
			[TimeStamp] AT TIME ZONE 'South Africa Standard Time'
			,'HH:mm'
		) AS TIME
	 )																					AS [SightingTime]
	,CAST(
		CASE
			WHEN 
				DATEPART(
					HOUR, 
					[TimeStamp] AT TIME ZONE 'South Africa Standard Time'
				) < 6 
			THEN 
				DATEADD(DAY,-1,[TimeStamp] AT TIME ZONE 'South Africa Standard Time')
			ELSE [TimeStamp] AT TIME ZONE 'South Africa Standard Time'
	END AS DATE)																		AS [OperationsDate]
	,CAST(VRN AS VARCHAR(20))															AS [RegistrationNo]
    ,CAST([XCoord] AS NUMERIC(19,2))													AS [LatitudeRange]
	,CAST([YCoord] AS NUMERIC(19,2))													AS [LongitudeRange]
	,DeltaLogKey																		AS [DeltaLogKey]
FROM [WCG_Stage].[cle].[Sightings] s
LEFT JOIN CameraCTE c1 ON s.CameraId = c1.SiteId AND CAST(s.LaneID AS VARCHAR(50)) = c1.LaneId
LEFT JOIN CameraCTE c2 ON REPLACE(s.CameraId,' ','') = c2.CameraId AND c2.RowSequence = 1




























