
CREATE VIEW [model].[_Speed Profiles] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   06 Jul 2019 9:53:52 AM
-- Reason               :   Semantic View for dbo.FactSpeedProfiles
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [CameraKey] AS [CameraKey]
	,[SightingDateKey] AS [SightingDateKey]
	,[SpeedProfileBucketKey] AS [SpeedProfileBucketKey]
	,[VehicleTypeKey] AS [VehicleTypeKey]
	,[AverageSpeed] AS [_AverageSpeed]
	,[MaximumSpeed] AS [_MaximumSpeed]
	,[MinimumSpeed] AS [_MinimumSpeed]
	,[VehicleCount] AS [_VehicleCount]
FROM WCG_DW.dbo.FactSpeedProfiles WITH (NOLOCK)
