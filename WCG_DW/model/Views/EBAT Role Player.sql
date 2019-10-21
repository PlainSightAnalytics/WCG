
CREATE VIEW [model].[EBAT Role Player] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimEBATRolePlayer
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [EBATRolePlayerKey] AS [EBATRolePlayerKey]
	,[Authority] AS [Authority]
	,[CentreOrStation] AS [Centre Or Station]
	,[District] AS [District]
	,[EBATRolePlayerID] AS [EBAT Role Player ID]
	,[FirstName] AS [First Name]
	,[IDNumber] AS [ID Number]
	,[InfrastructureNumber] AS [Infrastructure Number]
	,[IsOperator] AS [Is Operator]
	,[MobileNumber] AS [Mobile Number]
	,[Municipality] AS [Municipality]
	,[Province] AS [Province]
	,[RankOrRole] AS [Rank Or Role]
	,[Surname] AS [Surname]
FROM WCG_DW.dbo.DimEBATRolePlayer WITH (NOLOCK)
