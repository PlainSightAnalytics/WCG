CREATE PROCEDURE [dbo].[prcUpdateDimDeltaLogLoadFlag]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	07-12-2019
-- Reason				:	Updates Load Flag DimDeltaLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@DeltaLogKey
-- Ouputs				:
-- Test					:	exec dbo.prcUpdateDimDeltaLogLoadFlag -1
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@DeltaLogKey		INT

AS

SET NOCOUNT ON

UPDATE WCG_DW.dbo.DimDeltaLog
SET LoadFlag = 1
WHERE DeltaLogKey = @DeltaLogKey