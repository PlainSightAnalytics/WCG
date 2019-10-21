CREATE TABLE [model].[Shift Task] (
    [ShiftTaskKey]       INT              NOT NULL,
    [Measurement]        NUMERIC (19, 2)  NOT NULL,
    [Measurement Period] VARCHAR (30)     NOT NULL,
    [Measurement Unit]   VARCHAR (30)     NOT NULL,
    [Shift Task]         VARCHAR (50)     NOT NULL,
    [Shift Task ID]      UNIQUEIDENTIFIER NULL,
    [Shift Task Type]    VARCHAR (30)     NOT NULL
);

