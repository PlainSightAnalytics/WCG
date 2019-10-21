
CREATE VIEW [model].[Vehicle Type] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimVehicleType
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [VehicleTypeKey] AS [VehicleTypeKey]
	,[VehicleCategory] AS [Vehicle Category]
	,[VehicleCategoryCode] AS [Vehicle Category Code]
	,[VehicleUsage] AS [Vehicle Usage]
	,[VehicleUsageCode] AS [Vehicle Usage Code]
FROM WCG_DW.dbo.DimVehicleType WITH (NOLOCK)
