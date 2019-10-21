
CREATE VIEW [model].[Transport Operation Vehicle] AS 
------------------------------------------------------------------------------------------
-- Author               :   Trevor Howe
-- Date Created         :   04-10-2019
-- Reason               :   Vehicles related to Transport Operation Events
------------------------------------------------------------------------------------------
-- Modified By          :	
-- Modified On          :	
-- Reason               :	
------------------------------------------------------------------------------------------

SELECT 
	 VehicleKey				AS [VehicleKey]
	,Colour					AS [Colour]
	,ColourCode				AS [Colour Code]
	,Make					AS [Make]
	,MakeCode				AS [Make Code]
	,Model					AS [Model]
	,ModelCode				AS [Model Code]
	,RegistrationNo			AS [Registration No]
	,VehicleCategory		AS [Vehicle Category]
	,VehicleCategoryCode	AS [Vehicle Category Code]
	,VehicleUsage			AS [Vehicle Usage]
	,VehicleUsageCode		AS [Vehicle Usage Code]
FROM WCG_DW.dbo.DimVehicle v WITH (NOLOCK)
WHERE 
	EXISTS (
		SELECT VehicleKey
		FROM model.[_Transport Operation Events] e WITH (NOLOCK)
		WHERE v.VehicleKey = e.VehicleKey
	) 
	OR 
	EXISTS (
		SELECT VehicleKey
		FROM model.[_Road Safety Education Events] e WITH (NOLOCK)
		WHERE v.VehicleKey = e.VehicleKey
	)
