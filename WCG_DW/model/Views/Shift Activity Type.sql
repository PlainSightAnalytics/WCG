
CREATE VIEW [model].[Shift Activity Type] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   28 Oct 2018 1:35:42 PM
-- Reason               :   Semantic View for dbo.DimShiftActivityType
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ShiftActivityTypeKey] AS [ShiftActivityTypeKey]
	,[ShiftActivityType] AS [Shift Activity Type]
	,[ShiftActivityTypeCode] AS [Shift Activity Type Code]
FROM WCG_DW.dbo.DimShiftActivityType WITH (NOLOCK)
