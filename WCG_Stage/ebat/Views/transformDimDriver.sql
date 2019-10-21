CREATE VIEW [ebat].[transformDimDriver] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	01-09-2018
-- Reason				:	Transform view for Driver
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

WITH CTE AS (
SELECT
	 CAST(date_of_birth	AS DATE)																AS DateOfBirth
	,CAST(ISNULL(sex_captured_display,'Unknown') AS VARCHAR(10))								AS Gender
	,CAST(COALESCE(enatis_id_document_number,id_number_captured,'Unknown') AS VARCHAR(20))		AS IDDocumentNo
	,CAST(ISNULL(enatis_id_document_type,'Unknown') AS VARCHAR(30))								AS IDDocumentType
	,CAST(COALESCE(initials	,initials_captured) AS VARCHAR(5))									AS Initials
	,CAST(ISNULL(license_type_code_captured,'Unknown') AS VARCHAR(50))							AS LicenseType
	,CAST(COALESCE(license_expiry_date_captured,license_expiry_date) AS DATE)					AS LicenseExpiryDate
	,CAST(license_date_of_first_issue AS DATE)													AS LicenseFirstDate
	,CAST(COALESCE(surname,surname_captured,'Unknown') AS VARCHAR(50))							AS Surname
	,ROW_NUMBER() OVER (
				  PARTITION BY DeltaLogKey, COALESCE(enatis_id_document_number,id_number_captured) 
				  ORDER BY updated_at DESC)														AS [RowNumber]
	,DeltaLogKey																				AS [DeltaLogKey]
FROM [WCG_Stage].[ebat].driver
)

SELECT 
	 [DateOfBirth]
	,[Gender]
	,[IDDocumentNo]
	,[IDDocumentType]
	,[Initials]
	,[LicenseType]
	,[LicenseExpiryDate]
	,[LicenseFirstDate]
	,[Surname]
	,[DeltaLogKey]
FROM CTE
WHERE NULLIF(IDDocumentNo,'') IS NOT NULL
AND RowNumber = 1











