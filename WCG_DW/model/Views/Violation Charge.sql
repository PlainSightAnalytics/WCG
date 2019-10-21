
CREATE VIEW [model].[Violation Charge] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   06 May 2018 1:44:35 PM
-- Reason               :   Semantic View for dbo.DimViolationCharge
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [ViolationChargeKey] AS [ViolationChargeKey]
	,[ChargeAmount] AS [Charge Amount]
	,[ChargeCategory] AS [Charge Category]
	,[ChargeCategoryOrder] AS [Charge Category Order]
	,[ChargeCode] AS [Charge Code]
	,[ChargeDescription] AS [Charge Description]
	,[ChargeGUID] AS [Charge GUID]
	,[ChargeSubCategory] AS [Charge Sub Category]
	,[ChargeSubCategoryOrder] AS [Charge Sub Category Order]
	,[RegulationNumber] AS [Regulation Number]
FROM WCG_DW.dbo.DimViolationCharge WITH (NOLOCK)
