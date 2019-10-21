
CREATE VIEW [itis].[transformDimRoadSafetyTopic] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-04-2019
-- Reason				:	Transform view for DimRoadSafetyTopic
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 [id]							AS [RoadSafetyTopicID]
	,CAST([topic] AS VARCHAR(100))	AS [RoadSafetyTopic]
	,[sequence_number]				AS [SequenceNumber]
FROM [WCG_Stage].[itis].[road_safety_topic] WITH (NOLOCK)








