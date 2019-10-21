







CREATE VIEW [cle].[transformDimVehicleAlerts] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-08-2016
-- Reason				:	Transform view for Vehicle
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT
	 CAST(ISNULL(MainColour,'Unknown') AS VARCHAR(50))					AS	[Colour]
	,CAST(ISNULL(MainColourCode, 'UNK') AS VARCHAR(10))					AS	[ColourCode]
	,CAST(ISNULL(Make,'Unknown') AS VARCHAR(50))						AS	[Make]
	,CAST(ISNULL(MakeCode,'UNK') AS VARCHAR(10))						AS	[MakeCode]
	,CAST(ISNULL(ModelName,'Unknown') AS VARCHAR(50))					AS	[Model]
	,CAST(ISNULL(ModelNameCode,'UNK') AS VARCHAR(10))					AS	[ModelCode]
	,CAST(ISNULL(VehicleCategory,'Unknown') AS VARCHAR(50))				AS  [VehicleCategory]
	,CAST(ISNULL(VehicleCategoryCode,'UNK') AS VARCHAR(50))				AS  [VehicleCategoryCode]
	,CAST(ISNULL(VehicleUsage,'Unknown') AS VARCHAR(50))				AS  [VehicleUsage]
	,CAST(ISNULL(VehicleUsageCode,'UNK') AS VARCHAR(50))				AS  [VehicleUsageCode]
	,CAST(VRN AS VARCHAR(20))											AS	[RegistrationNo]
	,ROW_NUMBER() OVER (
		PARTITION BY DeltaLogKey, VRN 
		ORDER BY AlertDateTime DESC)									AS [RowNumber]
	,DeltaLogKey														AS  [DeltaLogKey]
FROM [WCG_Stage].[cle].Alerts
WHERE VRN IS NOT NULL














