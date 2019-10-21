CREATE TABLE [model].[_Execution Log] (
    [ExecutionLogKey]              INT            NOT NULL,
    [ScriptName]                   VARCHAR (50)   NULL,
    [MasterScript]                 VARCHAR (100)  NOT NULL,
    [ScriptStartTime]              DATETIME       NULL,
    [ScriptEndTime]                DATETIME       NULL,
    [ScriptExecutionDateKey]       INT            NULL,
    [ScriptExecutionTimeKey]       INT            NULL,
    [ScriptDuration]               INT            NULL,
    [ExecutionBatch]               VARCHAR (100)  NULL,
    [MasterScriptDuration]         INT            NULL,
    [MasterScriptExecutionDateKey] INT            NULL,
    [MasterScriptExecutionTimeKey] INT            NULL,
    [ExceptionMessage]             VARCHAR (1000) NULL
);

