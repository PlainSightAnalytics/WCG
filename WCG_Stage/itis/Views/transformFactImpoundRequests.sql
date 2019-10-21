


CREATE VIEW [itis].[transformFactImpoundRequests] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	08-02-2019
-- Reason				:	Transform view for FactImpoundRequests
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH VehicleCTE AS (
	SELECT
		Id
		,CAST(COALESCE(license_number, vehicle_registration_number_captured) AS VARCHAR(20))	AS RegistrationNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)							AS RowSequence
	FROM [WCG_STAGE].[itis].[Vehicle]	
)

,DriverCTE AS (
	SELECT
		 Id
		,CAST(COALESCE(enatis_id_document_number,id_number_captured) AS VARCHAR(20))			AS IDDocumentNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)							AS RowSequence
	FROM WCG_Stage.itis.driver
	WHERE COALESCE(enatis_id_document_number,id_number_captured) IS NOT NULL
)

,eventCTE AS (
SELECT
	 e.id
	,v.RegistrationNo
	,d.IDDocumentNo
	,e.traffic_centre_id
	,e.[user_id]
	,CAST(e.[opened_at] AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS [opened_at]
	,CAST(
		CASE
			WHEN SUBSTRING(datetime_impound_offence,1,3) IN ('Mon','Tue','Wed','Thu','Fri','Sat','Sun')
			THEN SUBSTRING(datetime_impound_offence,5,20)
		END AS DATETIME) as datetime_impound_offence
	,ROW_NUMBER() OVER (PARTITION BY e.id ORDER BY e.updated_at DESC) AS RowSequence
FROM [itis].[event] e
LEFT JOIN VehicleCTE v ON e.primary_vehicle_id = v.id
LEFT JOIN DriverCTE d ON e.primary_driver_id = d.id
)

,impoundInstructionCTE AS (
SELECT 
	id
	,CAST(
		CASE
			WHEN SUBSTRING(date_of_offence,1,3) IN ('Mon','Tue','Wed','Thu','Fri','Sat','Sun')
			THEN SUBSTRING(date_of_offence,5,20)
		END AS DATETIME) as date_of_offence
	,vehicle_registration
	,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS RowSequence
FROM [pnd].[impound_instruction]
)

SELECT
	 e.IDDocumentNo									AS [IDNo]
	,ii.id											AS [ImpoundInstructionID]
	,CAST(r.override_reason AS VARCHAR(1000))		AS [ImpoundOverrideReason]
	,CAST(r.status_display AS VARCHAR(10))			AS [ImpoundRequestStatus]
	,ISNULL(r.override_display,'No')				AS [IsImpoundOverridden]
	,CAST(
		CASE
			WHEN DATEPART(HOUR, e.opened_at) < 6 
				THEN DATEADD(DAY,-1,e.opened_at)
			ELSE e.opened_at 
	 END AS DATE)									AS [OperationsDate]
	,p.id											AS [PoundFacilityID]
	,e.RegistrationNo								AS [RegistrationNo]
	,e.traffic_centre_id							AS [TrafficCentreID]
	,r.event_id										AS [TrafficControlEventID]
	,r.id											AS [UniqueID]
	,e.user_id										AS [UserID]
	,CAST(e.opened_at AS DATE)						AS [UpdateDate]
	,r.[DeltaLogKey]								AS [DeltaLogKey]
FROM WCG_Stage.itis.[impound_request] r WITH (NOLOCK)
LEFT JOIN eventCTE e ON r.event_id = e.id AND RowSequence = 1
LEFT JOIN impoundInstructionCTE ii ON e.RegistrationNo = ii.vehicle_registration AND e.datetime_impound_offence = ii.date_of_offence AND ii.RowSequence = 1
LEFT JOIN WCG_Stage.itis.impound i ON r.impound_id = i.id
LEFT JOIN WCG_Stage.pnd.impound p ON i.handle = p.handle



