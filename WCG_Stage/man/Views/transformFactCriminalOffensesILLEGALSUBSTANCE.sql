

CREATE VIEW [man].[transformFactCriminalOffensesILLEGALSUBSTANCE] AS  

WITH conformCTE AS (
SELECT
	 NULLIF(
		CONCAT(
			SUBSTRING(Date,7,4)
			,SUBSTRING(Date,4,2)
			,SUBSTRING(Date,1,2)
	),'') AS DatEkEY
	,CAST(NULLIF(REPLACE([Traffic Centre GUID],'#N/A',''),'') AS uniqueidentifier) AS TrafficCentreGUID
	,CAST(NULLIF(MagistratesCourtGUID,'') AS uniqueidentifier) AS MagisterialCourtGUID
	,[CAS #] AS CaseNo
	,UPPER(NULLIF(Type,'')) AS Type
	,NULLIF([Location of Arrest],'') AS LocationOfArrest
	,NULLIF([Name of Accused],'') AS NameOfAccused
	,NULLIF([Vehicle],'') AS Vehicle
	,Amount
	,[Type of Transgression] AS TypeOfTransgression
	,NULLIF(REPLACE([Monetary Value ],'R',''),'') AS MonetaryValue
FROM man.ILLEGALSUBSTANCE
)

SELECT
	 ISNULL(d1.DateKey,-1)										AS OffenceDateKey
	,ISNULL(d2.MagistratesCourtKey,-1)							AS MagistratesCourtKey
	,ISNULL(d3.TrafficCentreKey,-1)								AS TrafficCentreKey
	,CAST(CaseNo	AS VARCHAR(30))								AS CaseNo
	,CAST('Drugs Posession' AS VARCHAR(50))						AS ChargeCategory
	,CAST(ISNULL(Type,'UNKNOWN') AS VARCHAR(50))				AS ChargeSubCategory
	,REPLACE(
		CONCAT(
			' Location: ' + LocationOfArrest,
			', Vehicle: ' + Vehicle,
			', Name of Accused: ' + NameOfAccused),'"','')		AS Details
	,CONCAT(
		TypeOfTransgression, ' ' + Amount)						AS Quantity
	,CAST('ILLEGALSUBSTANCE' AS VARCHAR(30))					AS Source
	,CAST('DRUGS' AS VARCHAR(10))								AS CrimeType
	,CAST(MonetaryValue AS NUMERIC(19,2))						AS Value
FROM conformCTE cnf
LEFT JOIN WCG_DW.dbo.DimDate d1 ON cnf.DateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimMagistratesCourt d2 ON cnf.MagisterialCourtGUID = d2.MagistratesCourtID
LEFT JOIN WCG_DW.dbo.DimTrafficCentre d3 ON cnf.TrafficCentreGUID = d3.TrafficCentreID
