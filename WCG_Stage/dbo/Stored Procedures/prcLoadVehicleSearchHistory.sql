

CREATE PROCEDURE [dbo].[prcLoadVehicleSearchHistory]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-12-2019
-- Reason				:	Loads latest Vehicle Search data from DW Tables
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	Vehicle Search Data
-- Test					:	[dbo].[prcLoadVehicleSearchHistory] -1, 201909
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey AS INT,
@MonthKey AS INT

AS

PRINT CONCAT('Started at: ',FORMAT(GETDATE(),'yyyyMMdd:hh:mm:ss:ms'))

/* Declare Variables */
DECLARE 
	 @LastSightingRecordId  AS INT
	,@RowCountLoad AS INT
	,@DeltaLogKey AS INT


/* 3. Truncate existing Table */
TRUNCATE TABLE WCG_DW.dbo.VehicleSearch

/* 4. Create new delta */
INSERT INTO WCG_DW.dbo.DimDeltaLog
(ClientName, SchemaName, ObjectName, LoadFlag, LogDate, UniqueIdentifier, InsertAuditKey, UpdateAuditKey)
VALUES ('WCG','dbo','VehicleSearch',0,GETDATE(), CAST(@MonthKey AS VARCHAR(6)), @AuditKey, @AuditKey)

SELECT @DeltaLogKey = @@IDENTITY

/* 4. Extract Vehicle Search data */
;WITH SightingCTE AS (
-- Sigtings in SA time and excluding ESSA-BOF
SELECT
	 'Sighting'																			AS [Source]
	,f.SightingRecordId																	AS [RecordId]
	,CAST(d1.FullDate AS DATETIME) + CAST(d2.FullTime AS DATETIME)						AS [TimeStamp]
	,d3.RegistrationNo																	AS [RegistrationNo]
	,d3.VehicleCategory																	AS [VehicleCategory]
	,d3.VehicleUsage																	AS [VehicleUsage]
    ,d4.Latitude																		AS [Latitude]
	,d4.Longitude																		AS [Longitude]
	,d5.Route																			AS [Route]
	,d5.SpeedSection																	AS [SpeedSection]
	,NULL																				AS [Alerts]
	,NULL																				AS [AverageSpeed]
	,0																					AS [AlertCount]
	,ROW_NUMBER() OVER (PARTITION BY 
							f.VehicleKey, 
							f.SightingDateKey, 
							f.SightingTimeKey
						ORDER BY SightingRecordId)										AS [RowSequence]
FROM WCG_DW.dbo.FactSightings f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimDate d1 WITH (NOLOCK) ON f.SightingDateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimTime d2 WITH (NOLOCK) ON f.SightingTimeKey = d2.TimeKey
LEFT JOIN WCG_DW.dbo.DimVehicle d3 WITH (NOLOCK) ON f.VehicleKey = d3.VehicleKey
LEFT JOIN WCG_DW.dbo.DimGeoLocation d4 WITH (NOLOCK) ON f.GeoLocationKey = d4.GeoLocationKey
LEFT JOIN WCG_DW.dbo.DimCamera d5 WITH (NOLOCK) ON f.CameraKey = d5.CameraKey
WHERE
	f.VehicleKey <> -1
AND d1.CalendarYearMonthKey = @MonthKey
)

