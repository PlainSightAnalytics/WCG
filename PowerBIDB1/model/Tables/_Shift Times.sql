CREATE TABLE [model].[_Shift Times] (
    [OperationsDateKey] INT              NOT NULL,
    [RosterKey]         INT              NOT NULL,
    [ShiftDateKey]      INT              NOT NULL,
    [ShiftKey]          INT              NOT NULL,
    [ShiftTimeKey]      INT              NOT NULL,
    [ShiftWeekKey]      INT              NOT NULL,
    [TrafficCentreKey]  INT              NOT NULL,
    [UserKey]           INT              NOT NULL,
    [Is Acknowledged]   VARCHAR (3)      NULL,
    [Is Archived]       VARCHAR (3)      NULL,
    [Is Deleted]        VARCHAR (3)      NULL,
    [Is User Shift]     VARCHAR (3)      NULL,
    [Unique ID]         UNIQUEIDENTIFIER NULL,
    [_DurationHours]    NUMERIC (5, 2)   NULL
);

