



CREATE VIEW [dbo].[VehicleSearchStage] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-12-2019
-- Reason				:	Stage data for Alerts and Sightings for Vehicle Search Utility
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

WITH CameraCTE AS (
	SELECT
		 LaneId					AS LaneId
		,SiteId					AS SiteId
		,CameraID				AS CameraId
		,Route					AS Route
		,SpeedSection			AS SpeedSection
		,ROW_NUMBER() OVER (PARTITION BY CameraID ORDER BY LaneId, SiteId) AS RowSequence
	FROM WCG_DW.dbo.DimCamera WITH (NOLOCK)
)

,SightingCTE AS (
-- Sigtings in SA time and excluding ESSA-BOF
SELECT
	 'Sighting'																			AS [Source]
	,CAST(SightingRecordId AS VARCHAR(15))												AS [RecordId]
	,CAST(
		[TimeStamp] AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)																	AS [TimeStamp]				/* Convert to SA Time */
	,CAST(VRN AS VARCHAR(20))															AS [RegistrationNo]
	,NULL																				AS [VehicleCategory]
	,NULL																				AS [VehicleUsage]
    ,CAST([XCoord] AS NUMERIC(19,6))													AS [Latitude]
	,CAST([YCoord] AS NUMERIC(19,6))													AS [Longitude]
	,ISNULL(c1.Route,c2.Route)															AS [Route]
	,ISNULL(c1.SpeedSection,c2.SpeedSection)											AS [SpeedSection]
	,NULL																				AS [Alerts]
	,NULL																				AS [AverageSpeed]
	,0																					AS [AlertCount]
	,s.DeltaLogKey																		AS [DeltaLogKey]
FROM WCG_Stage.cle.SightingsSlice s WITH (NOLOCK)
LEFT JOIN CameraCTE c1 ON s.CameraId = c1.SiteId AND CAST(s.LaneID AS VARCHAR(50)) = c1.LaneId
LEFT JOIN CameraCTE c2 ON REPLACE(s.CameraId,' ','') = c2.CameraId AND c2.RowSequence = 1
WHERE ProviderId <> 'ESSA-BOF'																						/* Exclude Sightings from ESSA-BOF */	
)

,AlertsAllCTE AS (
SELECT
	 CAST(
		AlertDateTime AT TIME ZONE 'South Africa Standard Time' 
		AS DATETIME)																	AS [TimeStamp]				/* Convert to SA Time */
	,CAST(VRN AS VARCHAR(20))															AS [RegistrationNo]
	,CAST(VehicleCategory AS VARCHAR(50))												AS [VehicleCategory]
	,CAST(VehicleUsage AS VARCHAR(50))													AS [VehicleUsage]																		
	,CAST([Latitude] AS NUMERIC(19,6))													AS [Latitude]
	,CAST([Longitude] AS NUMERIC(19,6))													AS [Longitude]
	,ISNULL(c1.Route,c2.Route)															AS [Route]
	,ISNULL(c1.SpeedSection,c2.SpeedSection)											AS [SpeedSection]
	,AlertSubType																		AS [AlertSubType]
	,AverageKmh																			AS [AverageSpeed]
	,CAST(AlertRecordID AS VARCHAR(15))													AS [RecordId]
	,a.DeltaLogKey																		AS [DeltaLogKey]
	,ROW_NUMBER() OVER (PARTITION BY 
							AlertDateTime, 
							VRN, 
							AlertSubType
						ORDER BY AlertRecordId)											AS [RowSequence]
FROM WCG_Stage.cle.AlertsSlice a WITH (NOLOCK)
LEFT JOIN CameraCTE c1 ON a.DeviceId = c1.SiteId AND a.Lane = c1.LaneId
LEFT JOIN CameraCTE c2 ON REPLACE(a.DeviceId,' ','') = c2.CameraId AND c2.RowSequence = 1
)

,AlertsCTE AS (
-- Alerts in SA time and rolled up to VRN, datetime and lat/long
SELECT
	'Alert'																				AS [Source]
	,MIN(RecordId)																		AS [RecordId]
	,[TimeStamp]																		AS [TimeStamp]				
	,[RegistrationNo]																	AS [RegistrationNo]	
	,[VehicleCategory]																	AS [VehicleCategory]
	,[VehicleUsage]																		AS [VehicleUsage]																		
	,[Latitude]																			AS [Latitude]
	,[Longitude]																		AS [Longitude]
	,[Route]																			AS [Route]
	,[SpeedSection]																		AS [SpeedSection]
	,MIN(AlertSubType)																	AS [Alerts]	
	,AVG([AverageSpeed])																AS [AverageSpeed]
	,COUNT(1)																			AS [AlertCount]
	,0																					AS [DeltaLogKey]
FROM AlertsAllCTE
WHERE RowSequence = 1
GROUP BY [TimeStamp], [RegistrationNo], [Latitude], [Longitude], [Route], [SpeedSection], VehicleCategory, VehicleUsage																
)

,CombinedCTE AS (	
-- Combine Sightings and Alerts into one stream				
SELECT
	 [Source]
	,[RecordId]
	,[TimeStamp]		
	,[RegistrationNo]
	,[VehicleCategory]
	,[VehicleUsage]
	,[Latitude]
	,[Longitude]
	,[Route]
	,[SpeedSection]
	,[Alerts]
	,[AverageSpeed]
	,[AlertCount]
	,[DeltaLogKey]
FROM SightingCTE
UNION ALL
SELECT
	 [Source]
	,[RecordId]
	,[TimeStamp]		
	,[RegistrationNo]
	,[VehicleCategory]
	,[VehicleUsage]
	,[Latitude]
	,[Longitude]
	,[Route]
	,[SpeedSection]
	,[Alerts]
	,[AverageSpeed]
	,[AlertCount]
	,[DeltaLogKey]
FROM AlertsCTE
)

,MatchedCTE AS (
-- Match Alert to Sighting. Partition by Registration if record following Sighting is an alert then its a match
SELECT 
	 [Source]
	,[RecordId] AS [SightingRecordId]
	,[TimeStamp]		
	,[RegistrationNo]
	,LEAD([VehicleCategory]) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS VehicleCategory
	,LEAD([VehicleUsage]) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS VehicleUsage
	,[Latitude]
	,[Longitude]
	,[Route]
	,[SpeedSection]
	,[DeltaLogKey]
	,LEAD(RecordId) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS [AlertRecordId]
	,LEAD(Alerts) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS Alerts
	,LEAD(AverageSpeed) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS AverageSpeed
	,LEAD(AlertCount) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS AlertCount
FROM CombinedCTE
)

/* Now return Sightings with matched alerts */
SELECT 
	 SightingRecordId
	,[TimeStamp]
	,[RegistrationNo]
	,[VehicleCategory]
	,[VehicleUsage]
	,[Latitude]
	,[Longitude]
	,[Route]
	,[SpeedSection]
	,[AlertRecordId]
	,ISNULL(AlertCount,0) AS AlertCount
	,Alerts
	,AverageSpeed
	,DeltaLogKey
FROM MatchedCTE
WHERE Source = 'Sighting'