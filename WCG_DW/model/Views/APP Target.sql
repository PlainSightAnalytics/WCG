
CREATE VIEW [model].[APP Target] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   26 May 2018 2:53:43 PM
-- Reason               :   Semantic View for dbo.DimAPPTarget
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [APPTargetKey] AS [APPTargetKey]
	,[APPTarget] AS [APP Target]
	,[APPTargetGUID] AS [APP Target GUID]
	,[OpenClosedStatus] AS [Open Closed Status]
FROM WCG_DW.dbo.DimAPPTarget WITH (NOLOCK)
