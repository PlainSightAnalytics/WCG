
CREATE VIEW [model].[Officer] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimOfficer
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [OfficerKey] AS [OfficerKey]
	,[Authority] AS [Authority]
	,[District] AS [District]
	,[FirstNames] AS [First Names]
	,[IdNumber] AS [Id Number]
	,[InfrastructureNumber] AS [Infrastructure Number]
	,[Initials] AS [Initials]
	,[MobileNumber] AS [Mobile Number]
	,[Municipality] AS [Municipality]
	,[Officer] AS [Officer]
	,[OfficerId] AS [Officer Id]
	,[OtherAuthority] AS [Other Authority]
	,[OtherRank] AS [Other Rank]
	,[OtherStation] AS [Other Station]
	,[Province] AS [Province]
	,[Rank] AS [Rank]
	,[Station] AS [Station]
	,[Surname] AS [Surname]
FROM WCG_DW.dbo.DimOfficer WITH (NOLOCK)
