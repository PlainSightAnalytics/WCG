









CREATE VIEW [model].[Camera Enhanced] AS 

------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   28 Apr 2018 10:26:16 AM
-- Reason               :   Semantic View for dbo.DimCamera
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [CameraKey] AS [CameraKey]
	,[CameraGUID] AS [Camera GUID]
	,[CameraID] AS [Camera ID]
	,CASE 
		WHEN [SiteId] = '7' THEN 'Beaufort West - North'
		WHEN [SiteId] = '8' THEN 'Beaufort West - East'
		ELSE [CameraLocation] 
	END AS [Camera Location]
	,[CameraName] AS [Camera Name]
	,[IsCountedInReport] AS [Is Counted In Report]
	,[IsMobileCamera] AS [Is Mobile Camera]
	,[LaneID] AS [Lane ID]
	,[OperationalArea] AS [Operational Area]
	,[OperationalAreaGUID] AS [Operational Area GUID]
	,[SiteID] AS [Site ID]
	,[SpeedSection] AS [Speed Section]
	,[SpeedSectionDescription] AS [Speed Section Description]
	--,CASE
	--	WHEN SiteID = '12' and  LaneId = '1' THEN 9.931
	--	WHEN SiteID = '13' and  LaneId = '2' THEN 9.931
	--	WHEN SiteID = '8' and LaneId = '1' THEN 6.75
	--	WHEN SiteId = '9' and LaneId = '2' THEN 6.356
	--	WHEN SiteId = '7' AND LaneId = '1' THEN 6.356
	--	ELSE [SpeedSectionDistance] 
	--END AS [Speed Section Distance]
	,[SpeedSectionPoint] AS [Speed Section Point]
	,[TrafficCentre] AS [Traffic Centre]
	,[TrafficCentreGUID] AS [Traffic Centre GUID]
	,CASE
		WHEN [SiteId] = '9' AND LaneId = '1' THEN 'North'
		WHEN [SiteId] = '9' AND LaneId = '2' THEN 'South'
		WHEN [SiteId] = '8' AND LaneId = '1' THEN 'North East'
		WHEN [SiteId] = '8' AND LaneId = '2' THEN 'South East'
		WHEN [SiteId] = '7' AND LaneId = '1' THEN 'North North'
		WHEN [SiteId] = '7' AND LaneId = '2' THEN 'South North'
		WHEN [SiteId] = '6' AND LaneId = '1' THEN 'North East'
		WHEN [SiteId] = '6' AND LaneId = '2' THEN 'South East'
		WHEN [SiteId] = '10' AND LaneId = '1' THEN 'North North'
		WHEN [SiteId] = '10' AND LaneId = '2' THEN 'South North'
		ELSE [TravelDirection] 
	END AS [Travel Direction]
	,CASE
		WHEN SiteID = '1' AND LaneId = '1' THEN 22.195
		WHEN SiteID = '1' AND LaneId = '2' THEN 15.025
		WHEN SiteID = '10' AND LaneId = '1' THEN 32.871
		WHEN SiteID = '10' AND LaneId = '2' THEN 0
		WHEN SiteID = '11' AND LaneId = '1' THEN 66.059
		WHEN SiteID = '11' AND LaneId = '2' THEN 62.083
		WHEN SiteID = '12' AND LaneId = '1' THEN 9.931
		WHEN SiteID = '12' AND LaneId = '2' THEN 66.059
		WHEN SiteID = '13' AND LaneId = '1' THEN 54.947
		WHEN SiteID = '13' AND LaneId = '2' THEN 9.931
		WHEN SiteID = '14' AND LaneId = '1' THEN 17.2
		WHEN SiteID = '14' AND LaneId = '2' THEN 54.947
		WHEN SiteID = '15' AND LaneId = '1' THEN 0
		WHEN SiteID = '15' AND LaneId = '2' THEN 17.2
		WHEN SiteID = '16' AND LaneId = '1' THEN 0
		WHEN SiteID = '16' AND LaneId = '2' THEN 0
		WHEN SiteID = '16' AND LaneId = '3' THEN 6.918
		WHEN SiteID = '17' AND LaneId = '1' THEN 6.92
		WHEN SiteID = '17' AND LaneId = '2' THEN 21.898
		WHEN SiteID = '18' AND LaneId = '1' THEN 21.898
		WHEN SiteID = '18' AND LaneId = '2' THEN 0
		WHEN SiteID = '2' AND LaneId = '1' THEN 15.025
		WHEN SiteID = '2' AND LaneId = '2' THEN 20.178
		WHEN SiteID = '3' AND LaneId = '1' THEN 0
		WHEN SiteID = '3' AND LaneId = '2' THEN 22.195
		WHEN SiteID = '4' AND LaneId = '1' THEN 20.178
		WHEN SiteID = '4' AND LaneId = '2' THEN 0
		WHEN SiteID = '5' AND LaneId = '1' THEN 62.083
		WHEN SiteID = '5' AND LaneId = '2' THEN 62.413
		WHEN SiteID = '6' AND LaneId = '1' THEN 71.71
		WHEN SiteID = '6' AND LaneId = '2' THEN 0
		WHEN SiteID = '7' AND LaneId = '1' THEN 6.5
		WHEN SiteID = '7' AND LaneId = '2' THEN 32.871
		WHEN SiteID = '8' AND LaneId = '1' THEN 6.5
		WHEN SiteID = '8' AND LaneId = '2' THEN 71.71
		WHEN SiteID = '9' AND LaneId = '1' THEN 62.413
		WHEN SiteID = '9' AND LaneId = '2' THEN 6.5
		ELSE 0
	END AS Distance
	,CASE
		WHEN CameraLocation = 'Mobile' THEN 'Mobile'
		WHEN SiteID = '3' AND LaneId = '1' THEN 'R27 Outbound'
		WHEN SiteID = '4' AND LaneId = '2' THEN 'R27 Inbound'
		WHEN SiteID = '16' AND LaneId = '1' THEN 'N2 Outbound'
		WHEN SiteID = '18' AND LaneId = '2' THEN 'N2 Inbound'
		WHEN SiteID = '10' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '15' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '6' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '1' AND LaneId = '1' THEN 'R27 Outbound'
		WHEN SiteID = '2' AND LaneId = '2' THEN 'R27 Inbound'
		WHEN SiteID = '17' AND LaneId = '1' THEN 'N2 Outbound'
		WHEN SiteID = '17' AND LaneId = '2' THEN 'N2 Inbound'
		WHEN SiteID = '14' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '7' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '8' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '1' AND LaneId = '2' THEN 'R27 Inbound'
		WHEN SiteID = '2' AND LaneId = '1' THEN 'R27 Outbound'
		WHEN SiteID = '16' AND LaneId = '2' THEN 'N2 Outbound'
		WHEN SiteID = '16' AND LaneId = '3' THEN 'N2 Inbound'
		WHEN SiteID = '18' AND LaneId = '1' THEN 'N2 Outbound'
		WHEN SiteID = '13' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '9' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '3' AND LaneId = '2' THEN 'R27 Inbound'
		WHEN SiteID = '4' AND LaneId = '1' THEN 'R27 Outbound'
		WHEN SiteID = '12' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '5' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '11' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '11' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '12' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '5' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '13' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '9' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '14' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '7' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '8' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '10' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '15' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '6' AND LaneId = '1' THEN 'N1 Outbound'
		ELSE ''
	END AS Route
	,CASE
		WHEN CameraLocation = 'Mobile' THEN 'Mobile'
		WHEN SiteID = '1' AND LaneId = '1' THEN 'R27 Outbound'
		WHEN SiteID = '1' AND LaneId = '2' THEN 'R27 Inbound'
		WHEN SiteID = '10' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '10' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '11' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '11' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '12' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '12' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '13' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '13' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '14' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '14' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '15' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '15' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '16' AND LaneId = '1' THEN 'N2 Outbound'
		WHEN SiteID = '16' AND LaneId = '2' THEN 'N2 Outbound'
		WHEN SiteID = '16' AND LaneId = '3' THEN 'N2 Inbound'
		WHEN SiteID = '17' AND LaneId = '1' THEN 'N2 Outbound'
		WHEN SiteID = '17' AND LaneId = '2' THEN 'N2 Inbound'
		WHEN SiteID = '18' AND LaneId = '1' THEN 'N2 Outbound'
		WHEN SiteID = '18' AND LaneId = '2' THEN 'N2 Inbound'
		WHEN SiteID = '2' AND LaneId = '1' THEN 'R27 Outbound'
		WHEN SiteID = '2' AND LaneId = '2' THEN 'R27 Inbound'
		WHEN SiteID = '3' AND LaneId = '1' THEN 'R27 Outbound'
		WHEN SiteID = '3' AND LaneId = '2' THEN 'R27 Inbound'
		WHEN SiteID = '4' AND LaneId = '1' THEN 'R27 Outbound'
		WHEN SiteID = '4' AND LaneId = '2' THEN 'R27 Inbound'
		WHEN SiteID = '5' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '5' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '6' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '6' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '7' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '7' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '8' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '8' AND LaneId = '2' THEN 'N1 Inbound'
		WHEN SiteID = '9' AND LaneId = '1' THEN 'N1 Outbound'
		WHEN SiteID = '9' AND LaneId = '2' THEN 'N1 Inbound'
		ELSE 'Unclassified'
	END AS [Flow Direction]	 
	,CASE
		WHEN SiteID = '1' AND LaneId = '1' THEN 2
		WHEN SiteID = '1' AND LaneId = '2' THEN 3
		WHEN SiteID = '10' AND LaneId = '1' THEN 9
		WHEN SiteID = '10' AND LaneId = '2' THEN 1
		WHEN SiteID = '11' AND LaneId = '1' THEN 5
		WHEN SiteID = '11' AND LaneId = '2' THEN 5
		WHEN SiteID = '12' AND LaneId = '1' THEN 4
		WHEN SiteID = '12' AND LaneId = '2' THEN 6
		WHEN SiteID = '13' AND LaneId = '1' THEN 3
		WHEN SiteID = '13' AND LaneId = '2' THEN 7
		WHEN SiteID = '14' AND LaneId = '1' THEN 2
		WHEN SiteID = '14' AND LaneId = '2' THEN 8
		WHEN SiteID = '15' AND LaneId = '1' THEN 1
		WHEN SiteID = '15' AND LaneId = '2' THEN 9
		WHEN SiteID = '16' AND LaneId = '1' THEN 1
		WHEN SiteID = '16' AND LaneId = '2' THEN 1
		WHEN SiteID = '16' AND LaneId = '3' THEN 3
		WHEN SiteID = '17' AND LaneId = '1' THEN 2
		WHEN SiteID = '17' AND LaneId = '2' THEN 2
		WHEN SiteID = '18' AND LaneId = '1' THEN 3
		WHEN SiteID = '18' AND LaneId = '2' THEN 1
		WHEN SiteID = '2' AND LaneId = '1' THEN 3
		WHEN SiteID = '2' AND LaneId = '2' THEN 2
		WHEN SiteID = '3' AND LaneId = '1' THEN 1
		WHEN SiteID = '3' AND LaneId = '2' THEN 4
		WHEN SiteID = '4' AND LaneId = '1' THEN 4
		WHEN SiteID = '4' AND LaneId = '2' THEN 1
		WHEN SiteID = '5' AND LaneId = '1' THEN 6
		WHEN SiteID = '5' AND LaneId = '2' THEN 4
		WHEN SiteID = '6' AND LaneId = '1' THEN 9
		WHEN SiteID = '6' AND LaneId = '2' THEN 1
		WHEN SiteID = '7' AND LaneId = '1' THEN 8
		WHEN SiteID = '7' AND LaneId = '2' THEN 2
		WHEN SiteID = '8' AND LaneId = '1' THEN 8
		WHEN SiteID = '8' AND LaneId = '2' THEN 2
		WHEN SiteID = '9' AND LaneId = '1' THEN 7
		WHEN SiteID = '9' AND LaneId = '2' THEN 3
		ELSE 0
	END AS [Route Sequence]
FROM WCG_DW.dbo.DimCamera WITH (NOLOCK)

