
CREATE VIEW [model].[Operator] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimOperator
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [OperatorKey] AS [OperatorKey]
	,[Authority] AS [Authority]
	,[Centre] AS [Centre]
	,[District] AS [District]
	,[FirstName] AS [First Name]
	,[IDNumber] AS [ID Number]
	,[InfrastructureNumber] AS [Infrastructure Number]
	,[IsOperator] AS [Is Operator]
	,[Municipality] AS [Municipality]
	,[Operator] AS [Operator]
	,[OperatorCertificate] AS [Operator Certificate]
	,[OperatorID] AS [Operator ID]
	,[Province] AS [Province]
	,[RegionalArea] AS [Regional Area]
	,[Role] AS [Role]
	,[Surname] AS [Surname]
FROM WCG_DW.dbo.DimOperator WITH (NOLOCK)
