CREATE TABLE [dbo].[DimModelTableLog] (
    [LogKey]          INT          IDENTITY (1, 1) NOT NULL,
    [ModelTable]      VARCHAR (50) NULL,
    [Action]          VARCHAR (50) NULL,
    [DateTimeStart]   DATETIME     NULL,
    [DateTimeStop]    DATETIME     NULL,
    [ExecutionLogKey] INT          NOT NULL
);

