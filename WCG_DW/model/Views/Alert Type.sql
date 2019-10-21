
CREATE VIEW [model].[Alert Type] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:42 PM
-- Reason               :   Semantic View for dbo.DimAlertType
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [AlertTypeKey] AS [AlertTypeKey]
	,[AlertSubType] AS [Alert Sub Type]
	,[AlertSubTypeCode] AS [Alert Sub Type Code]
	,[AlertType] AS [Alert Type]
	,[AlertTypeDescription] AS [Alert Type Description]
	,[AlertTypeId] AS [Alert Type Id]
	,[IsCountedInReport] AS [Is Counted In Report]
FROM WCG_DW.dbo.DimAlertType WITH (NOLOCK)
