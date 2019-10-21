CREATE VIEW [model].[_Road Safety Education Events] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   06 Apr 2019 2:33:14 PM
-- Reason               :   Semantic View for dbo.FactRoadSafetyEducationEvents
------------------------------------------------------------------------------------------
-- Modified By          :	Trevor Howe
-- Modified On          :	23-08-2019
-- Reason               :	Added OperationsDateKey
------------------------------------------------------------------------------------------

SELECT 
	 f.[CreateTimeKey] AS [CreateTimeKey]
	,f.[DriverKey] AS [DriverKey]
	,f.[CreateDateKey] AS [CreateDateKey]
	,f.[OperationsDateKey] AS [OperationsDateKey]
	,f.[RoadSafetyTopicKey] AS [RoadSafetyTopicKey]
	,f.[TrafficCentreKey] AS [TrafficCentreKey]
	,f.[TrafficControlEventKey] AS [TrafficControlEventKey]
	,f.[UserKey] AS [UserKey]
	,f.[VehicleKey] AS [VehicleKey]
	,f.[UniqueID] AS [Unique ID]
	,d1.NumberOfPassengers
	,d1.NumberOfPassengers * 1.000 / COUNT(RoadSafetyTopicKey) OVER (PARTITION BY f.TrafficControlEventKey)  AS AverageTopics
FROM WCG_DW.dbo.FactRoadSafetyEducationEvents f WITH (NOLOCK)
LEFT JOIN WCG_DW.dbo.DimTrafficControlEvent d1 ON f.TrafficControlEventKey = d1.TrafficControlEventKey
