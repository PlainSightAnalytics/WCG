

CREATE PROCEDURE [dbo].[prcLoadDimEBATRolePlayerUser]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-10-2017
-- Reason				:	Performs SCD Logic for DimEBATRolePlayer from User using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimEBATRolePlayerUser] -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
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
	 Authority
	,CentreOrStation
	,District
	,EBATRolePlayerID
	,FirstName
	,IDNumber
	,InfrastructureNumber
	,IsOperator
	,MobileNumber
	,Municipality
	,Province
	,RankOrRole
	,Surname
FROM WCG_STAGE.ebat.transformDimEBATRolePlayerUser
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimEBATRolePlayer dim
USING conf
ON (dim.EBATRolePlayerID = conf.EBATRolePlayerID)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		Authority, CentreOrStation, District, EBATRolePlayerID, FirstName, IDNumber, InfrastructureNumber, IsOperator,
		MobileNumber, Municipality, Province, RankOrRole, Surname, InsertAuditKey, UpdateAuditKey
			)
	VALUES (
		conf.Authority, conf.CentreOrStation, conf.District, conf.EBATRolePlayerID, conf.FirstName, conf.IDNumber, conf.InfrastructureNumber, conf.IsOperator,
		conf.MobileNumber, conf.Municipality, conf.Province, conf.RankOrRole, conf.Surname,@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.Authority			   <> conf.Authority
		OR dim.CentreOrStation		   <> conf.CentreOrStation
		OR dim.District				   <> conf.District
		OR dim.FirstName			   <> conf.FirstName
		OR dim.IDNumber				   <> conf.IDNumber
		OR dim.InfrastructureNumber	   <> conf.InfrastructureNumber
		OR dim.IsOperator			   <> conf.IsOperator
		OR dim.MobileNumber			   <> conf.MobileNumber
		OR dim.Municipality			   <> conf.Municipality
		OR dim.Province				   <> conf.Province
		OR dim.RankOrRole			   <> conf.RankOrRole
		OR dim.Surname				   <> conf.Surname
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.Authority				 = conf.Authority,
			dim.CentreOrStation			 = conf.CentreOrStation,
			dim.District				 = conf.District,
			dim.FirstName				 = conf.FirstName,
			dim.IDNumber				 = conf.IDNumber,
			dim.InfrastructureNumber	 = conf.InfrastructureNumber,
			dim.IsOperator				 = conf.IsOperator,
			dim.MobileNumber			 = conf.MobileNumber,
			dim.Municipality			 = conf.Municipality,
			dim.Province				 = conf.Province,
			dim.RankOrRole				 = conf.RankOrRole,
			dim.Surname					 = conf.Surname,
			
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





