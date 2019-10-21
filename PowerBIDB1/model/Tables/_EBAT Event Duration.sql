CREATE TABLE [model].[_EBAT Event Duration] (
    [EBATDeviceKey]       INT              NOT NULL,
    [EBATEventKey]        INT              NOT NULL,
    [EBATIncidentKey]     INT              NOT NULL,
    [EBATRoleKey]         INT              NOT NULL,
    [EBATRolePlayerKey]   INT              NOT NULL,
    [EventDateKey]        INT              NOT NULL,
    [EventTimeKey]        INT              NOT NULL,
    [MagistratesCourtKey] INT              NOT NULL,
    [OfficerKey]          INT              NOT NULL,
    [OperationsDateKey]   INT              NOT NULL,
    [OperatorKey]         INT              NOT NULL,
    [Event Id]            INT              NULL,
    [Unique Id]           UNIQUEIDENTIFIER NULL,
    [_EventDuration]      INT              NULL
);

