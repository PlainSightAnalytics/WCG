










CREATE VIEW [itis].[transformFactTrafficControlEvents] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-05-2018
-- Reason				:	Transform view for FactTrafficControlEvents
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	26-08-2018
-- Reason				:	Added Open Date and Open Time
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	02-09-2018
-- Reason				:	Added Driver CTE and IDDocumentNo field
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	08-06-2019
-- Reason				:	Deduplicated for Vehicle and Driver (Added RowSequence in final joins)
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH AlertsCTE AS (
SELECT
	id,
	event_id,
	alert_type_id_short_key,
	alert_sub_type_code,
	ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS RowSequence
FROM itis.alert
),

VehicleCTE AS (
	SELECT
		Id
		,CAST(COALESCE(license_number, vehicle_registration_number_captured) AS VARCHAR(20))	AS RegistrationNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)							AS RowSequence
	FROM [WCG_STAGE].[itis].[Vehicle]	
),

VehicleUsageCTE AS (
	SELECT
		RegistrationNo
		,VehicleCategoryCode	
		,VehicleUsageCode
	FROM WCG_DW.dbo.DimVehicle
),

DriverCTE AS (
	SELECT
		 Id
		,CAST(COALESCE(enatis_id_document_number,id_number_captured) AS VARCHAR(20))			AS IDDocumentNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)							AS RowSequence
	FROM WCG_Stage.itis.driver
	WHERE COALESCE(enatis_id_document_number,id_number_captured) IS NOT NULL
)

SELECT
	 CAST(ISNULL(a.alert_sub_type_code,'NA') AS VARCHAR(50))								AS [AlertSubTypeCode]
	,CAST(ISNULL(a.alert_type_id_short_key,0) AS INT)										AS [AlertTypeId]
	,CAST(ISNULL(u.VehicleCategoryCode,'UNK') AS VARCHAR(10))								AS [VehicleCategoryCode]
	,CAST(ISNULL(u.VehicleUsageCode,'UNK') AS VARCHAR(10))									AS [VehicleUsageCode]
	,e.device_id																			AS [DeviceGUID]
	,d.IDDocumentNo																			AS [IDDocumentNo]
	,CAST(
		SUBSTRING(
			CONVERT(
				VARCHAR(20),
				CAST([opened_at] AS DATETIMEOFFSET)	AT TIME ZONE 'South Africa Standard Time',
				113
			),13,5
		) AS TIME)																			AS [OpenTime]
	,CAST(
		CAST([opened_at] AS DATETIMEOFFSET)	AT TIME ZONE 'South Africa Standard Time' 
		AS DATE
	)																						AS [OpenDate]
	,CAST(
		CASE
			WHEN DATEPART(HOUR, CAST([opened_at] AS DATETIMEOFFSET)	
				AT TIME ZONE 'South Africa Standard Time') < 6 
			THEN DATEADD(DAY,-1, CAST([opened_at] AS DATETIMEOFFSET)	
				AT TIME ZONE 'South Africa Standard Time')
			ELSE CAST([opened_at] AS DATETIMEOFFSET)	
				AT TIME ZONE 'South Africa Standard Time'
		END AS DATE)																		AS [OperationsDate]
	,e.magistrates_court_id																	AS [MagistratesCourtGUID]
	,e.id																					AS [TrafficControlEventGUID]
	,CAST(ISNULL(v.RegistrationNo,'Unknown') AS VARCHAR(20))								AS [RegistrationNo]
	,e.traffic_centre_id																	AS [TrafficCentreGUID]
	,CAST(
		SUBSTRING(
			CONVERT(
				VARCHAR(20),
				CAST([updated_at] AS DATETIMEOFFSET)	AT TIME ZONE 'South Africa Standard Time',
				113
			),13,5
		) AS TIME)																			AS [UpdatedTime]
	,CAST(
		CAST([updated_at] AS DATETIMEOFFSET)	AT TIME ZONE 'South Africa Standard Time' 
		AS DATE
	)																						AS [UpdatedDate]
	,user_id																				AS [UserGUID]
	,ISNULL(a.id,'00000000-0000-0000-0000-000000000000')									AS [UniqueAlertID]
	,e.id																					AS [UniqueEventID]
	,e.DeltaLogKey																			AS [DeltaLogKey]
FROM WCG_Stage.itis.[event] e WITH (NOLOCK)
LEFT JOIN AlertsCTE a ON e.id = a.event_id AND RowSequence = 1
LEFT JOIN VehicleCTE v ON e.primary_vehicle_id = v.id AND v.RowSequence = 1
LEFT JOIN VehicleUsageCTE u ON v.RegistrationNo = u.RegistrationNo
LEFT JOIN DriverCTE d ON e.primary_driver_id = d.id and d.RowSequence = 1











