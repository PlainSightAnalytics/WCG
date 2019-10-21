
CREATE PROCEDURE [dbo].[prcGetUnloadedDeltas]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	09-06-2016
-- Reason				:	Gets Deltas that have been staged but not loaded
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ClientName, @SchemaName, @ObjectName
-- Ouputs				:	Set of Delta Log Keys
-- Test					:	exec dbo.prcGetUnloadedDeltas 'WCG', 'cle', 'VehicleEnquiryResponses', 1
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------
@ClientName			VARCHAR(50) = 'Unknown',
@SchemaName			VARCHAR(50) = 'Unknown',
@ObjectName			VARCHAR(50) = 'Unknown',
@ReturnDeltas		INT = NULL

AS

SET NOCOUNT ON

/* Return HighWater Date  */
SELECT TOP (ISNULL(@ReturnDeltas,9999999)) DeltaLogKey
FROM WCG_DW.dbo.DimDeltaLog
WHERE 
	LoadFlag = 0 
--AND RowCountStage > 0
AND ClientName = @ClientName
AND SchemaName = @SchemaName
AND ObjectName = @ObjectName
ORDER BY HighWaterDateTime, CAST(HighWaterMark AS INT)










;
;
