CREATE TABLE [model].[_Shift Activities] (
    [GeoLocationKey]       INT              NOT NULL,
    [OperationsDateKey]    INT              NOT NULL,
    [ShiftActivityTypeKey] INT              NOT NULL,
    [ShiftDateKey]         INT              NOT NULL,
    [ShiftKey]             INT              NOT NULL,
    [ShiftLocationKey]     INT              NOT NULL,
    [ShiftTaskKey]         INT              NOT NULL,
    [TrafficCentreKey]     INT              NOT NULL,
    [UserKey]              INT              NOT NULL,
    [Activity Comment]     VARCHAR (100)    NULL,
    [Activity End Time]    TIME (7)         NULL,
    [Activity Start Time]  TIME (7)         NULL,
    [Is Adhoc Activity]    VARCHAR (3)      NULL,
    [Other Location]       VARCHAR (50)     NULL,
    [Unique ID]            UNIQUEIDENTIFIER NULL,
    [_DurationHours]       NUMERIC (5, 2)   NULL
);

