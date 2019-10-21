CREATE TABLE [model].[_Planned Shifts] (
    [RosterKey]        INT              NOT NULL,
    [ShiftDateKey]     INT              NOT NULL,
    [ShiftTimeKey]     INT              NOT NULL,
    [ShiftWeekKey]     INT              NOT NULL,
    [TrafficCentreKey] INT              NOT NULL,
    [UserKey]          INT              NOT NULL,
    [Is Acknowledged]  VARCHAR (3)      NULL,
    [Is Archived]      VARCHAR (3)      NULL,
    [Is Deleted]       VARCHAR (3)      NULL,
    [Is User Shift]    VARCHAR (3)      NULL,
    [Shift GUID]       UNIQUEIDENTIFIER NULL
);

