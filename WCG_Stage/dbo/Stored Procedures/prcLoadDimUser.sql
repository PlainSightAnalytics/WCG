
CREATE PROCEDURE [dbo].[prcLoadDimUser]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17 June 2016
-- Reason				:	Performs SCD Logic for DimUser using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimUser] -1
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
	 UserID
	,[User]
	,InfrastructureNumber
	,UserTrafficCentre
	,Designation
	,[Role]
FROM WCG_STAGE.itis.transformDimUser
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimUser dim
USING conf
ON (dim.[UserID] = conf.[UserId])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			[UserID], [User], [InfrastructureNumber], [UserTrafficCentre], [Designation] , [Role],
			InsertAuditKey, UpdateAuditKey
			)
	VALUES (
			conf.[UserID], conf.[User], conf.[InfrastructureNumber], conf.[UserTrafficCentre], conf.[Designation] , conf.[Role],
			@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[User] <> conf.[User]
		OR dim.[InfrastructureNumber] <> conf.[InfrastructureNumber]
		OR dim.[UserTrafficCentre] <> conf.[UserTrafficCentre]
		OR dim.[Designation] <> conf.[Designation]
		OR dim.[Role] <> conf.[Role]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[User] = conf.[User],
			dim.[InfrastructureNumber] = conf.[InfrastructureNumber],
			dim.[UserTrafficCentre] = conf.[UserTrafficCentre],
			dim.[Designation] = conf.[Designation],
			dim.[Role] = conf.[Role],
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimUser



;
;
;
;