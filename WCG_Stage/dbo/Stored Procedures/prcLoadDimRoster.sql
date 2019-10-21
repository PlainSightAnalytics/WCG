
CREATE PROCEDURE [dbo].[prcLoadDimRoster]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	05-05-2018
-- Reason				:	Performs SCD Logic for DimRoster using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimRoster] -1
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
	 [IsArchived]
	,[IsDeleted]
	,[Roster]
	,[RosterGroupDescription]
	,[RosterGUID]
	,[RosterGroup]
	,[RosterGroupReportsTo]
	,[IsRevised]
	,[RosterStatus]
	,[RosterGroupPPI]
	,[RosterGroupSPI]
FROM WCG_STAGE.itis.transformDimRoster
)
/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimRoster dim
USING conf
ON (dim.[RosterGUID] = conf.[RosterGUID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 [IsArchived]
		,[IsDeleted]
		,[Roster]
		,[RosterGroupDescription]
		,[RosterGUID]
		,[RosterGroup]
		,[RosterGroupReportsTo]
		,[IsRevised]
		,[RosterStatus]
		,[RosterGroupPPI]
		,[RosterGroupSPI]
		,[InsertAuditKey]
		,[UpdateAuditKey]
	)
	VALUES (
		 conf.[IsArchived]
		,conf.[IsDeleted]
		,conf.[Roster]
		,conf.[RosterGroupDescription]
		,conf.[RosterGUID]
		,conf.[RosterGroup]
		,conf.[RosterGroupReportsTo]
		,conf.[IsRevised]
		,conf.[RosterStatus]
		,conf.[RosterGroupPPI]
		,conf.[RosterGroupSPI]
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
		   dim.[IsArchived]				 <> conf.[IsArchived]
		OR dim.[IsDeleted]				 <> conf.[IsDeleted]
		OR dim.[Roster]					 <> conf.[Roster]
		OR dim.[RosterGroupDescription]	 <> conf.[RosterGroupDescription]
		OR dim.[RosterGroup]			 <> conf.[RosterGroup]
		OR dim.[RosterGroupReportsTo]	 <> conf.[RosterGroupReportsTo]
		OR dim.[IsRevised]				 <> conf.[IsRevised]
		OR dim.[RosterStatus]			 <> conf.[RosterStatus]
		OR dim.[RosterGroupPPI]			 <> conf.[RosterGroupPPI]
		OR dim.[RosterGroupSPI]			 <> conf.[RosterGroupSPI]
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */
		dim.[IsArchived]				= conf.[IsArchived],
		dim.[IsDeleted]					= conf.[IsDeleted],
		dim.[Roster]					= conf.[Roster],
		dim.[RosterGroupDescription]	= conf.[RosterGroupDescription],
		dim.[RosterGroup]				= conf.[RosterGroup],
		dim.[RosterGroupReportsTo]		= conf.[RosterGroupReportsTo],
		dim.[IsRevised]					= conf.[IsRevised],
		dim.[RosterStatus]				= conf.[RosterStatus],
		dim.[RosterGroupPPI]			= conf.[RosterGroupPPI],
		dim.[RosterGroupSPI]			= conf.[RosterGroupSPI],
			
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
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimRoster




;
;
;

;
;

