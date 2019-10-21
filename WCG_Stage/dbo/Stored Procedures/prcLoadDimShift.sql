CREATE PROCEDURE [dbo].[prcLoadDimShift]

--------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	21-10-2018
-- Reason				:	Performs SCD Logic for DimShift using MERGE statement
--------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@AuditKey, @DeltaLogKey
-- Ouputs				:	None
-- Test					:	[dbo].[prcLoadDimShiftTask] -1, -1
--------------------------------------------------------------------------------------------------------------------------
-- Modified By			:   
-- Modified On			:   
-- Reason				:   
--------------------------------------------------------------------------------------------------------------------------

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
	 DurationHours
	,EndTime
	,IsOffDuty
	,IsUserShift
	,Officer
	,RosterGroup
	,RosterGroupPPI
	,RosterGroupReportsTo
	,RosterGroupSPI
	,RosterStatus
	,RosterWeek
	,Shift
	,ShiftDate
	,ShiftID
	,ShiftTime
	,ShiftTimeSort
	,StartTime
	,UserRole
	,WeekDay
	,WeekEndDate
	,WeekStartDate
	,DeltaLogKey
FROM WCG_STAGE.itis.transformDimShift
WHERE DeltaLogKey = @DeltaLogKey
)

/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimShift dim
USING conf
ON (dim.[ShiftID] = conf.[ShiftID])
WHEN NOT MATCHED THEN /* New Records */
	INSERT (
		 DurationHours
		,EndTime
		,IsOffDuty
		,IsUserShift
		,Officer
		,RosterGroup
		,RosterGroupPPI
		,RosterGroupReportsTo
		,RosterGroupSPI
		,RosterStatus
		,RosterWeek
		,Shift
		,ShiftDate
		,ShiftID
		,ShiftTime
		,ShiftTimeSort
		,StartTime
		,UserRole
		,WeekDay
		,WeekEndDate
		,WeekStartDate
		,DeltaLogKey
		,InsertAuditKey
		,UpdateAuditKey
			)
	VALUES (
		 conf.DurationHours
		,conf.EndTime
		,conf.IsOffDuty
		,conf.IsUserShift
		,conf.Officer
		,conf.RosterGroup
		,conf.RosterGroupPPI
		,conf.RosterGroupReportsTo
		,conf.RosterGroupSPI
		,conf.RosterStatus
		,conf.RosterWeek
		,conf.Shift
		,conf.ShiftDate
		,conf.ShiftID
		,conf.ShiftTime
		,conf.ShiftTimeSort
		,conf.StartTime
		,conf.UserRole
		,conf.WeekDay
		,conf.WeekEndDate
		,conf.WeekStartDate
		,@DeltaLogKey
		,@AuditKey
		,@AuditKey
			)
	WHEN MATCHED 
	AND dim.RowIsCurrent = 'Y' /* Only do update on Current Records */
	AND (
			dim.DurationHours				<> conf.DurationHours
		OR	ISNULL(dim.EndTime,'')			<> ISNULL(conf.EndTime,'')
		OR	dim.IsOffDuty					<> conf.IsOffDuty
		OR	dim.IsUserShift					<> conf.IsUserShift
		OR	dim.Officer						<> conf.Officer
		OR	dim.RosterGroup					<> conf.RosterGroup
		OR	dim.RosterGroupPPI				<> conf.RosterGroupPPI
		OR	dim.RosterGroupReportsTo		<> conf.RosterGroupReportsTo
		OR	dim.RosterGroupSPI				<> conf.RosterGroupSPI
		OR	dim.RosterStatus				<> conf.RosterStatus
		OR	dim.RosterWeek					<> conf.RosterWeek
		OR	dim.Shift						<> conf.Shift
		OR	ISNULL(dim.ShiftDate,'')		<> ISNULL( conf.ShiftDate,'')
		OR	ISNULL(dim.ShiftTime,'')		<> ISNULL(conf.ShiftTime,'')
		OR	dim.ShiftTimeSort				<> conf.ShiftTimeSort
		OR	ISNULL(dim.StartTime,'')		<> ISNULL(conf.StartTime,'')
		OR	dim.UserRole					<> conf.UserRole
		OR	dim.WeekDay						<> conf.WeekDay
		OR	ISNULL(dim.WeekEndDate,'')		<> ISNULL(conf.WeekEndDate,'')
		OR	ISNULL(dim.WeekStartDate,'')	<> ISNULL(conf.WeekStartDate,'')
		) 	/* Check if any Type 1 Fields have changed */
	THEN 
		UPDATE 
		SET 
			/* Update Type 1 Fields */

			 dim.DurationHours				= conf.DurationHours
			,dim.EndTime					= conf.EndTime
			,dim.IsOffDuty					= conf.IsOffDuty
			,dim.IsUserShift				= conf.IsUserShift
			,dim.Officer					= conf.Officer
			,dim.RosterGroup				= conf.RosterGroup
			,dim.RosterGroupPPI				= conf.RosterGroupPPI
			,dim.RosterGroupReportsTo		= conf.RosterGroupReportsTo
			,dim.RosterGroupSPI				= conf.RosterGroupSPI
			,dim.RosterStatus				= conf.RosterStatus
			,dim.RosterWeek					= conf.RosterWeek
			,dim.Shift						= conf.Shift
			,dim.ShiftDate					= conf.ShiftDate
			,dim.ShiftTime					= conf.ShiftTime
			,dim.ShiftTimeSort				= conf.ShiftTimeSort
			,dim.StartTime					= conf.StartTime
			,dim.UserRole					= conf.UserRole
			,dim.WeekDay					= conf.WeekDay
			,dim.WeekEndDate				= conf.WeekEndDate
			,dim.WeekStartDate				= conf.WeekStartDate
			
			/* Update System Fields */
			,dim.UpdateAuditKey = @AuditKey
			,dim.RowIsInferred = 'N'
			,dim.RowChangeReason = 
				CASE 
					WHEN dim.RowIsInferred = 'Y' THEN 'Inferred Member Arrived'
					ELSE 'SCD Type 1 Change'
				END
OUTPUT $action into @rowcounts;			

SELECT @RowCountInsert = COUNT(1) FROM @RowCounts WHERE mergeAction = 'INSERT'
SELECT @RowCountUpdate = COUNT(1) FROM @RowCounts WHERE mergeAction = 'UPDATE'
SELECT @RowCountExtract = COUNT(1) FROM WCG_STAGE.itis.transformDimShift WHERE DeltaLogKey = @DeltaLogKey

