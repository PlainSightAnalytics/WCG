

CREATE VIEW [model].[_Shift Times]

AS 

------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactShiftTimes
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe 
-- Modified On          :	27-11-2019
-- Reason               :	Added DeviceKey from FactDeviceHistory
-- Work Item			:	WCG-0123
------------------------------------------------------------------------------------------

WITH DeviceCTE AS (
	SELECT
		 UserKey
		,ShiftKey
		,DeviceKey
		,ROW_NUMBER() OVER (PARTITION BY UserKey, ShiftKey ORDER BY EventDateTime) AS RowSequence
	FROM FactDeviceHistory f  WITH (NOLOCK)
	WHERE 
		UserKey <> -1
	AND ShiftKey <> -1
	AND DeviceKey <> -1
)

SELECT 
	 ISNULL(d.DeviceKey,-1) AS [DeviceKey]
	,f.[OperationsDateKey] AS [OperationsDateKey]
	,f.[RosterKey] AS [RosterKey]
	,f.[ShiftDateKey] AS [ShiftDateKey]
	,f.[ShiftKey] AS [ShiftKey]
	,f.[ShiftTimeKey] AS [ShiftTimeKey]
	,f.[ShiftWeekKey] AS [ShiftWeekKey]
	,f.[TrafficCentreKey] AS [TrafficCentreKey]
	,f.[UserKey] AS [UserKey]
	,f.[IsAcknowledged] AS [Is Acknowledged]
	,f.[IsArchived] AS [Is Archived]
	,f.[IsDeleted] AS [Is Deleted]
	,f.[IsUserShift] AS [Is User Shift]
	,f.[UniqueID] AS [Unique ID]
	,f.[DurationHours] AS [_DurationHours]
FROM WCG_DW.dbo.FactShiftTimes f WITH (NOLOCK)
LEFT JOIN DeviceCTE d ON f.UserKey = d.UserKey AND f.ShiftKey = d.ShiftKey AND d.RowSequence = 1
