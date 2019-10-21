
CREATE VIEW [model].[Section 56 Form] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   06 May 2018 1:44:35 PM
-- Reason               :   Semantic View for dbo.DimSection56Form
-- Modified By          :
-- Modified On          :
-- Reason               :
------------------------------------------------------------------------------------------
SELECT 
	 [Section56FormKey] AS [Section56FormKey]
	,[CourtCode] AS [Court Code]
	,[CourtName] AS [Court Name]
	,[GeneratedDateTime] AS [Generated Date Time]
	,[IsManualEntry] AS [Is Manual Entry]
	,[LicenceCode] AS [Licence Code]
	,[Section56FormGUID] AS [Section 56 Form GUID]
	,[Section56Number] AS [Section 56 Number]
	,[SubjectAge] AS [Subject Age]
	,[SubjectFirstNames] AS [Subject First Names]
	,[SubjectGender] AS [Subject Gender]
	,[SubjectIDNumber] AS [Subject ID Number]
	,[SubjectIDNumberForeign] AS [Subject ID Number Foreign]
	,[SubjectNationality] AS [Subject Nationality]
	,[SubjectSurname] AS [Subject Surname]
FROM WCG_DW.dbo.DimSection56Form WITH (NOLOCK)
