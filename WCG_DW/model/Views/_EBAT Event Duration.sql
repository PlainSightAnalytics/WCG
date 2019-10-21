


CREATE VIEW [model].[_EBAT Event Duration] 

AS 

------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   11 Jun 2018 6:56:22 PM
-- Reason               :   Semantic View for dbo.FactEBATEventDuration
-- Modified By          :	Trevor Howe
-- Modified On          :	15-07-2019
-- Reason               :	Added new column for Operations Day (OperationsDateKey)
------------------------------------------------------------------------------------------

SELECT 
	 [EBATDeviceKey] AS [EBATDeviceKey]
	,[EBATEventKey] AS [EBATEventKey]
	,[EBATIncidentKey] AS [EBATIncidentKey]
	,[EBATRoleKey] AS [EBATRoleKey]
	,[EBATRolePlayerKey] AS [EBATRolePlayerKey]
	,[EventDateKey] AS [EventDateKey]
	,[EventTimeKey] AS [EventTimeKey]
	,[MagistratesCourtKey] AS [MagistratesCourtKey]
	,[OfficerKey] AS [OfficerKey]
	,[OperationsDateKey] AS [OperationsDateKey]
	,[OperatorKey] AS [OperatorKey]
	,[EventId] AS [Event Id]
	,[UniqueId] AS [Unique Id]
	,[EventDuration] AS [_EventDuration]
FROM WCG_DW.dbo.FactEBATEventDuration WITH (NOLOCK)

