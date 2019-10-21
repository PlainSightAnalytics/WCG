
CREATE VIEW [model].[Shift Location] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   28 Oct 2018 1:35:42 PM
-- Reason               :   Semantic View for dbo.DimShiftLocation
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ShiftLocationKey] AS [ShiftLocationKey]
	,[Latitude] AS [Latitude]
	,[LocationType] AS [Location Type]
	,[Longitude] AS [Longitude]
	,[RoadNumber] AS [Road Number]
	,[ShiftLocation] AS [Shift Location]
	,[ShiftLocationID] AS [Shift Location ID]
	,[TrafficCentre] AS [Traffic Centre]
FROM WCG_DW.dbo.DimShiftLocation WITH (NOLOCK)
