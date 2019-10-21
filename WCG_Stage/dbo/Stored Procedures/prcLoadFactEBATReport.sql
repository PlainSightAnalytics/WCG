



CREATE PROCEDURE [dbo].[prcLoadFactEBATReport]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	15 August 2015
-- Reason				:	Load FactEBATReport using MERGE Statement (Fact table update)
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	@RowCountUpdate, @RowCountInsert
-- Test					:	prcLoadFactEBATReport -1, 8011
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	Trevor Howe
-- Modified On			:	16-07-2019
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
	 [DriverKey]
	,[EBATDeviceKey]
	,[EBATIncidentKey]
	,[MagistratesCourtKey]
	,[OfficerKey]
	,[OperationsDateKey]
	,[OperatorKey]
	,[ReportDateKey]
	,[ReportTimeKey]
	,[VehicleKey]
	,[NumberOfVehicles]			
	,[ReadingResult]				
	,[UniqueID]	
	,[DeltaLogKey]
  FROM [dbo].[LoadFactEBATReport] conf
  WHERE RowNumber = 1
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.FactEBATReport fact
USING conf
ON (fact.[UniqueId] = conf.[UniqueId])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 [DriverKey],[EBATDeviceKey],[EBATIncidentKey], [MagistratesCourtKey],[OfficerKey],[OperationsDateKey],[OperatorKey],[ReportDateKey],[ReportTimeKey],[VehicleKey]
		 ,[NumberOfVehicles],[ReadingResult],[UniqueId],[DeltaLogKey],InsertAuditKey, UpdateAuditKey
			)
	VALUES (
		 conf.[DriverKey],conf.[EBATDeviceKey],conf.[EBATIncidentKey],conf.[MagistratesCourtKey],conf.[OfficerKey],conf.[OperationsDateKey],conf.[OperatorKey],conf.[ReportDateKey]
		 ,conf.[ReportTimeKey],conf.[VehicleKey],conf.[NumberOfVehicles],conf.[ReadingResult],conf.[UniqueId],conf.[DeltaLogKey],@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	THEN 
		UPDATE 
		SET 
			/* Update all Fields */
			 fact.[DriverKey]					= conf.[DriverKey]
			,fact.[EBATDeviceKey]				= conf.[EBATDeviceKey]
			,fact.[EBATIncidentKey]				= conf.[EBATIncidentKey]
			,fact.[MagistratesCourtKey]			= conf.[MagistratesCourtKey]
			,fact.[OfficerKey]					= conf.[OfficerKey]
			,fact.[OperationsDateKey]			= conf.[OperationsDateKey]
			,fact.[OperatorKey]					= conf.[OperatorKey]
			,fact.[ReportDateKey]				= conf.[ReportDateKey]
			,fact.[ReportTimeKey]				= conf.[ReportTimeKey]
			,fact.[VehicleKey]					= conf.[VehicleKey]
			,fact.[NumberOfVehicles]			= conf.[NumberOfVehicles]			
			,fact.[ReadingResult]				= conf.[ReadingResult]				
			,fact.[UniqueId]					= conf.[UniqueId]	
			,fact.[DeletedFlag]					= 0
			
			/* Update System Fields */
			,fact.UpdateAuditKey				= @AuditKey
			WHEN NOT MATCHED BY SOURCE THEN 
				UPDATE
					SET fact.DeletedFlag = 1

OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_Stage.dbo.LoadFactEBATReport

/* Update Delta Log */
UPDATE WCG_DW.dbo.DimDeltaLog
SET 
	LoadFlag = 1, 
	RowCountInsert = @RowCountInsert, 
	RowCountUpdate = @RowCountUpdate,
	UpdateAuditKey = @AuditKey
WHERE DeltaLogKey = @DeltaLogKey






	



;



;
;
;





