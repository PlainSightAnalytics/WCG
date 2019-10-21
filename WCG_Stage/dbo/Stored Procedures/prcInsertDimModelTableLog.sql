
CREATE PROCEDURE [dbo].[prcInsertDimModelTableLog]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	10-06-2019
-- Reason				:	Adds record to DimModelTableLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ModelTable, @Action, @ExecutionLogKey
-- Ouputs				:	@LogKey
-- Test					:	exec prcInsertDimModelTableLog 'Test', 'Action', 1, 0
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------
@ModelTable			VARCHAR(50) = 'Unknown',
@Action				VARCHAR(50) = 'Unknown',
@ExecutionLogKey	INT,
@LogKey				INT OUTPUT

AS

SET NOCOUNT ON

/* Insert Record */
INSERT INTO WCG_DW.dbo.DimModelTableLog 
(ModelTable, Action, ExecutionLogKey, DateTimeStart)
VALUES (@ModelTable, @Action, @ExecutionLogKey, GETDATE())

/* Return Log Key */
SET @LogKey =  CAST(IDENT_CURRENT( 'WCG_DW.dbo.DimModelTableLog' ) AS INT) 


