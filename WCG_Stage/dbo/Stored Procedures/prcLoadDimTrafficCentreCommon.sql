

CREATE PROCEDURE [dbo].[prcLoadDimTrafficCentreCommon]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	04-02-2019
-- Reason				:	Performs SCD Logic for DimTrafficCentre using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @SchemaName
-- Ouputs				:	None
-- Test					:	dbo.prcLoadDimTrafficCentre -1, 'pnd'
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
		 EmailAddress
		,TelephoneNo
		,TrafficCentre
		,TrafficCentreID
	FROM WCG_STAGE.pnd.transformDimTrafficCentre
	)
	/* Handle SCD1 Changes */
	MERGE INTO WCG_DW.dbo.DimTrafficCentre dim
	USING conf
	ON (dim.TrafficCentreID = conf.TrafficCentreID)
	WHEN NOT MATCHED THEN /* New Records */
		INSERT (
			 EmailAddress
			,TelephoneNo
			,TrafficCentre
			,TrafficCentreID
			,InsertAuditKey
			,UpdateAuditKey
				)
		VALUES (
			 conf.EmailAddress
			,conf.TelephoneNo
			,conf.TrafficCentre
			,conf.TrafficCentreID
			,@AuditKey
			,@AuditKey
				)

	OUTPUT $action into @rowcounts;			

	SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
	SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
	SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.pnd.transformDimTrafficCentre

END




