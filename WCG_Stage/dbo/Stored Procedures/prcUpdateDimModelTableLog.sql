
CREATE PROCEDURE [dbo].[prcUpdateDimModelTableLog]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-06-2016
-- Reason				:	Updates record on DimModelTableLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@LogKey
-- Ouputs				:	
-- Test					:	exec prcUpdateDimModelTableLog 1
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@LogKey			INT 

AS

SET NOCOUNT ON

/* Insert Record */
UPDATE WCG_DW.dbo.DimModelTableLog
SET 
	DateTimeStop = GETDATE()
WHERE LogKey = @LogKey




;
;
