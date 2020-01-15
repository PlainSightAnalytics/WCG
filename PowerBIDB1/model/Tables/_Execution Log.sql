CREATE TABLE [model].[_Execution Log] (
    [ExecutionDateKey] NVARCHAR (4000) NULL,
    [ExecutionHourKey] INT             NULL,
    [ExecutionTimeKey] NVARCHAR (4000) NULL,
    [ObjectKey]        INT             NOT NULL,
    [Exception]        VARCHAR (MAX)   NULL,
    [ExecutionLogKey]  INT             NOT NULL,
    [StartTime]        DATETIME        NULL,
    [EndTime]          DATETIME        NULL,
    [Duration]         INT             NULL,
    [ScriptName]       VARCHAR (100)   NULL
);



