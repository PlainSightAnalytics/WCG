



CREATE VIEW [model].[Public Transport Vehicle] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   20-04-2019
-- Reason               :   Vehicle filtered for Public Transport Only
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------

SELECT 
	 d.[VehicleKey]					AS [VehicleKey]
	,d.[Colour]						AS [Colour]
	,d.[ColourCode]					AS [Colour Code]
	,d.[Make]						AS [Make]
	,d.[MakeCode]					AS [Make Code]
	,d.[Model]						AS [Model]
	,d.[ModelCode]					AS [Model Code]
	,d.[RegistrationNo]				AS [Registration No]
	,d.[VehicleCategory]			AS [Vehicle Category]
	,d.[VehicleCategoryCode]		AS [Vehicle Category Code]
	,d.[VehicleUsage]				AS [Vehicle Usage]
	,d.[VehicleUsageCode]			AS [Vehicle Usage Code]
FROM WCG_DW.dbo.DimVehicle d
WHERE 
	d.VehicleCategoryCode = 'C' 
OR	d.VehicleUsageCode = '02'


