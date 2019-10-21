

CREATE VIEW [itis].[transformFactRoadSafetyEducationEvents] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-04-2019
-- Reason				:	Transform view for DimRoadSafetyTopic
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	17-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH VehicleCTE AS (
	SELECT
		Id
		,CAST(
			COALESCE(license_number, vehicle_registration_number_captured) 
		AS VARCHAR(20))														AS RegistrationNo
		,ROW_NUMBER() OVER (
			PARTITION BY Id ORDER BY updated_at DESC)						AS RowSequence
	FROM [WCG_STAGE].[itis].[Vehicle]	
)

,DriverCTE AS (
	SELECT
		 Id
		,CAST(
			COALESCE(enatis_id_document_number,id_number_captured) 
		AS VARCHAR(20))														AS IDDocumentNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)		AS RowSequence
	FROM WCG_Stage.itis.driver
	WHERE 
		COALESCE(enatis_id_document_number,id_number_captured) IS NOT NULL
)

SELECT 
	 t.created_by_id														AS CreatedByUserID
	,CAST(
		CAST(t.date_created AS DATETIMEOFFSET) 
		AT TIME ZONE 'South Africa Standard Time' AS DATE)					AS CreateDate
	,FORMAT(
		DATEADD(HOUR,2,
		CAST(CAST(t.date_created AS DATETIMEOFFSET) 
		AT TIME ZONE 'South Africa Standard Time' AS DATETIME))
		,'HH:mm')															AS CreateTime
	,CAST(
		CASE
			WHEN DATEPART(HOUR, CAST(t.date_created AS DATETIMEOFFSET) 
				AT TIME ZONE 'South Africa Standard Time') < 6 
			THEN DATEADD(DAY,-1,CAST(t.date_created AS DATETIMEOFFSET) 
				AT TIME ZONE 'South Africa Standard Time')
			ELSE CAST(t.date_created AS DATETIMEOFFSET) 
				AT TIME ZONE 'South Africa Standard Time'
		END AS DATE)														AS OperationsDate
	,t.event_id																AS TrafficControlEventID
	,e.traffic_centre_id													AS TrafficCentreId
	,v.RegistrationNo														AS RegistrationNo
	,IDDocumentNo															AS IDDocumentNo
	,t.id																	AS UniqueId
	,road_safety_topic_id													AS RoadSafetyTopicID
	,t.DeltaLogKey															AS DeltaLogKey
FROM [WCG_Stage].[itis].[event_road_safety_topic] t WITH (NOLOCK)
LEFT JOIN [WCG_Stage].[itis].[event] e WITH (NOLOCK) ON t.event_id = e.id
LEFT JOIN VehicleCTE v ON e.primary_vehicle_id = v.id
LEFT JOIN DriverCTE d ON e.primary_driver_id = d.id









