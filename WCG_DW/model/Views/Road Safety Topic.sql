
CREATE VIEW [model].[Road Safety Topic] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   06 Apr 2019 2:33:14 PM
-- Reason               :   Semantic View for dbo.DimRoadSafetyTopic
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [RoadSafetyTopicKey] AS [RoadSafetyTopicKey]
	,[RoadSafetyTopic] AS [Road Safety Topic]
	,[RoadSafetyTopicID] AS [Road Safety Topic ID]
	,[SequenceNumber] AS [Sequence Number]
FROM WCG_DW.dbo.DimRoadSafetyTopic WITH (NOLOCK)
