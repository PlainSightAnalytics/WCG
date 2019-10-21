
CREATE VIEW [model].[Camera] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   27 Dec 2018 2:59:30 PM
-- Reason               :   Semantic View for dbo.DimCamera
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [CameraKey] AS [CameraKey]
	,[CameraGUID] AS [Camera GUID]
	,[CameraID] AS [Camera ID]
	,[CameraLocation] AS [Camera Location]
	,[CameraName] AS [Camera Name]
	,[DistanceFromPreviousCamera] AS [Distance From Previous Camera]
	,[IsCountedInReport] AS [Is Counted In Report]
	,[IsMobileCamera] AS [Is Mobile Camera]
	,[LaneID] AS [Lane ID]
	,[OperationalArea] AS [Operational Area]
	,[OperationalAreaGUID] AS [Operational Area GUID]
	,[Route] AS [Route]
	,[RouteSequence] AS [Route Sequence]
	,[SiteID] AS [Site ID]
	,[SpeedSection] AS [Speed Section]
	,[SpeedSectionDescription] AS [Speed Section Description]
	,[SpeedSectionDistance] AS [Speed Section Distance]
	,[SpeedSectionPoint] AS [Speed Section Point]
	,[TrafficCentre] AS [Traffic Centre]
	,[TrafficCentreGUID] AS [Traffic Centre GUID]
	,[TravelDirection] AS [Travel Direction]
FROM WCG_DW.dbo.DimCamera WITH (NOLOCK)
