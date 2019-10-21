
CREATE VIEW [model].[Journey User] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   08 Feb 2019 8:59:49 AM
-- Reason               :   Semantic View for dbo.DimJourneyUser
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [JourneyUserKey] AS [JourneyUserKey]
	,[EmployeeNumber] AS [Employee Number]
	,[FirstName] AS [First Name]
	,[IDNumber] AS [ID Number]
	,[InfrastructureNumber] AS [Infrastructure Number]
	,[IsActive] AS [Is Active]
	,[JourneyUserID] AS [Journey User ID]
	,[MobileNo] AS [Mobile No]
	,[PoundFacility] AS [Pound Facility]
	,[Rank] AS [Rank]
	,[Role] AS [Role]
	,[Surname] AS [Surname]
	,[TrafficCentre] AS [Traffic Centre]
FROM WCG_DW.dbo.DimJourneyUser WITH (NOLOCK)
