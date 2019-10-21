
CREATE VIEW [model].[User] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   25 Feb 2018 1:34:43 PM
-- Reason               :   Semantic View for dbo.DimUser
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [UserKey] AS [UserKey]
	,[Designation] AS [Designation]
	,[InfrastructureNumber] AS [Infrastructure Number]
	,[Role] AS [Role]
	,[User] AS [User]
	,[UserID] AS [User ID]
	,[UserTrafficCentre] AS [User Traffic Centre]
FROM WCG_DW.dbo.DimUser WITH (NOLOCK)
