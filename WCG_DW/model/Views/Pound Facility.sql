
CREATE VIEW [model].[Pound Facility] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   08 Feb 2019 8:59:49 AM
-- Reason               :   Semantic View for dbo.DimPoundFacility
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [PoundFacilityKey] AS [PoundFacilityKey]
	,[LocalMunicipality] AS [Local Municipality]
	,[PoundFacility] AS [Pound Facility]
	,[PoundFacilityID] AS [Pound Facility ID]
	,[TrafficCentre] AS [Traffic Centre]
FROM WCG_DW.dbo.DimPoundFacility WITH (NOLOCK)
