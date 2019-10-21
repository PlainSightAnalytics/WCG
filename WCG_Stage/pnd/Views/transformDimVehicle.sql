
CREATE VIEW [pnd].[transformDimVehicle] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	03-02-2019
-- Reason				:	Transform view for DimVehicle
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(ISNULL(vehicle_colour,'Unknown') AS VARCHAR(50))			AS [Colour]
	,CAST(ISNULL(vehicle_make,'Unknown') AS VARCHAR(50))			AS [Make]
	,CAST(ISNULL(vehicle_model,'Unknown') AS VARCHAR(50))			AS [Model]
	,CAST(ISNULL(vehicle_registration,'Unknown') AS VARCHAR(20))	AS [RegistrationNo]
	,CAST(ISNULL(vehicle_class,'Unknown') AS VARCHAR(50))			AS [VehicleCategory]
	,ROW_NUMBER() OVER (
		PARTITION BY vehicle_registration, DeltaLogKey 
		ORDER BY updated_at DESC)									AS RowSequence
	,DeltaLogKey													AS [DeltaLogKey]
FROM [WCG_Stage].[pnd].[impound_instruction] WITH (NOLOCK)
WHERE vehicle_registration IS NOT NULL









