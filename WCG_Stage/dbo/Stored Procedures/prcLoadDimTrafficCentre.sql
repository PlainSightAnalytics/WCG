
CREATE PROCEDURE [dbo].[prcLoadDimTrafficCentre]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17 June 2016
-- Reason				:	Performs SCD Logic for DimTrafficCentre using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	dbo.prcLoadDimTrafficCentre -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   Trevor Howe
-- Modified On			:   22 August 2016
-- Reason				:   Add additional attributes from multiple json tables
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   Trevor Howe
-- Modified On			:   23-09-2018
-- Reason				:   Add SecurityEmailList
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT

AS

SET FMTONLY OFF
SET NOCOUNT ON

DECLARE
@RowCountInsert INT,
@RowCountUpdate INT,
@RowCountExtract INT

DECLARE @RowCounts TABLE
(mergeAction varchar(10));

WITH conf AS (
SELECT
	 TrafficCentreId
	,TrafficCentre
	,EmailAddress
	,TelephoneNo
	,TrafficCentreCode
	,TCC
	,RegionalDirector
	,MagistratesCourt
	,MagistratesCourtNumber
	,MagistratesCourtCode
	,Municipality
	,MunicipalityPlaceOfPayment
	,MunicipalityHasElectronicPayment
	,MunicipalityHasPostalPayment
	,District
	,RegionalArea
	,Authority
	,Province
	,SecurityEmailList
FROM WCG_STAGE.itis.transformDimTrafficCentre
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimTrafficCentre dim
USING conf
ON (dim.TrafficCentreID = conf.TrafficCentreID)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			TrafficCentreID, TrafficCentreCode, TrafficCentre, TCC, RegionalDirector, MagistratesCourt, MagistratesCourtNumber, MagistratesCourtCode
			,Municipality, MunicipalityPlaceOfPayment, MunicipalityHasElectronicPayment, MunicipalityHasPostalPayment, District, RegionalArea
			,Authority, Province, SecurityEmailList, InsertAuditKey, UpdateAuditKey
			)
	VALUES (
			conf.TrafficCentreID, conf.TrafficCentreCode, conf.TrafficCentre, conf.TCC, conf.RegionalDirector, conf.MagistratesCourt
			,conf.MagistratesCourtNumber, conf.MagistratesCourtCode, conf.Municipality, conf.MunicipalityPlaceOfPayment, conf.MunicipalityHasElectronicPayment
			,conf.MunicipalityHasPostalPayment, conf.District, conf.RegionalArea, conf.Authority, conf.Province, conf.SecurityEmailList, @AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.TrafficCentreCode <> conf.TrafficCentreCode
		OR dim.TrafficCentre <> conf.TrafficCentre
		OR dim.TCC <> conf.TCC
		OR dim.RegionalDirector <> conf.RegionalDirector
		OR dim.MagistratesCourt <> conf.MagistratesCourt
		OR dim.MagistratesCourtNumber <> conf.MagistratesCourtNumber
		OR dim.MagistratesCourtCode <> conf.MagistratesCourtCode
		OR dim.Municipality <> conf.Municipality
		OR dim.MunicipalityPlaceOfPayment <> conf.MunicipalityPlaceOfPayment
		OR dim.MunicipalityHasElectronicPayment <> conf.MunicipalityHasElectronicPayment
		OR dim.MunicipalityHasPostalPayment <> conf.MunicipalityHasPostalPayment
		OR dim.District <> conf.District
		OR dim.RegionalArea <> conf.RegionalArea
		OR dim.Authority <> conf.Authority
		OR dim.Province <> conf.Province
		OR ISNULL(dim.SecurityEmailList,'') <> ISNULL(conf.SecurityEmailList,'')
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.TrafficCentreCode = conf.TrafficCentreCode,
			dim.TrafficCentre = conf.TrafficCentre,
			dim.TCC = conf.TCC,
			dim.RegionalDirector = conf.RegionalDirector,
			dim.MagistratesCourt = conf.MagistratesCourt,
			dim.MagistratesCourtNumber = conf.MagistratesCourtNumber,
			dim.MagistratesCourtCode = conf.MagistratesCourtCode,
			dim.Municipality = conf.Municipality,
			dim.MunicipalityPlaceOfPayment = conf.MunicipalityPlaceOfPayment,
			dim.MunicipalityHasElectronicPayment = conf.MunicipalityHasElectronicPayment,
			dim.MunicipalityHasPostalPayment = conf.MunicipalityHasPostalPayment,
			dim.District = conf.District,
			dim.RegionalArea = conf.RegionalArea,
			dim.Authority = conf.Authority,
			dim.Province = conf.Province,
			dim.SecurityEmailList = conf.SecurityEmailList,
			
			/* Update System Fields */
			dim.UpdateAuditKey = @AuditKey,
			dim.RowIsInferred = 'N',
			dim.RowChangeReason = 
				CASE 
					WHEN dim.RowIsInferred = 'Y' THEN 'Inferred Member Arrived'
					ELSE 'SCD Type 1 Change'
				END
OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimTrafficCentre




;
;
;
;

;