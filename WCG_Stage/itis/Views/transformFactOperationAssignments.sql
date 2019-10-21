

CREATE VIEW [itis].[transformFactOperationAssignments] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	13-01-2019
-- Reason				:	Transform view for FactOperationAssignments
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	17-07-2019
-- Reason				:	Converted all date and time fields to GMT+2 (SA Time)
--						:	Added Operations Date field (Operations day starts at 6am and ends before 6am the following day)
--------------------------------------------------------------------------------------------------------------------------------------

WITH OperationCTE AS (
SELECT
	 id
	,traffic_centre_id
	,CAST(start_time AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS start_time
	,CAST(actual_operation_start_time AS DATETIMEOFFSET) AT TIME ZONE 'South Africa Standard Time' AS actual_operation_start_time
	,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS RowSequence
FROM itis.[operation]
)

,CTE AS (
SELECT
	 a.id																	AS UniqueID
	,a.user_id																AS UserID
	,a.operation_id															AS OperationID
	,c.traffic_centre_id													AS TrafficCentreID
	,CAST(ISNULL(c.start_time,c.actual_operation_start_time) AS DATETIME)	AS OperationDate
	,a.DeltaLogKey															AS DeltaLogKey
FROM WCG_Stage.itis.[officials_involved_in_operation] a WITH (NOLOCK)
INNER JOIN OperationCTE c ON a.operation_id = c.id AND c.RowSequence = 1
)

SELECT 
	 UniqueID																AS UniqueID
	,UserID																	AS UserID
	,OperationID															AS OperationID
	,TrafficCentreID														AS TrafficCentreID
	,CAST(OperationDate AS DATE)											AS OperationDate
	,CAST(
		CASE
			WHEN DATEPART(HOUR, OperationDate) < 6 
				THEN DATEADD(DAY,-1,OperationDate)
			ELSE OperationDate
		END AS DATE)														AS OperationsDate
	,DeltaLogKey															AS DeltaLogKey
FROM CTE 