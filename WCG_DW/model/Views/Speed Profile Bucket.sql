
CREATE VIEW [model].[Speed Profile Bucket] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   24 Apr 2019 2:33:12 PM
-- Reason               :   Semantic View for dbo.DimSpeedProfileBucket
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [SpeedProfileBucketKey] AS [SpeedProfileBucketKey]
	,[FromSpeed] AS [From Speed]
	,[SortOrder] AS [Sort Order]
	,[SpeedProfileBucket] AS [Speed Profile Bucket]
	,[ToSpeed] AS [To Speed]
FROM WCG_DW.dbo.DimSpeedProfileBucket WITH (NOLOCK)
