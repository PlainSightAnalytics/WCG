CREATE PROCEDURE [dbo].[prcLoadDimRoadSafetyTopic]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	06-04-2019
-- Reason				:	Performs SCD Logic for DimRoadSafetyTopic using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimRoadSafetyTopic] -1
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
	 RoadSafetyTopicID
	,RoadSafetyTopic
	,SequenceNumber
FROM WCG_STAGE.itis.transformDimRoadSafetyTopic
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimRoadSafetyTopic dim
USING  conf
ON (dim.[RoadSafetyTopicID] = conf.[RoadSafetyTopicID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			[RoadSafetyTopicID], [RoadSafetyTopic], [SequenceNumber],
			InsertAuditKey, UpdateAuditKey
			)
	VALUES (
			conf.[RoadSafetyTopicID], conf.[RoadSafetyTopic], conf.[SequenceNumber],
			@AuditKey, @AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[RoadSafetyTopic]	<> conf.[RoadSafetyTopic]
		OR dim.[SequenceNumber]		<> conf.[SequenceNumber]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
			dim.[RoadSafetyTopic] = conf.[RoadSafetyTopic],
			dim.[SequenceNumber] = conf.[SequenceNumber],
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimRoadSafetyTopic 



;
;
;
;
