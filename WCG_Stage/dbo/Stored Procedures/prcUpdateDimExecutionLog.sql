

CREATE PROCEDURE [dbo].[prcUpdateDimExecutionLog]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	27-09-2016
-- Reason				:	Updates record to DimExecutionLog
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@ExecutionLogKey, @ExecutionEvent, @ExceptionLineNo, @ExceptionLine, @ExceptionMessage
-- Ouputs				:	None
-- 
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@ExecutionLogKey	INT,
@ExecutionEvent		VARCHAR(50) = NULL,
@ExceptionLineNo	INT = NULL,
@ExceptionLine		VARCHAR(1000) = NULL,
@ExceptionMessage	VARCHAR(MAX) = NULL

AS

/* Insert Record */
UPDATE WCG_DW.dbo.DimExecutionLog 
SET
	EndTime = GETDATE(),
	ExceptionLine = ISNULL(@ExceptionLine,ExceptionLine),
	ExceptionLineNo = ISNULL(@ExceptionLineNo,ExceptionLineNo),
	ExceptionMessage = ISNULL(@ExceptionMessage,ExceptionMessage)
WHERE	
	ExecutionLogKey = @ExecutionLogKey






