CREATE PROCEDURE [dbo].[prcLoadDimJourneyUserCommon]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	04-02-2019
-- Reason				:	Performs SCD Logic for DimJourneyUser using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey, @SchemaName
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimJourneyUser] -1, 'pnd'
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@SchemaName VARCHAR(10)

AS

SET FMTONLY OFF
SET NOCOUNT ON

DECLARE
@RowCountInsert INT,
@RowCountUpdate INT,
@RowCountExtract INT

DECLARE @RowCounts TABLE
(mergeAction varchar(10));

IF @SchemaName = 'pnd'
BEGIN

	WITH conf AS (
	SELECT
		 EmployeeNumber
		,FirstName
		,IDNumber
		,InfrastructureNumber
		,IsActive
		,MobileNo
		,PoundFacility
		,[Rank]
		,[Role]
		,Surname
		,TrafficCentre
		,JourneyUserID
	FROM WCG_STAGE.pnd.transformDimJourneyUser
	)
	/* Handle SCD1 Changes */
	MERGE INTO WCG_DW.dbo.DimJourneyUser dim
	USING conf
	ON (dim.JourneyUserID = conf.JourneyUserID)
	WHEN NOT MATCHED THEN /* New Records */
		INSERT (
			 EmployeeNumber
			,FirstName
			,IDNumber
			,InfrastructureNumber
			,IsActive
			,MobileNo
			,PoundFacility
			,[Rank]
			,[Role]
			,Surname
			,TrafficCentre
			,JourneyUserID
			,InsertAuditKey
			,UpdateAuditKey
				)
		VALUES (
			 conf.EmployeeNumber
			,conf.FirstName
			,conf.IDNumber
			,conf.InfrastructureNumber
			,conf.IsActive
			,conf.MobileNo
			,conf.PoundFacility
			,conf.[Rank]
			,conf.[Role]
			,conf.Surname
			,conf.TrafficCentre
			,conf.JourneyUserID
			,@AuditKey
			,@AuditKey
				)
		WHEN MATCHED 
		AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
		AND (
				dim.EmployeeNumber		  <> conf.EmployeeNumber
			OR	dim.FirstName			  <> conf.FirstName
			OR	dim.IDNumber			  <> conf.IDNumber
			OR	dim.InfrastructureNumber  <> conf.InfrastructureNumber
			OR	dim.IsActive			  <> conf.IsActive
			OR	ISNULL(dim.MobileNo,'')	  <> ISNULL(conf.MobileNo,'')
			OR	dim.PoundFacility		  <> conf.PoundFacility
			OR	dim.[Rank]				  <> conf.[Rank]
			OR	dim.[Role]				  <> conf.[Role]
			OR	dim.Surname				  <> conf.Surname
			OR	dim.TrafficCentre		  <> conf.TrafficCentre

			) 	/* Check if any Type 1 Fields have changed */
		THEN 
			UPDATE 
			SET 
				/* Update Type 1 Fields */
				dim.EmployeeNumber		  = conf.EmployeeNumber,
				dim.FirstName			  = conf.FirstName,
				dim.IDNumber			  = conf.IDNumber,
				dim.InfrastructureNumber  = conf.InfrastructureNumber,
				dim.IsActive			  = conf.IsActive,
				dim.MobileNo			  = conf.MobileNo,
				dim.PoundFacility		  = conf.PoundFacility,
				dim.[Rank]				  = conf.[Rank],
				dim.[Role]				  = conf.[Role],
				dim.Surname				  = conf.Surname,
				dim.TrafficCentre		  = conf.TrafficCentre,
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
	SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.pnd.transformDimJourneyUser

END

