

CREATE PROCEDURE [dbo].[prcLoadFactEBATEventDuration]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-10-2017
-- Reason				:	Load FactEBATEventDuration using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactEBATEventDuration, -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	15-07-2019
-- Reason				:	Add new foreign key for operations date (OperationsDateKey)
--------------------------------------------------------------------------------------------------------------------------------------

@AuditKey INT,
@DeltaLogKey INT

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
	 EventTimeKey
	,EventDateKey
	,EBATDeviceKey
	,MagistratesCourtKey
	,EBATEventKey
	,EBATIncidentKey
	,EBATRoleKey
	,EBATRolePlayerKey
	,OfficerKey
	,OperationsDateKey
	,OperatorKey
	,UniqueId
	,EventID
	,EventDuration
	,DeltaLogKey
  FROM [dbo].[LoadFactEBATEventDuration] conf
  WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactEBATEventDuration fact
USING conf
ON (fact.UniqueId = conf.UniqueId AND fact.EventId = conf.EventId)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 EventTimeKey
		,EventDateKey
		,EBATDeviceKey
		,MagistratesCourtKey
		,EBATEventKey
		,EBATIncidentKey
		,EBATRoleKey
		,EBATRolePlayerKey
		,OfficerKey
		,OperationsDateKey
		,OperatorKey
		,UniqueId
		,EventID
		,EventDuration
		,DeltaLogKey
		,InsertAuditKey
		,UpdateAuditKey
			)
	VALUES (
		 conf.EventTimeKey
		,conf.EventDateKey
		,conf.EBATDeviceKey
		,conf.MagistratesCourtKey
		,conf.EBATEventKey
		,conf.EBATIncidentKey
		,conf.EBATRoleKey
		,conf.EBATRolePlayerKey
		,conf.OfficerKey
		,conf.OperationsDateKey
		,conf.OperatorKey
		,conf.UniqueId
		,conf.EventID
		,conf.EventDuration
		,conf.DeltaLogKey
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			 fact.EventTimeKey				= conf.EventTimeKey
			,fact.EventDateKey				= conf.EventDateKey
			,fact.EBATDeviceKey				= conf.EBATDeviceKey
			,fact.MagistratesCourtKey		= conf.MagistratesCourtKey
			,fact.EBATEventKey				= conf.EBATEventKey
			,fact.EBATIncidentKey			= conf.EBATIncidentKey
			,fact.EBATRoleKey				= conf.EBATRoleKey
			,fact.EBATRolePlayerKey			= conf.EBATRolePlayerKey
			,fact.OfficerKey				= conf.OfficerKey
			,fact.OperationsDateKey			= conf.OperationsDateKey
			,fact.OperatorKey				= conf.OperatorKey
			,fact.EventDuration				= conf.EventDuration
	
			/* Update System Fields */
			,fact.UpdateAuditKey				= @AuditKey

OUTPUT $action into @rowcounts;			







	



;



;
;
;

;


