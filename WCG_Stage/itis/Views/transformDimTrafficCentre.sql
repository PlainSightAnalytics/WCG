





CREATE VIEW [itis].[transformDimTrafficCentre] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	22-08-2016
-- Reason				:	Transform view for DimTrafficCentre
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	23-09-2018
-- Reason				:	Add SecurityEmailList
--------------------------------------------------------------------------------------------------------------------------------------


SELECT  
	 tc.id															AS TrafficCentreId
	,CAST(tc.name AS VARCHAR(50))									AS TrafficCentre
	,CAST(ISNULL(tc.email,'Unknown') AS VARCHAR(50))				AS EmailAddress
	,CAST(ISNULL(tc.telephone_number,'Unknown') AS VARCHAR(20))		AS TelephoneNo
	,CAST(CASE WHEN PATINDEX('%Somerset%',tc.name) > 0 THEN 'SOMERSETWEST'
	    WHEN PATINDEX('%Beaufort%',tc.name) > 0 THEN 'BEAUFORTWEST'
		WHEN PATINDEX('%Laingsburg%',tc.name) > 0 THEN 'LAINGSBURG'
		WHEN PATINDEX('%Brackenfell%',tc.name) > 0 THEN 'BRACKENFELL'
		WHEN PATINDEX('%Worcester%',tc.name) > 0 THEN 'WORCESTER'
		WHEN PATINDEX('%Caledon%',tc.name) > 0 THEN 'CALEDON'
		WHEN PATINDEX('%Vredenburg%',tc.name) > 0 THEN 'VREDENBURG'
		WHEN CHARINDEX(' ',tc.name,1) > 0 THEN UPPER(SUBSTRING(tc.name,1,CHARINDEX(' ',tc.name,1)))
		ELSE UPPER(tc.name)
	END AS VARCHAR(50))												AS TrafficCentreCode
	,CAST(CASE WHEN PATINDEX('%Somerset%',tc.name) > 0 THEN 'Somerset West'
	    WHEN PATINDEX('%Beaufort%',tc.name) > 0 THEN 'Beaufort West'
		WHEN PATINDEX('%Laingsburg%',tc.name) > 0 THEN 'Laingsburg'
		WHEN PATINDEX('%Brackenfell%',tc.name) > 0 THEN 'Brackenfell'
		WHEN PATINDEX('%Worcester%',tc.name) > 0 THEN 'Worcester'
		WHEN PATINDEX('%Caledon%',tc.name) > 0 THEN 'Caledon'
		WHEN PATINDEX('%Vredenburg%',tc.name) > 0 THEN 'Vredenburg'
		WHEN CHARINDEX(' ',tc.name,1) > 0 THEN SUBSTRING(tc.name,1,CHARINDEX(' ',tc.name,1))
		ELSE tc.name
	END	AS VARCHAR(50))												AS TCC
	,CAST(CASE WHEN PATINDEX('%Somerset%',tc.name) > 0 THEN 'Peter Michaels'
	    WHEN PATINDEX('%Beaufort%',tc.name) > 0 THEN 'Bradley Singh'
		WHEN PATINDEX('%Laingsburg%',tc.name) > 0 THEN 'Bradley Singh'
		WHEN PATINDEX('%Brackenfell%',tc.name) > 0 THEN 'Peter Michaels'
		WHEN PATINDEX('%Worcester%',tc.name) > 0 THEN 'Bradley Singh'
		WHEN PATINDEX('%Caledon%',tc.name) > 0 THEN 'Pat Curran'
		WHEN PATINDEX('%Vredenburg%',tc.name) > 0 THEN 'Bradley Singh'
		ELSE 'Unknown'
	END AS VARCHAR(50))												AS RegionalDirector
	,CAST(ISNULL(mc.name,'Unknown') AS VARCHAR(50))					AS MagistratesCourt
	,CAST(ISNULL(mc.number,'Unknown') AS VARCHAR(20))				AS MagistratesCourtNumber
	,CAST(ISNULL(mc.code,'Unknown') AS VARCHAR(20))					AS MagistratesCourtCode
	,CAST(ISNULL(mu.name,'Unknown') AS VARCHAR(50))					AS Municipality
	,CAST(ISNULL(mu.place_of_payment,'Unknown') AS VARCHAR(100))	AS MunicipalityPlaceOfPayment
	,CAST(ISNULL(mu.electronic_payment,'No') AS VARCHAR(3))			AS MunicipalityHasElectronicPayment
	,CAST(ISNULL(mu.post_payment,'No') AS VARCHAR(3))				AS MunicipalityHasPostalPayment
	,CAST(ISNULL(d.name,'Unknown') AS VARCHAR(50))					AS District
	,CAST(ISNULL(ra.name,'Unknown') AS VARCHAR(50))					AS RegionalArea
	,CAST(ISNULL(a.name,'Unknown') AS VARCHAR(50))					AS Authority
	,CAST(ISNULL(p.name,'Unknown') AS VARCHAR(50))					AS Province
	,CAST(tc.power_bi_users AS VARCHAR(1000))						AS SecurityEmailList
FROM itis.traffic_centre tc
LEFT JOIN itis.magistrates_court mc ON tc.magistrates_court_id = mc.id
LEFT JOIN itis.municipality mu ON mc.municipality_id = mu.id
LEFT JOIN itis.district d ON mu.district_id = d.id
LEFT JOIN itis.regional_area ra ON tc.regional_area_id = ra.id
LEFT JOIN itis.authority a ON ra.authority_id = a.id
LEFT JOIN itis.province p ON a.province_id = p.id


