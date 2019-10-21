

CREATE VIEW [man].[transformFactCriminalOffensesFIOCNOTICES] AS  

WITH conformCTE AS (
SELECT
	 NULLIF(
		CONCAT(
			SUBSTRING(OffenceDate,7,4)
			,SUBSTRING(OffenceDate,4,2)
			,SUBSTRING(OffenceDate,1,2)
	),'') AS DateKey
	,CAST(NULLIF([Traffic Centre GUID],'') AS uniqueidentifier) AS TrafficCentreGUID
	,CAST(NULLIF([Magistrates Court GUID],'') AS uniqueidentifier) AS MagisterialCourtGUID
	,NULLIF(NoticeNumber,'') AS CaseNo
	,NULLIF(Charge1,'') AS Charge1
	,NULLIF(OrigFine,'') AS OrigFine
	,NULLIF(NULLIF(ID_NO,''),'0') AS ID_No
	,NULLIF(Regno,'') AS RegNo
	,NULLIF(Name,'') AS Name
	,NULLIF(Surname,'') AS Surname
FROM man.FIOCNOTICES
)

SELECT
	 ISNULL(d1.DateKey,-1)															AS OffenceDateKey
	,ISNULL(d2.MagistratesCourtKey,-1)												AS MagistratesCourtKey
	,ISNULL(d3.TrafficCentreKey,-1)													AS TrafficCentreKey
	,CAST(CaseNo	AS VARCHAR(30))													AS CaseNo
	,CAST(ISNULL(d4.ChargeCategory,'Charage Code: ' + Charge1) AS VARCHAR(50))		AS ChargeCategory
	,CAST(ISNULL(d4.ChargeSubCategory,'Unknown') AS VARCHAR(50))					AS ChargeSubCategory
	,CONCAT(
		' ID No: ' + ID_NO + ',',
		'Registration: ' + Regno + ',',
		'Name of Accused: ' + Surname + ',' + Name)									AS Details
	,d4.chargedescription															AS Quantity
	,CAST('FIOCNOTICES' AS VARCHAR(30))												AS Source
	,CAST('ARRESTS' AS VARCHAR(10))													AS CrimeType
	,CAST(OrigFine AS NUMERIC(19,2))												AS Value
FROM conformCTE cnf
LEFT JOIN WCG_DW.dbo.DimDate d1 ON cnf.DateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimMagistratesCourt d2 ON cnf.MagisterialCourtGUID = d2.MagistratesCourtID
LEFT JOIN WCG_DW.dbo.DimTrafficCentre d3 ON cnf.TrafficCentreGUID = d3.TrafficCentreID
LEFT JOIN WCG_DW.dbo.DimViolationCharge d4 ON cnf.Charge1 = d4.ChargeCode
