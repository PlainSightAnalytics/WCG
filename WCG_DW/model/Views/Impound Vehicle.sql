



CREATE VIEW [model].[Impound Vehicle] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   11-06-2019
-- Reason               :   Vehicle filtered for Impound Only
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
WHERE EXISTS (
	SELECT VehicleKey FROM (
		SELECT VehicleKey FROM model.[_Impound Events] WITH (NOLOCK)
		UNION
		SELECT VehicleKey FROM model.[_Impound Release Costs] WITH (NOLOCK)
		UNION
		SELECT VehicleKey FROM model.[_Impound Violation Charges] WITH (NOLOCK)
		UNION
		SELECT VehicleKey FROM model.[_Impound Requests] WITH (NOLOCK)
	) s
WHERE d.VehicleKey = s.VehicleKey)

