








CREATE VIEW [cle].[transformDimAlertType] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-06-2016
-- Reason				:	Transform view for DimAlertType
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT DISTINCT 
	 ISNULL(NULLIF(AlertSubTypeCode,''),'Unknown')			AS [AlertSubtypeCode]
	,ISNULL(NULLIF(AlertSubType,''),'Unknown')				AS [AlertSubtype]
	,ISNULL(NULLIF(AlertType,''),'Unknown')					AS [AlertTypeDescription]
	,ISNULL(NULLIF(AlertTypeId,''),-1)						AS [AlertTypeID]
	,CASE
		WHEN AlertType = 'ASOD' THEN 'ASOD'
		WHEN AlertType = 'eNaTIS - SAPS Clearance' THEN 'SAPS Clearance'
		WHEN AlertType = 'eNaTIS - SAPS Mark' THEN 'SAPS Mark'
		WHEN AlertType = 'eNaTIS - Vehicle Licensing Status' THEN 'Licensing'
		WHEN AlertType = 'eNaTIS - Vehicle Life' THEN 'Vehicle Life'
		WHEN AlertType = 'eNaTIS - Vehicle Roadworthy Satus' THEN 'Roadworthy'
		WHEN AlertType = 'PRTS - Operating Licence' THEN 'Operating Licence'
		ELSE 'Unknown'
	END														AS [AlertType]
	,CASE 
		WHEN AlertType IN ('ASOD','Roadworthy','Licensing') THEN 'Yes' 
		ELSE 'No' 
	END														AS [IsCountedInReport]
	,DeltaLogKey											AS [DeltaLogKey]
	,ROW_NUMBER() OVER (
		PARTITION BY DeltaLogKey, AlertSubTypeCode, AlertTypeId 
		ORDER BY AlertDateTime DESC)						AS RowNumber
FROM [WCG_Stage].[cle].Alerts





