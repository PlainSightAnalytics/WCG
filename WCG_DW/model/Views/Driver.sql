
CREATE VIEW [model].[Driver] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   02 Sep 2018 11:40:51 AM
-- Reason               :   Semantic View for dbo.DimDriver
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [DriverKey] AS [DriverKey]
	,[Country] AS [Country]
	,[DateOfBirth] AS [Date Of Birth]
	,[Gender] AS [Gender]
	,[IDDocumentNo] AS [ID Document No]
	,[IDDocumentType] AS [ID Document Type]
	,[Initials] AS [Initials]
	,[LicenseExpiryDate] AS [License Expiry Date]
	,[LicenseFirstDate] AS [License First Date]
	,[LicenseNumber] AS [License Number]
	,[LicenseType] AS [License Type]
	,[Surname] AS [Surname]
FROM WCG_DW.dbo.DimDriver WITH (NOLOCK)
