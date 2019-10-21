
























CREATE VIEW [cle].[transformFactAlerts] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	05-08-2016
-- Reason				:	Transform view for Fact Alerts
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	12-05-2018
-- Reason				:	New source for camera and traffic centre, time zone set to RSA, add id fields
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-01-2019
-- Reason				:	Added deduplication logic for Camera CTE
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	12-07-2019
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
	CAST(
		CONVERT(
			CHAR(5),
			AlertDateTime AT TIME ZONE 'South Africa Standard Time',
			108) AS TIME)													AS [UpdatedTime]
	,CAST(
		AlertDateTime AT TIME ZONE 'South Africa Standard Time' 
		AS DATE)															AS [UpdatedDate]
	,CAST(
		CASE
			WHEN 
				DATEPART(
					HOUR, 
					AlertDateTime AT TIME ZONE 'South Africa Standard Time'
				) < 6 
			THEN 
				DATEADD(DAY,-1,AlertDateTime AT TIME ZONE 'South Africa Standard Time')
			ELSE AlertDateTime AT TIME ZONE 'South Africa Standard Time'
	END AS DATE)															AS [OperationsDate]
	,ISNULL(c1.TrafficCentreGUID, c2.TrafficCentreGUID)						AS [TrafficCentreGUID]
	,ISNULL(c1.CameraGUID, c2.CameraGUID)									AS [CameraGUID]
	,CAST(DeviceId AS VARCHAR(50))											AS [SiteId]
	,CAST(Lane AS VARCHAR(10))												AS [LaneId]
	--GeoLocation Lookup Columns
	,CAST([Longitude] AS NUMERIC(19,2))										AS [LongitudeRange]
	,CAST([Latitude] AS NUMERIC(19,2))										AS [LatitudeRange]
	--AlertType Lookup Columns
	,CASE 
		WHEN [AlertSubTypeCode] = '' THEN 'Unknown' 
		ELSE ISNULL(AlertSubTypeCode, 'Unknown') 
	END																		AS AlertSubtypeCode
	,CASE 
		WHEN AlertTypeId = '' THEN -1 
		ELSE CAST(ISNULL(AlertTypeId,-1) AS INT) 
	END																		AS AlertTypeID
	,CAST(VRN AS VARCHAR(20))												AS RegistrationNo																			
	--Degenerate Dimensions
	,CAST(
		CASE 
			WHEN SourceSystemId='' THEN 'Unknown' 
			ELSE ISNULL(SourceSystemId, 'Unknown') 
		END AS VARCHAR(50))													AS [SourceSystem]
	,CASE 
		WHEN AlertStatusDescription = '' THEN 'Unknown' 
		ELSE ISNULL(AlertStatusDescription,'Unknown') 
	END																		AS [AlertStatus]
	,CAST(
		CASE 
			WHEN VehicleCategory = '' THEN 'Unknown'							
			ELSE ISNULL(VehicleCategory,'Unknown') 
	END AS VARCHAR(50))														AS [VehicleCategory]
	,CAST(
		CASE 
			WHEN VehicleCategoryCode = '' THEN '0' 
			ELSE ISNULL(VehicleCategoryCode,'0') 
	END AS VARCHAR(30))														AS VehicleCategoryCode
	,CAST(
		CASE 
			WHEN VehicleUsage = '' THEN 'Unknown' 
			ELSE ISNULL(VehicleUsage,'Unknown') 
	END AS VARCHAR(50))														AS [VehicleUsage]
	,CAST(
		CASE	
			WHEN VehicleUsageCode = '' THEN -1 
			ELSE CAST(ISNULL(VehicleUsageCode,-1) AS INT) 
	END	AS VARCHAR(30))														AS [VehicleUsageCode]
	,CAST(
		CASE 
			WHEN VehicleSpeedClassCode ='' THEN '0' 
			ELSE ISNULL(VehicleSpeedClassCode,'0') 
	END	AS VARCHAR(30))														AS [SpeedClassCode]
	-- Measures
	,DATEDIFF(
		MINUTE,
		PrimarySightingDateTime AT TIME ZONE 'South Africa Standard Time',
		AlertDateTime AT TIME ZONE 'South Africa Standard Time')			AS DurationPrimary
	,DATEDIFF(
		MINUTE,
		AlertDateTime AT TIME ZONE 'South Africa Standard Time',
		StorageDate AT TIME ZONE 'South Africa Standard Time')				AS DurationAlert
	,CAST(ISNULL(AverageKmh,0) AS INT)										AS [AverageSpeed]
	,CAST(SpeedLimit AS INT)												AS [SpeedLimit]
	,AlertRecordId															AS [AlertRecordId]
	,AlertId																AS [SourceAlertID]
	,DeltaLogKey															AS [DeltaLogKey]
FROM [WCG_Stage].[cle].[alerts] a
LEFT JOIN CameraCTE c1 ON a.DeviceId = c1.SiteId AND a.Lane = c1.LaneId
LEFT JOIN CameraCTE c2 ON REPLACE(a.DeviceId,' ','') = c2.CameraId AND c2.RowSequence = 1































