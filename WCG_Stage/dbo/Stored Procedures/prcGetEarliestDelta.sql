CREATE PROCEDURE [dbo].[prcGetEarliestDelta]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	26-03-2018
-- Reason				:	Gets Earliest Delta based on Delta log date
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ModelTable, @LagDays
-- Ouputs				:	Earliest DeltaLogKey
-- Test					:	exec dbo.prcGetEarliestDelta '_Traffic Control Events', 2000, 0
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@ModelTable			VARCHAR(50) = NULL,
@LagDays			INT = 7,
@DeltaLogKey		INT OUTPUT

AS

DECLARE @Object VARCHAR(50)

SET NOCOUNT ON

/* Set Object Name */
SELECT @Object =
CASE
	WHEN @ModelTable = '_Alerts Summary' THEN 'alerts'
	WHEN @ModelTable = '_Sightings Summary' THEN 'sightings'
	WHEN @ModelTable = '_Traffic Control Events' THEN 'event'
	WHEN @ModelTable = '_Traffic Control Event Outcomes' THEN 'violation_charge'
	ELSE NULL
END

/* Get earliest Deltalogkey that is @LagDays before todays date */
SELECT @DeltaLogKey = ISNULL(MIN(DeltaLogKey),-1)
FROM WCG_DW.dbo.DimDeltaLog
WHERE ObjectName = @Object
AND LogDate > DATEADD(d,(0-@LagDays),GETDATE())




