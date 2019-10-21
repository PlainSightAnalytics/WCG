
CREATE VIEW [model].[Geo Location] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimGeoLocation
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [GeoLocationKey] AS [GeoLocationKey]
	,[Latitude] AS [Latitude]
	,[LatitudeRange] AS [Latitude Range]
	,[Longitude] AS [Longitude]
	,[LongitudeRange] AS [Longitude Range]
FROM WCG_DW.dbo.DimGeoLocation WITH (NOLOCK)
