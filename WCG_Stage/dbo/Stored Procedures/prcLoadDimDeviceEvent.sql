
CREATE PROCEDURE [dbo].[prcLoadDimDeviceEvent]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	19-11-2019
-- Reason				:	Performs SCD Logic for DimDeviceEvent using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimDeviceEvent] -1, -1
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


/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimDeviceEvent dim
USING WCG_STAGE.itis.transformDimDeviceEvent conf
ON (dim.EventSource = conf.EventSource AND dim.EventSubType = conf.EventSubType AND dim.EventType = conf.EventType)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 EventSource
			,EventSubType
			,EventType
			,DeltaLogKey
			,InsertAuditKey
			,UpdateAuditKey
			)
	VALUES (
			 conf.EventSource
			,conf.EventSubType
			,conf.EventType
			,@DeltaLogKey
			,@AuditKey
			,@AuditKey
			);








;
;
;

;