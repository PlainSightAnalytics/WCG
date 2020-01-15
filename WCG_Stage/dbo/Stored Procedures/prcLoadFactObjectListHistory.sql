CREATE PROCEDURE [dbo].[prcLoadFactObjectListHistory]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	23-12-2019
-- Reason				:	Performs SCD Logic for FactObjectListHistory using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadFactObjectListHistory] -1
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

/* Insert new Rows */
MERGE INTO WCG_DW.dbo.FactObjectListHistory f
USING WCG_Stage.dbo.LoadFactObjectListHistory conf
ON (f.ObjectKey = conf.ObjectKey AND ISNULL(f.LastModifiedDateTime,'1 January 1900') = ISNULL(conf.LastModifiedDateTime,'1 January 1900'))
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
			 CreateDateKey
			,LastModifiedDateKey
			,ObjectKey
			,IsCurrent
			,LastModifiedDateTime
			,InsertAuditKey
			,UpdateAuditKey
			)
	VALUES (
			 conf.CreateDateKey
			,conf.LastModifiedDateKey
			,conf.ObjectKey
			,'Yes'
			,conf.LastModifiedDateTime
			,@AuditKey
			,@AuditKey
			)
	OUTPUT $action into @rowcounts;			

/* Update Previous rows to not Current */
WITH cte AS (
SELECT
	 ObjectKey
	,LastModifiedDateTime
	,IsCurrent
	,UpdateAuditKey
	,ROW_NUMBER() OVER (PARTITION BY ObjectKey ORDER BY LastModifiedDateTime DESC) AS RowSequence
FROM WCG_DW.dbo.FactObjectListHistory f
WHERE IsCurrent = 'Yes'
)

UPDATE CTE
SET 
	IsCurrent = 'No'
	,UpdateAuditKey = @AuditKey
WHERE
	RowSequence > 1

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_Stage.dbo.LoadFactObjectListHistory