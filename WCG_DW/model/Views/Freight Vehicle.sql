





CREATE VIEW [model].[Freight Vehicle] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimVehicle
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [VehicleKey] AS [VehicleKey]
	,[Colour] AS [Colour]
	,[ColourCode] AS [Colour Code]
	,[Make] AS [Make]
	,[MakeCode] AS [Make Code]
	,[Model] AS [Model]
	,[ModelCode] AS [Model Code]
	,[RegistrationNo] AS [Registration No]
	,[VehicleCategory] AS [Vehicle Category]
	,[VehicleCategoryCode] AS [Vehicle Category Code]
	,[VehicleUsage] AS [Vehicle Usage]
	,[VehicleUsageCode] AS [Vehicle Usage Code]
FROM WCG_DW.dbo.DimVehicle v WITH (NOLOCK) 
WHERE VehicleCategoryCode IN ('M','L')
AND EXISTS (
SELECT VehicleKey FROM WCG_DW.dbo.FactFreightTracking f WITH (NOLOCK)
WHERE v.VehicleKey = f.VehicleKey)

