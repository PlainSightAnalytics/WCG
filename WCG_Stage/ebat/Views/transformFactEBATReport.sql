














CREATE VIEW [ebat].[transformFactEBATReport] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	12-08-2106
-- Reason				:	Transform view for Authority
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	20-06-2018
-- Reason				:	Dropped Degens and replaced with Foreign Key to EBAT Incident
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	02-09-2018
-- Reason				:	Added CTE's and Columns for RegistrationNo and Driver IDDocumentNo
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	15-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH VehicleCTE AS (
	SELECT
		Id
		,CAST(COALESCE(license_number, vehicle_registration_number_captured) AS VARCHAR(20))	AS RegistrationNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)							AS RowSequence
	FROM [WCG_STAGE].[ebat].[Vehicle]	
),


DriverCTE AS (
	SELECT
		 Id
		,CAST(COALESCE(enatis_id_document_number,id_number_captured) AS VARCHAR(20))			AS IDDocumentNo
		,ROW_NUMBER() OVER (PARTITION BY Id ORDER BY updated_at DESC)							AS RowSequence
	FROM [WCG_STAGE].[ebat].[driver]
	WHERE COALESCE(enatis_id_document_number,id_number_captured) IS NOT NULL
)

,EBATReportCTE AS (
SELECT 
	 CAST(
		ISNULL(
				CAST([time_of_reading_start] AS DATETIMEOFFSET) 
					AT TIME ZONE 'South Africa Standard Time'
				,CAST([time_of_arrival] AS DATETIMEOFFSET) 
					AT TIME ZONE 'South Africa Standard Time')	AS DATETIME)					AS [Date]
	,[id]
	,[ebat_device_id]
	,[magistrates_court_id]
	,[officer_id]
	,[operator_id]
	,[number_of_vehicles]
	,[reading]
	,[driver_id]
	,[vehicle_id]
	,[cas_number]
	,[updated_at]
	,DeltaLogKey
	FROM [WCG_Stage].[ebat].[ebat_report] er
)

SELECT 
	 CAST(er.[Date] AS DATE)																	AS [Date]
	,er.[id]																					AS [EBATReportId]
	,er.[ebat_device_id]																		AS [EBATDeviceID]
	,CAST(CONVERT(CHAR(5),CAST(er.[Date] AS TIME)) AS TIME)										AS [Hour]
	,CAST(
		CASE
			WHEN DATEPART(HOUR,er.[Date]) < 6 THEN DATEADD(d,-1,er.[Date])
			ELSE er.[Date]
		END AS DATE)																			AS [OperationsDate]
	,d.IDDocumentNo																				AS [IDDocumentNo]
	,[magistrates_court_id]																		AS [MagistratesCourtID]
	,[officer_id]																				AS [OfficerID]
	,[operator_id]																				AS [OperatorID]
	,CAST([number_of_vehicles] AS INT)															AS [NumberOfVehicles]
	,CASE
	WHEN [reading] = '' THEN 0
	ELSE CAST(replace([reading],'o',0) AS NUMERIC(19,2))
	END																							AS [ReadingResult]
	,CAST(ISNULL(v.RegistrationNo,'Unknown') AS VARCHAR(20))									AS [RegistrationNo]
	,ROW_NUMBER() OVER (
	PARTITION BY cas_number, er.[id], DeltaLogKey
	ORDER BY updated_at)																		AS [RowNumber]
	,er.DeltaLogKey																				AS [DeltaLogKey]
FROM EBATReportCTE er
LEFT JOIN VehicleCTE v ON er.vehicle_id = v.id
LEFT JOIN DriverCTE d ON er.driver_id = d.id






















