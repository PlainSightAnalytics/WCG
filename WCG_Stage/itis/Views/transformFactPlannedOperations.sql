
CREATE VIEW [itis].[transformFactPlannedOperations] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	13-04-2019
-- Reason				:	Transform view for FactPlannedOperations
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	17-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

SELECT
	 id																	AS UniqueID
	,planner_id															AS PlannerUserID
	,operational_officer_id												AS OperationalOfficerUserId
	,id																	AS OperationID
	,traffic_centre_id													AS TrafficCentreID
	,CAST(
		CAST(
			start_time AS DATETIMEOFFSET) 
			AT TIME ZONE 'South Africa Standard Time'
		AS DATE)														AS PlannedDate
	,CAST(
		CASE
			WHEN DATEPART(HOUR, CAST(start_time AS DATETIMEOFFSET) 
				AT TIME ZONE 'South Africa Standard Time') < 6 
			THEN DATEADD(DAY,-1,CAST(start_time AS DATETIMEOFFSET) 
				AT TIME ZONE 'South Africa Standard Time')
			ELSE CAST(start_time AS DATETIMEOFFSET) 
				AT TIME ZONE 'South Africa Standard Time'
		END AS DATE)													AS OperationsDate
	,DeltaLogKey							AS DeltaLogKey
FROM WCG_Stage.itis.[operation] WITH (NOLOCK)
WHERE start_time IS NOT NULL



