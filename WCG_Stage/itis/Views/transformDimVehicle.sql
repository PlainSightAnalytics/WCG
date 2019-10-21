






CREATE VIEW [itis].[transformDimVehicle] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-12-2017
-- Reason				:	Transform view for Vejhicle
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

WITH CTE AS (
SELECT
	 CAST(COALESCE(vehicle_colour, vehicle_colour_captured,'Unknown') AS VARCHAR(50))														AS [Colour]
	,CAST(COALESCE(vehicle_make,vehicle_make_captured,'Unknown') AS VARCHAR(50))															AS [Make]
	,CAST(COALESCE(vehicle_model_description,vehicle_model_description_captured,'Unknown') AS VARCHAR(50))									AS [Model]
	,CAST(COALESCE(license_number, vehicle_registration_number_captured) AS VARCHAR(20))													AS [RegistrationNo]
	,CAST(ISNULL(vehicle_usage_description,'Unknown') AS VARCHAR(50))																		AS [VehicleUsage]
	,ROW_NUMBER() OVER (PARTITION BY DeltaLogKey, COALESCE(license_number, vehicle_registration_number_captured) ORDER BY updated_at DESC)	AS [RowNumber]
	,DeltaLogKey																															AS [DeltaLogKey]
FROM [WCG_Stage].[itis].vehicle
)

SELECT 
	 [Colour]
	,[Make]
	,[Model]
	,[RegistrationNo]
	,[VehicleUsage]
	,[DeltaLogKey]
FROM CTE
WHERE RegistrationNo IS NOT NULL
AND RowNumber = 1











