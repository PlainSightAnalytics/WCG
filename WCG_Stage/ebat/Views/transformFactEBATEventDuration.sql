





CREATE VIEW [ebat].[transformFactEBATEventDuration] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-10-2017
-- Reason				:	Transform view for EBAT Event Duration (derived from ebat_report)
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	15-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH ebat_reportCTE AS (

SELECT 
	 [id]
	,[ebat_device_id]												
	,[magistrates_court_id]										
	,[officer_id]													
	,[operator_id]												
	,CAST([reading_timestamp] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [reading_timestamp]
	,CAST([time_of_arrest] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [time_of_arrest]
	,CAST([time_of_arrival] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [time_of_arrival]
	,CAST([time_of_departure] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [time_of_departure]
	,CAST([time_of_reading_start] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [time_of_reading_start]
	,CAST([time_of_reading_stop] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [time_of_reading_stop]
	,[registered_by_id]
	,CAST([created_at] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [created_at]
	,[reading_by_id]
	,[completed_by_id]
	,CAST([admin_timestamp] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [admin_timestamp]
	,[verified_by_id]
	,CAST([verified_at] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [verified_at]
	,er.DeltaLogKey
FROM [WCG_Stage].[ebat].[ebat_report] er WITH (NOLOCK)
)

,EventsCTE AS (
	SELECT 
		 [ebat_device_id]						AS EBATDeviceID
		,'1'									AS EBATEventID
		,'Arrest'								AS EBATEvent
		,id										AS UniqueId
		,officer_id								AS EBATRolePlayerID
		,'OFFICER'								AS EBATRole
		,time_of_arrest							AS EventDateTime
		,CAST(time_of_arrest AS DATE)			AS EventDate
		,CAST(time_of_arrest AS TIME)			AS EventTime
		,magistrates_court_id					AS MagistratesCourtID
		,officer_id								AS OfficerID
		,operator_id							AS OperatorID
		,Deltalogkey							AS DeltaLogKey
	FROM ebat_reportCTE
	WHERE time_of_arrest IS NOT NULL

	UNION ALL

	SELECT 
		 [ebat_device_id]						AS EBATDeviceID
		,'2'									AS EBATEventID
		,'Arrival'								AS EBATEvent
		,id										AS UniqueId
		,officer_id								AS EBATRolePlayerID
		,'OFFICER'								AS EBATRole
		,time_of_arrival						AS EventDateTime
		,CAST(time_of_arrival AS DATE)			AS EventDate
		,CAST(time_of_arrival AS TIME)			AS EventTime
		,magistrates_court_id					AS MagistratesCourtID
		,officer_id								AS OfficerID
		,operator_id							AS OperatorID
		,Deltalogkey							AS DeltaLogKey
	FROM ebat_reportCTE
	WHERE time_of_arrival IS NOT NULL

	UNION ALL

	SELECT 
		 [ebat_device_id]						AS EBATDeviceID
		,'3'									AS EBATEventID
		,'Registered'							AS EBATEvent
		,id										AS UniqueId
		,registered_by_id						AS EBATRolePlayerID
		,'ADMINISTRATOR'						AS EBATRole
		,created_at								AS EventDateTime
		,CAST(created_at AS DATE)				AS EventDate
		,CAST(created_at AS TIME)				AS EventTime
		,magistrates_court_id					AS MagistratesCourtID
		,officer_id								AS OfficerID
		,operator_id							AS OperatorID
		,Deltalogkey							AS DeltaLogKey
	FROM ebat_reportCTE
	WHERE created_at IS  NOT NULL

	UNION ALL

	SELECT 
		 [ebat_device_id]						AS EBATDeviceID
		,'4'									AS EBATEventID
		,'Reading Start'						AS EBATEvent
		,id										AS UniqueId
		,operator_id							AS EBATRolePlayerID
		,'OPERATOR'								AS EBATRole
		,time_of_reading_start					AS EventDateTime
		,CAST(time_of_reading_start AS DATE)	AS EventDate
		,CAST(time_of_reading_start AS TIME)	AS EventTime
		,magistrates_court_id					AS MagistratesCourtID
		,officer_id								AS OfficerID
		,operator_id							AS OperatorID
		,Deltalogkey							AS DeltaLogKey
	FROM ebat_reportCTE
	WHERE time_of_reading_start IS NOT NULL

	UNION ALL

	SELECT 
		 [ebat_device_id]						AS EBATDeviceID
		,'5'									AS EBATEventID
		,'Reading End'							AS EBATEvent
		,id										AS UniqueId
		,operator_id							AS EBATRolePlayerID
		,'OPERATOR'								AS EBATRole
		,time_of_reading_stop					AS EventDateTime
		,CAST(time_of_reading_stop AS DATE)		AS EventDate
		,CAST(time_of_reading_stop AS TIME)		AS EventTime
		,magistrates_court_id					AS MagistratesCourtID
		,officer_id								AS OfficerID
		,operator_id							AS OperatorID
		,Deltalogkey							AS DeltaLogKey
	FROM ebat_reportCTE
	WHERE time_of_reading_stop IS NOT NULL

	UNION ALL

	SELECT 
		 [ebat_device_id]						AS EBATDeviceID
		,'6'									AS EBATEventID
		,'Reading Recorded'						AS EBATEvent
		,id										AS UniqueId
		,reading_by_id							AS EBATRolePlayerID
		,'ADMINISTRATOR'						AS EBATRole
		,reading_timestamp						AS EventDateTime
		,CAST(reading_timestamp AS DATE)		AS EventDate
		,CAST(reading_timestamp AS TIME)		AS EventTime
		,magistrates_court_id					AS MagistratesCourtID
		,officer_id								AS OfficerID
		,operator_id							AS OperatorID
		,Deltalogkey							AS DeltaLogKey
	FROM ebat_reportCTE
	WHERE reading_timestamp IS NOT NULL

	UNION ALL

	SELECT 
		 [ebat_device_id]						AS EBATDeviceID
		,'7'									AS EBATEventID
		,'Reading Captured'						AS EBATEvent
		,id										AS UniqueId
		,completed_by_id						AS EBATRolePlayerID
		,'ADMINISTRATOR'						AS EBATRole
		,admin_timestamp						AS EventDateTime
		,CAST(admin_timestamp AS DATE)			AS EventDate
		,CAST(admin_timestamp AS TIME)			AS EventTime
		,magistrates_court_id					AS MagistratesCourtID
		,officer_id								AS OfficerID
		,operator_id							AS OperatorID
		,Deltalogkey							AS DeltaLogKey
	FROM ebat_reportCTE
	WHERE admin_timestamp IS NOT NULL

	UNION ALL

	SELECT 
		 [ebat_device_id]						AS EBATDeviceID
		,'8'									AS EBATEventID
		,'Departure'							AS EBATEvent
		,id										AS UniqueId
		,officer_id								AS EBATRolePlayerID
		,'OFFICER'								AS EBATRole
		,time_of_departure						AS EventDateTime
		,CAST(time_of_departure AS DATE)		AS EventDate
		,CAST(time_of_departure AS TIME)		AS EventTime
		,magistrates_court_id					AS MagistratesCourtID
		,officer_id								AS OfficerID
		,operator_id							AS OperatorID
		,Deltalogkey							AS DeltaLogKey
	FROM ebat_reportCTE
	WHERE time_of_departure IS NOT NULL

	UNION ALL

	SELECT 
		 [ebat_device_id]						AS EBATDeviceID
		,'9'									AS EBATEventID
		,'Reading Verified'						AS EBATEvent
		,id										AS UniqueId
		,verified_by_id							AS EBATRolePlayerID
		,'ADMINISTRATOR'						AS EBATRole
		,verified_at							AS EventDateTime
		,CAST(verified_at AS DATE)				AS EventDate
		,CAST(verified_at AS TIME)				AS EventTime
		,magistrates_court_id					AS MagistratesCourtID
		,officer_id								AS OfficerID
		,operator_id							AS OperatorID
		,Deltalogkey							AS DeltaLogKey
	FROM ebat_reportCTE
	WHERE verified_at IS NOT NULL
) 

SELECT 
	 EBATDeviceID															AS EBATDeviceID
	,EBATEventID															AS EBATEventID
	,EBATEvent																AS EBATEvent
	,UniqueId																AS UniqueId
	,EBATRolePlayerID														AS EBATRolePlayerID
	,EBATRole																AS EBATRole
	,EventDateTime															AS EventDateTime
	,EventDate																AS EventDate
	,CONVERT(TIME, CAST(EventTime AS VARCHAR(5)))							AS EventTime
	,MagistratesCourtID														AS MagistratesCourtID
	,OfficerID																AS OfficerID
	,CAST(
		CASE
			WHEN DATEPART(HOUR, EventDateTime) < 6 
				THEN DATEADD(DAY,-1,EventDateTime)
			ELSE EventDateTime 
	 END AS DATE)															AS OperationsDate
	,OperatorID																AS OperatorID
	,DeltaLogKey															AS DeltaLogKey
	,EBATEvent																AS EventTo
	,LAG(EventDateTime) OVER (PARTITION BY UniqueId ORDER BY EventDateTime) AS EventStartDateTime
	,LAG(EBATEvent) OVER (PARTITION BY UniqueId ORDER BY EventDateTime)		AS EventFrom
	,DATEDIFF(
		MINUTE
		,LAG(EventDateTime) OVER (
								PARTITION BY UniqueId 
								ORDER BY EventDateTime)
		, EventDateTime)													AS EventDuration
FROM EventsCTE




























