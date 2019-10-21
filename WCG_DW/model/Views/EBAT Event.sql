
CREATE VIEW [model].[EBAT Event] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimEBATEvent
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [EBATEventKey] AS [EBATEventKey]
	,[EBATEvent] AS [EBAT Event]
	,[EBATEventID] AS [EBAT Event ID]
FROM WCG_DW.dbo.DimEBATEvent WITH (NOLOCK)
