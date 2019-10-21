CREATE TABLE [dbo].[DimExecutionLog] (
    [ExecutionLogKey]  INT            IDENTITY (1, 1) NOT NULL,
    [StartTime]        DATETIME       NULL,
    [EndTime]          DATETIME       NULL,
    [ScriptName]       VARCHAR (100)  NULL,
    [ExceptionLineNo]  INT            NULL,
    [ExceptionLine]    VARCHAR (1000) NULL,
    [ExceptionMessage] VARCHAR (MAX)  NULL
);

