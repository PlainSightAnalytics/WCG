

CREATE VIEW [pnd].[transformDimDriver] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	03-02-2019
-- Reason				:	Transform view for DimDriver
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(ISNULL(ii.driver_gender,'Unknown') AS VARCHAR(10))		AS [Gender]
	,CAST(ii.driver_id_number AS VARCHAR(30))						AS [IDDocumentNo]
	,CAST(ISNULL(ii.driver_id_type,'Unknown') AS VARCHAR(30))		AS [IDDocumentType]
	,CAST(
		CASE
			WHEN LEN(ii.driver_name) > 5 THEN SUBSTRING(ii.driver_name,1,1)
			ELSE ii.driver_name 
		END AS VARCHAR(5))											AS [Initials]
	,CAST(driver_licence_expiry AS DATE)							AS [LicenseExpiryDate]
	,CAST(ISNULL(driver_licence_number,'Unknown') AS VARCHAR(20))	AS [LicenseNumber]
	,CAST(ISNULL(driver_licence_code,'Unknown') AS VARCHAR(50))		AS [LicenseType]
	,CAST(ISNULL(driver_surname,'Unknown') AS VARCHAR(50))			AS [Surname]
	,ROW_NUMBER() OVER (
		PARTITION BY ii.driver_id_number, ii.DeltaLogKey 
		ORDER BY updated_at DESC)									AS RowSequence
	,ii.DeltaLogKey													AS [DeltaLogKey]
FROM [WCG_Stage].[pnd].[impound_instruction] ii		WITH (NOLOCK)
WHERE driver_id_number IS NOT NULL









