

CREATE VIEW [man].[transformFactCriminalOffensesDRUGENFORCEMENT] AS  

WITH conformCTE AS (
SELECT
	 CAST(Date AS INT) AS DateKey
	,CAST(TrafficCentreGUID AS uniqueidentifier) AS TrafficCentreGUID
	,CAST(NULLIF(MagisterialAreaGUID,'') AS uniqueidentifier) AS MagisterialCourtGUID
	,RefNo
	,DrugType
	,NULLIF(Details,'') AS Details
	,NULLIF(Location,'') AS Location
	,NULLIF(ROUTE,'') AS Route
	,NULLIF(VehicleType,'') AS VehicleType
	,NULLIF(Quantity,'') AS Quantity
	,NULLIF(QuantityUOM,'') AS QuantityUOM
	,NULLIF(Value,'') AS Value
FROM man.DRUGENFORCEMENT
)

SELECT
	 ISNULL(d1.DateKey,-1)															AS OffenceDateKey
	,ISNULL(d2.MagistratesCourtKey,-1)												AS MagistratesCourtKey
	,ISNULL(d3.TrafficCentreKey,-1)													AS TrafficCentreKey
	,CAST(RefNo	AS VARCHAR(30))														AS CaseNo
	,CAST('Drugs Posession' AS VARCHAR(50))											AS ChargeCategory
	,CAST(DrugType AS VARCHAR(50))													AS ChargeSubCategory
	,REPLACE(
		CONCAT(
			' Route: ' + Route,
			' Location: ' + Location,
			' Vehicle Type: ' + VehicleType,
			' Details: ' + Details),'"','')											AS Details
	,CONCAT(
		Quantity, ' ' + QuantityUOM)												AS Quantity
	,CAST('DRUGENFORCEMENT' AS VARCHAR(30))											AS Source
	,CAST('DRUGS' AS VARCHAR(10))													AS CrimeType
	,CAST(Value AS NUMERIC(19,2))													AS Value
FROM conformCTE cnf
LEFT JOIN WCG_DW.dbo.DimDate d1 ON cnf.DateKey = d1.DateKey
LEFT JOIN WCG_DW.dbo.DimMagistratesCourt d2 ON cnf.MagisterialCourtGUID = d2.MagistratesCourtID
LEFT JOIN WCG_DW.dbo.DimTrafficCentre d3 ON cnf.TrafficCentreGUID = d3.TrafficCentreID
