






CREATE VIEW [cle].[transformDimVehicleSightings] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-08-2016
-- Reason				:	Transform view for DimVehicle from Sightings
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(VRN AS VARCHAR(20))										AS	[RegistrationNo]
	,DeltaLogKey													AS  [DeltaLogKey]
	,ROW_NUMBER() OVER (
		PARTITION BY DeltaLogKey, VRN 
		ORDER BY TimeStamp DESC)									AS	[RowNumber]
FROM [WCG_Stage].[cle].Sightings
WHERE VRN IS NOT NULL














