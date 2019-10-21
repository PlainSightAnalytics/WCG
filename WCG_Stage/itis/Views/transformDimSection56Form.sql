




CREATE VIEW [itis].[transformDimSection56Form] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	05-05-2018
-- Reason				:	Transform view for DimRosterGroup
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	15-07-2019
-- Reason				:	Fixed int overflow error for age. Added Ranges for valid ages
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	23-07-2019
-- Reason				:	Converted datetime fields to GMT+2 (SA Time)
--							Changed Surname to Uppercase
--------------------------------------------------------------------------------------------------------------------------------------


SELECT
  	 CAST(ISNULL(court_code,'N/A') AS VARCHAR(10))					AS [CourtCode]
	,CAST(ISNULL(court_name,'Not Applicable') AS VARCHAR(50))		AS [CourtName]
	,CAST(
		CAST(time_generated AS DATETIMEOFFSET) 
		AT TIME ZONE 'South Africa Standard Time'
		 AS DATETIME)												AS [GeneratedDateTime]
	,CAST(ISNULL(manual_entry_display,'No') AS VARCHAR(3))			AS [IsManualEntry]
	,CAST(ISNULL(drivers_license_code,'Unknown') AS VARCHAR(100))	AS [LicenceCode]
	,s.id															AS [Section56FormGUID]
	,CAST(ISNULL(number,'Unknown') AS VARCHAR(50))					AS [Section56Number]
	,CAST(
		CASE
			WHEN CAST(age AS BIGINT) < 16 THEN 0
			WHEN CAST(age AS BIGINT) > 100 THEN 0
			ELSE ISNULL(age,0)
		END AS INT)													AS [SubjectAge]
	,CAST(UPPER(name) AS VARCHAR(50))								AS [SubjectFirstNames]
	,CAST(ISNULL(driver_sex_display,'Unknown') AS VARCHAR(10))		AS [SubjectGender]
	,CAST(ISNULL(id_number,'Unknown') AS VARCHAR(20))				AS [SubjectIDNumber]
	,CAST(ISNULL(non_za_id_number,'Not Applicable') AS VARCHAR(50)) AS [SubjectIDNumberForeign]
	,CAST(ISNULL(nationality_display,'Unknown') AS VARCHAR(30))		AS [SubjectNationality]
	,UPPER(CAST(ISNULL(surname,'Unknown') AS VARCHAR(50)))			AS [SubjectSurname]
	,ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC)	AS [RowSequence]
FROM [itis].[section56_form] s WITH (NOLOCK)



