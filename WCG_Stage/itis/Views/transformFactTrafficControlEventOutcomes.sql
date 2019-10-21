










CREATE VIEW [itis].[transformFactTrafficControlEventOutcomes] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	20-05-2018
-- Reason				:	Transform view for FactTrafficControlEventOutcomes
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	03-02-2019
-- Reason				:	Added impound_id
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	28-06-2019
-- Reason				:	Fixed joins between violation_charge, event and section56_form and deduplicated some of the joins with RowSequence
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	19-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	30-08-2019
-- Reason				:	Changed logic to fix missing section 56 and event data and violation charge duplicates
--------------------------------------------------------------------------------------------------------------------------------------

WITH
EventCTE AS (
SELECT
	e.id,
	e.device_id,
	e.magistrates_court_id,
	e.traffic_centre_id,
	u.traffic_centre_id as traffic_centre_id_user,
	e.primary_driver_id,
	e.primary_vehicle_id,
	CAST(ISNULL(e.opened_at,e.updated_at) AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS opened_at,
	e.user_id,
	ROW_NUMBER() OVER (PARTITION BY e.id ORDER BY e.updated_at DESC) AS RowSequence
FROM itis.event e WITH (NOLOCK)
LEFT JOIN itis.[user] u  WITH (NOLOCK) ON e.user_id = u.id
),

Section56CTE AS (
SELECT 
	id,
	event_id,
	magistrates_court_id,
	ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS RowSequence
FROM itis.section56_form WITH (NOLOCK)
),

VehicleCTE AS (
	SELECT
		Id
		,CAST(COALESCE(license_number, vehicle_registration_number_captured) AS VARCHAR(20))	AS RegistrationNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)							AS RowSequence
	FROM [WCG_STAGE].[itis].[Vehicle] WITH (NOLOCK)	
),

VehicleUsageCTE AS (
	SELECT
		RegistrationNo
		,VehicleCategoryCode	
		,VehicleUsageCode
	FROM WCG_DW.dbo.DimVehicle WITH (NOLOCK)
),

DriverCTE AS (
	SELECT
		 Id
		,CAST(COALESCE(enatis_id_document_number,id_number_captured) AS VARCHAR(20))			AS IDDocumentNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)							AS RowSequence
	FROM WCG_Stage.itis.driver WITH (NOLOCK)
	WHERE COALESCE(enatis_id_document_number,id_number_captured) IS NOT NULL
),

ImpoundRequestCTE AS (
SELECT
	 event_id
	,impound_id
	,ROW_NUMBER() OVER (PARTITION BY event_id ORDER BY updated_at DESC) AS RowSequence
FROM itis.impound_request WITH (NOLOCK)
WHERE impound_id IS NOT NULL
)


SELECT 
	 c.charge_code_id																			AS [ChargeCodeGUID]
	,CAST(ISNULL(u.VehicleCategoryCode,'UNK') AS VARCHAR(10))									AS [VehicleCategoryCode]
	,CAST(ISNULL(u.VehicleUsageCode,'UNK') AS VARCHAR(10))										AS [VehicleUsageCode]
	,e.device_id																				AS [DeviceGUID]
	,d.IDDocumentNo																				AS [IDDocumentNo]
	,COALESCE(e.magistrates_court_id,s.magistrates_court_id,c.magistrates_court_id)				AS [MagistratesCourtGUID]
	,COALESCE(e.id,s.event_id)																	AS [TrafficControlEventGUID]
	,c.section56_form_id
	,s.id																						AS [Section56FormGUID]
	,CAST(ISNULL(v.RegistrationNo,'Unknown') AS VARCHAR(20))									AS [RegistrationNo]
	,COALESCE(e.traffic_centre_id, e.traffic_centre_id_user)									AS [TrafficCentreGUID]
	,CAST(
		SUBSTRING(
			CONVERT(
				VARCHAR(20),
				CAST(c.[updated_at] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time'
				,113
			)
			,13
			,5
		) AS TIME)																				AS [UpdatedTime]
	,CAST(
		CAST(c.[updated_at] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' 
	 AS DATE)																					AS [UpdatedDate]
	,CAST(FORMAT(e.[opened_at],'HH:mm') AS TIME)												AS [OpenTime]
	,CAST(e.[opened_at] AS DATE)																AS [OpenDate]
	,CAST(
		CASE
			WHEN DATEPART(HOUR, e.[opened_at]) < 6 
			THEN DATEADD(DAY,-1, e.[opened_at])
			ELSE e.[opened_at]
		END AS DATE)																			AS [OperationsDate]
	,e.user_id																					AS [UserGUID]
	,c.id																						AS [UniqueChargeID]
	,s.id																						AS [UniqueSection56FormID]
	,CAST(cc.amount AS NUMERIC(19,2))															AS [ChargeAmount]
	,c.DeltaLogKey																				AS [DeltaLogKey]
	-- New Fields 03-02-2019
	,ir.impound_id																				AS [PoundFacilityID]
FROM WCG_Stage.itis.[violation_charge] c WITH (NOLOCK)
LEFT JOIN WCG_Stage.itis.charge_code cc WITH (NOLOCK)	ON c.charge_code_id = cc.id
LEFT JOIN Section56CTE s								ON c.section56_form_id = s.id AND s.RowSequence = 1
LEFT JOIN EventCTE e									ON s.event_id = e.id AND e.RowSequence = 1
LEFT JOIN VehicleCTE v									ON e.primary_vehicle_id = v.id AND v.RowSequence = 1
LEFT JOIN VehicleUsageCTE u								ON v.RegistrationNo = u.RegistrationNo
LEFT JOIN DriverCTE d									ON e.primary_driver_id = d.id AND d.RowSequence = 1
LEFT JOIN ImpoundRequestCTE ir							ON e.id = ir.event_id AND ir.RowSequence = 1
WHERE 
	c.section56_form_id IS NOT NULL
AND e.id IS NOT NULL






