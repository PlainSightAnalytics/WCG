
CREATE VIEW [model].[_CriminalOffences]

AS

SELECT
	 OffenceDateKey
	,MagistratesCourtKey
	,TrafficCentreKey
	,CaseNo
	,ChargeCategory
	,ChargeSubCategory
	,Details
	,Quantity
	,Source
	,CrimeType
	,Value
FROM WCG_Stage.man.transformFactCriminalOffensesDRUGENFORCEMENT
UNION ALL
SELECT
	OffenceDateKey
	,MagistratesCourtKey
	,TrafficCentreKey
	,CaseNo
	,ChargeCategory
	,ChargeSubCategory
	,Details
	,Quantity
	,Source
	,CrimeType
	,Value
FROM WCG_Stage.man.transformFactCriminalOffensesILLEGALSUBSTANCE
UNION ALL
SELECT
	 OffenceDateKey
	,MagistratesCourtKey
	,TrafficCentreKey
	,CaseNo
	,ChargeCategory
	,ChargeSubCategory
	,Details
	,Quantity
	,Source
	,CrimeType
	,Value
FROM WCG_Stage.man.transformFactCriminalOffensesFIOCNOTICES
