
CREATE PROCEDURE [dbo].[prcInsertDimExecutionLog]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	27-09-2016
-- Reason				:	Adds record to DimExecutionLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ScriptName
-- Ouputs				:	@ExecutionLogKey
-- 
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@ScriptName			VARCHAR(100),
@ExecutionLogKey	INT OUTPUT

AS

SET NOCOUNT ON

/* Insert Record */
INSERT INTO WCG_DW.dbo.DimExecutionLog 
(ScriptName, StartTime)
VALUES (@ScriptName, GETDATE())

/* Return ExecutionLogKey */
SET @ExecutionLogKey =  CAST(IDENT_CURRENT( 'WCG_DW.dbo.DimExecutionLog' ) AS INT) 



