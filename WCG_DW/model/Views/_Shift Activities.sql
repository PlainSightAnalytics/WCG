
CREATE VIEW [model].[_Shift Activities] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   17 Jul 2019 2:39:32 PM
-- Reason               :   Semantic View for dbo.FactShiftActivities
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [GeoLocationKey] AS [GeoLocationKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[ShiftActivityTypeKey] AS [ShiftActivityTypeKey]
	,[ShiftDateKey] AS [ShiftDateKey]
	,[ShiftKey] AS [ShiftKey]
	,[ShiftLocationKey] AS [ShiftLocationKey]
	,[ShiftTaskKey] AS [ShiftTaskKey]
	,[TrafficCentreKey] AS [TrafficCentreKey]
	,[UserKey] AS [UserKey]
	,[ActivityComment] AS [Activity Comment]
	,[ActivityEndTime] AS [Activity End Time]
	,[ActivityStartTime] AS [Activity Start Time]
	,[IsAdhocActivity] AS [Is Adhoc Activity]
	,[OtherLocation] AS [Other Location]
	,[UniqueID] AS [Unique ID]
	,[DurationHours] AS [_DurationHours]
FROM WCG_DW.dbo.FactShiftActivities WITH (NOLOCK)
