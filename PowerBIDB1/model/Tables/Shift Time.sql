CREATE TABLE [model].[Shift Time] (
    [ShiftTimeKey]    INT              NOT NULL,
    [Duration Hours]  NUMERIC (11, 2)  NOT NULL,
    [End Time]        TIME (7)         NOT NULL,
    [Is Off Duty]     VARCHAR (3)      NOT NULL,
    [Shift Time]      VARCHAR (30)     NOT NULL,
    [Shift Time GUID] UNIQUEIDENTIFIER NULL,
    [Shift Time Sort] INT              NOT NULL,
    [Start Time]      TIME (7)         NOT NULL,
    [Traffic Centre]  VARCHAR (50)     NOT NULL
);

