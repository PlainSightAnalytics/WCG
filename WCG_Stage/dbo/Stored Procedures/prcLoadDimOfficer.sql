
CREATE PROCEDURE [dbo].[prcLoadDimOfficer]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	14 August 2016
-- Reason				:	Performs SCD Logic for DimMagisgtratesCourt using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimOfficer] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT = -1

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
	 OfficerID
	,Officer
	,FirstNames
	,Surname
	,Initials
	,[Rank]
	,InfrastructureNumber
	,IDNumber
	,MobileNumber
	,OtherAuthority
	,OtherRank
	,OtherStation
	,Station
	,Authority
	,Municipality
	,District
	,Province
FROM WCG_STAGE.ebat.transformDimOfficer
--WHERE DeltaLogKey = @DeltaLogKey
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimOfficer dim
USING conf
ON (dim.[OfficerID] = conf.[OfficerID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 OfficerID,Officer,FirstNames,Surname,Initials,[Rank],InfrastructureNumber,IDNumber,MobileNumber,OtherAuthority,
		 OtherRank,OtherStation,Station,Authority,Municipality,District,Province,InsertAuditKey,UpdateAuditKey
			)
	VALUES (
		 OfficerID,Officer,FirstNames,Surname,Initials,[Rank],InfrastructureNumber,IDNumber,MobileNumber,OtherAuthority,
		 OtherRank,OtherStation,Station,Authority,Municipality,District,Province,@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		dim.[Officer] <> conf.[Officer]
		OR dim.[FirstNames] <> conf.[FirstNames]
		OR dim.[Surname] <> conf.[Surname]
		OR dim.[Initials] <> conf.[Initials]
		OR dim.[Rank] <> conf.[Rank]
		OR dim.[InfrastructureNumber] <> conf.[InfrastructureNumber]
		OR dim.[IDNumber] <> conf.[IDNumber]
		OR dim.[MobileNumber] <> conf.[MobileNumber]
		OR dim.[OtherAuthority] <> conf.[OtherAuthority]
		OR dim.[OtherRank] <> conf.[OtherRank]
		OR dim.[OtherStation] <> conf.[OtherStation]
		OR dim.[Station] <> conf.[Station]
		OR dim.[Authority] <> conf.[Authority]
		OR dim.[Municipality] <> conf.[Municipality]
		OR dim.[District] <> conf.[District]
		OR dim.[Province] <> conf.[Province]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[Officer] = conf.[Officer],
			dim.[FirstNames] = conf.[FirstNames],
			dim.[Surname] = conf.[Surname],
			dim.[Initials] = conf.[Initials],
			dim.[Rank] = conf.[Rank],
			dim.[InfrastructureNumber] = conf.[InfrastructureNumber],
			dim.[IDNumber] = conf.[IDNumber],
			dim.[MobileNumber] = conf.[MobileNumber],
			dim.[OtherAuthority] = conf.[OtherAuthority],
			dim.[OtherRank] = conf.[OtherRank],
			dim.[OtherStation] = conf.[OtherStation],
			dim.[Station] = conf.[Station],
			dim.[Authority] = conf.[Authority],
			dim.[Municipality] = conf.[Municipality],
			dim.[District] = conf.[District],
			dim.[Province] = conf.[Province],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.ebat.transformDimOfficer




;
;
;

;
