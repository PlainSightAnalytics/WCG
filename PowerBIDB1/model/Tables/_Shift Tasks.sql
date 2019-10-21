CREATE TABLE [model].[_Shift Tasks] (
    [OperationsDateKey] INT              NOT NULL,
    [ShiftDateKey]      INT              NOT NULL,
    [ShiftKey]          INT              NOT NULL,
    [ShiftLocationKey]  INT              NOT NULL,
    [ShiftTaskKey]      INT              NOT NULL,
    [TrafficCentreKey]  INT              NOT NULL,
    [UserKey]           INT              NOT NULL,
    [Is Adhoc Task]     VARCHAR (3)      NULL,
    [Other Location]    VARCHAR (50)     NULL,
    [Task End Time]     TIME (7)         NULL,
    [Task Start Time]   TIME (7)         NULL,
    [Unique ID]         UNIQUEIDENTIFIER NULL,
    [_DurationHours]    NUMERIC (5, 2)   NULL,
    [_TaskTarget]       NUMERIC (11, 2)  NULL
);