,AlertsAllCTE AS (
SELECT
	 CAST(d1.FullDate AS DATETIME) + CAST(d2.FullTime AS DATETIME)						AS [TimeStamp]
	,d3.RegistrationNo																	AS [RegistrationNo]
	,d4.AlertSubType																	AS [AlertSubType]
	,f.AverageSpeed																		AS [AverageSpeed]
	,f.AlertRecordID																	AS [RecordId]
	,ROW_NUMBER() OVER (PARTITION BY 
							f.UpdatedDateKey, 
							f.UpdatedTimeKey, 
							f.VehicleKey, 
							f.AlertTypeKey
						ORDER BY AlertRecordId)											AS [RowSequence]
FROM WCG_DW.dbo.FactAlerts f
LEFT JOIN WCG_DW.dbo.DimDate d1 WITH (NOLOCK) ON f.UpdatedDateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimTime d2 WITH (NOLOCK) ON f.UpdatedTimeKey = d2.TimeKey
LEFT JOIN WCG_DW.dbo.DimVehicle d3 WITH (NOLOCK) ON f.VehicleKey = d3.VehicleKey
LEFT JOIN WCG_DW.dbo.DimAlertType d4 WITH (NOLOCK) ON f.AlertTypeKey = d4.AlertTypeKey
WHERE
	f.VehicleKey <> -1
AND d1.CalendarYearMonthKey = @MonthKey
)

,AlertsCTE AS (
SELECT
	'Alert'																				AS [Source]
	,MIN(RecordID)																		AS [RecordId]
	,[TimeStamp]																		AS [TimeStamp]
	,RegistrationNo																		AS [RegistrationNo]
	,NULL																				AS [VehicleCategory]
	,NULL																				AS [VehicleUsage]
    ,NULL																				AS [Latitude]
	,NULL																				AS [Longitude]
	,NULL																				AS [Route]
	,NULL																				AS [SpeedSection]
	,MIN(AlertSubType)																	AS [Alerts]
	,AVG(AverageSpeed)																	AS [AverageSpeed]
	,COUNT(1)																			AS [AlertCount]
FROM AlertsAllCTE
WHERE RowSequence = 1
GROUP BY [TimeStamp], [RegistrationNo]
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
FROM SightingCTE
WHERE RowSequence = 1
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
FROM AlertsCTE
)

,MatchedCTE AS (
-- Match Alert to Sighting. Partition by Registration if record following Sighting is an alert then its a match
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
	,LEAD(RecordId) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS [AlertRecordId]
	,LEAD(Alerts) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS [Alerts]
	,LEAD(AverageSpeed) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS [AverageSpeed]
	,LEAD(AlertCount) OVER (PARTITION BY RegistrationNo ORDER BY [TimeStamp]) AS [AlertCount]
FROM CombinedCTE
)

/* Now return Sightings with matched alerts */
INSERT INTO WCG_DW.dbo.VehicleSearch(
	 SightingRecordId
	,[TimeStamp]
	,RegistrationNo
	,VehicleCategory
	,VehicleUsage
	,Latitude
	,Longitude
	,Route
	,SpeedSection
	,AlertRecordId
	,AlertCount
	,Alerts
	,AverageSpeed
	,DeltaLogKey
)
SELECT 
	 [RecordId] AS [SightingRecordId]
	,[TimeStamp] 
	,[RegistrationNo]
	,[VehicleCategory]
	,[VehicleUsage]
	,[Latitude]
	,[Longitude]
	,[Route]
	,[SpeedSection]
	,[AlertRecordId]
	,ISNULL(AlertCount,0) AS [AlertCount]
	,[Alerts]
	,[AverageSpeed]
	,@DeltaLogKey
FROM MatchedCTE
WHERE Source = 'Sighting'

SELECT @RowCountLoad = @@ROWCOUNT
SELECT @LastSightingRecordId = MAX(SightingRecordId) FROM WCG_DW.dbo.VehicleSearch

PRINT CONCAT('@RowCountLoad=',CAST(@RowCountLoad AS VARCHAR(10)),' at: ',FORMAT(GETDATE(),'yyyyMMdd:hh:mm:ss:ms'))

IF @RowCountLoad > 0
BEGIN

/* Update DeltaLog */
UPDATE WCG_DW.dbo.DimDeltaLog
SET HighWaterMark = @LastSightingRecordId, RowCountInsert = @RowCountLoad
WHERE DeltaLogKey = @DeltaLogKey

END

PRINT CONCAT('Completed at: ',FORMAT(GETDATE(),'yyyyMMdd:hh:mm:ss:ms'))