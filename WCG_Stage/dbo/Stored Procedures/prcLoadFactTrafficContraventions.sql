CREATE PROCEDURE [dbo].[prcLoadFactTrafficContraventions]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-06-2019
-- Reason				:	Load FactTrafficContraventions
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactTrafficContraventions
--------------------------------------------------------------------------------------------------------------------------

@AuditKey INT = -1,
@DeltaLogKey INT = 0

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
	 DriverKey
	,MagistratesCourtKey
	,OffenceDateKey
	,TrafficCentreKey
	,VehicleKey
	,ViolationChargeKey
	,CaseResultDate
	,CourtDate
	,CurrentAmount
	,IssueDate
	,LastAction
	,LastActionDate
	,NoticeNumber
	,NoticeStage
	,NoticeStatus
	,NoticeType
	,OriginalAmount
	,PaidAmount
	,PaymentDueDate
	,PaymentReceiptDate
	,ReceiptNumber
	,ReducedAmount
	,UnequalPaidAmount
	,WarrantDate
	,WithdrawnAmount
FROM [dbo].[LoadFactTrafficCotraventions] conf
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactTrafficContraventions fact
USING conf
ON (fact.NoticeNumber = conf.NoticeNumber)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
	 DriverKey
	,MagistratesCourtKey
	,OffenceDateKey
	,TrafficCentreKey
	,VehicleKey
	,ViolationChargeKey
	,CaseResultDate
	,CourtDate
	,CurrentAmount
	,IssueDate
	,LastAction
	,LastActionDate
	,NoticeNumber
	,NoticeStage
	,NoticeStatus
	,NoticeType
	,OriginalAmount
	,PaidAmount
	,PaymentDueDate
	,PaymentReceiptDate
	,ReceiptNumber
	,ReducedAmount
	,UnequalPaidAmount
	,WarrantDate
	,WithdrawnAmount
	,DeltaLogKey
	,InsertAuditKey
	,UpdateAuditKey
			)
	VALUES (
	 conf.DriverKey
	,conf.MagistratesCourtKey
	,conf.OffenceDateKey
	,conf.TrafficCentreKey
	,conf.VehicleKey
	,conf.ViolationChargeKey
	,conf.CaseResultDate
	,conf.CourtDate
	,conf.CurrentAmount
	,conf.IssueDate
	,conf.LastAction
	,conf.LastActionDate
	,conf.NoticeNumber
	,conf.NoticeStage
	,conf.NoticeStatus
	,conf.NoticeType
	,conf.OriginalAmount
	,conf.PaidAmount
	,conf.PaymentDueDate
	,conf.PaymentReceiptDate
	,conf.ReceiptNumber
	,conf.ReducedAmount
	,conf.UnequalPaidAmount
	,conf.WarrantDate
	,conf.WithdrawnAmount
	,@DeltaLogKey
	,@AuditKey
	,@AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			 fact.DriverKey						= conf.DriverKey
			,fact.MagistratesCourtKey			= conf.MagistratesCourtKey
			,fact.OffenceDateKey				= conf.OffenceDateKey
			,fact.TrafficCentreKey				= conf.TrafficCentreKey
			,fact.VehicleKey					= conf.VehicleKey
			,fact.ViolationChargeKey			= conf.ViolationChargeKey
			,fact.CaseResultDate				= conf.CaseResultDate	
			,fact.CourtDate						= conf.CourtDate
			,fact.CurrentAmount					= conf.CurrentAmount
			,fact.IssueDate						= conf.IssueDate
			,fact.LastAction					= conf.LastAction
			,fact.LastActionDate				= conf.LastActionDate
			,fact.NoticeNumber					= conf.NoticeNumber
			,fact.NoticeStage					= conf.NoticeStage
			,fact.NoticeStatus					= conf.NoticeStatus
			,fact.NoticeType					= conf.NoticeType
			,fact.OriginalAmount				= conf.OriginalAmount
			,fact.PaidAmount					= conf.PaidAmount
			,fact.PaymentDueDate				= conf.PaymentDueDate
			,fact.PaymentReceiptDate			= conf.PaymentReceiptDate
			,fact.ReceiptNumber					= conf.ReceiptNumber
			,fact.ReducedAmount					= conf.ReducedAmount
			,fact.UnequalPaidAmount				= conf.UnequalPaidAmount
			,fact.WarrantDate					= conf.WarrantDate
			,fact.WithdrawnAmount				= conf.WithdrawnAmount
			/* Update System Fields */
			,fact.UpdateAuditKey				= @AuditKey
	OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.man.transformFactTrafficContraventions

/* Update Delta Log
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	RowCountUpdate = @RowCountUpdate,
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey

 */





	



;



;
;
;
;


