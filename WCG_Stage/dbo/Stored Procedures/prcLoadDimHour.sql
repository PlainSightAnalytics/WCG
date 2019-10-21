
CREATE PROCEDURE [dbo].[prcLoadDimHour]

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe (c_TrevorHo)
-- Date Created			:	18-02-2018
-- Reason				:	SCD Load for DimHour
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	AuditKey
-- Ouputs				:	
-- Test					:	dbo.prcLoadDimHour
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@AuditKey INT

AS

WITH conf AS (
SELECT
	 AMPMIndicator
	,Hour24 + 1 AS Hour24
	,HourBand
	,HourShiftSort
	,Is6amTo8pm
	,PeriodOfDay
	,Shift
	FROM WCG_DW.dbo.DimTime WHERE MinuteOfHour = 0
	AND TimeKey <> -1
)


/* Handle SCD1 Changes */
MERGE INTO WCG_DW.dbo.DimHour dim
USING conf
ON (dim.Hour24 = conf.Hour24)
WHEN NOT MATCHED THEN /* New Records */
	INSERT (AMPMIndicator,Hour24,HourBand,HourShiftSort,Is6amTo8pm,PeriodOfDay,Shift,InsertAuditKey,UpdateAuditKey)
	VALUES (AMPMIndicator,Hour24,HourBand,HourShiftSort,Is6amTo8pm,PeriodOfDay,Shift,@AuditKey,@AuditKey)
	WHEN MATCHED 
	AND (	dim.HourShiftSort <> conf.HourShiftSort
		OR dim.PeriodOfDay <> conf.PeriodOfDay
		OR dim.Shift <> conf.Shift
	)
	THEN 
		UPDATE 
		SET 
			dim.HourShiftSort = conf.HourShiftSort,
			dim.PeriodOfDay = conf.PeriodOfDay,
			dim.Shift = conf.Shift,
			/* Update System Fields */
			dim.UpdateAuditKey = @AuditKey,
			dim.RowIsInferred = 'N',
			dim.RowChangeReason = 'SCD Type 1 Change'
		;

;
;

