
CREATE VIEW [fdm].[transformFDMCommodity] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-03-2019
-- Reason				:	Transform view for FDMCommodity
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(CODE						AS VARCHAR(10))		AS [Commodity Code]
	,CAST(Commodity_name			AS VARCHAR(50))		AS [Commodity]
	,CAST(MODELLING_4_LETTER_CODE	AS VARCHAR(10))		AS [Commodity Short Code]
	,CAST(Agr_Min_Mnft				AS VARCHAR(50))		AS [Sector]
	,CAST(Industry_group			AS VARCHAR(50))		AS [Industry Group]
	,CAST(Cargo_type				AS VARCHAR(50))		AS [Cargo Type]
	,CAST(Packaging_type			AS VARCHAR(50))		AS [Packaging Type]
FROM fdm.FDMCommodities
UNION ALL
SELECT DISTINCT
	FDM_COM_Co,
	COMMODITY_,
	COMTYPE,
	SECTOR,
	INDUSTRY_G,
	CARGO_TYPE,
	PACKAGING_
FROM fdm.WesternCapeFDMV1
WHERE FDM_COM_Co NOT IN (
SELECT Code FROM fdm.FDMCommodities)


