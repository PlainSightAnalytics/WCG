CREATE TABLE [model].[_Shift Outcomes] (
    [CriticalOutcomeTypeKey] INT              NOT NULL,
    [OperationsDateKey]      INT              NOT NULL,
    [ShiftDateKey]           INT              NOT NULL,
    [ShiftKey]               INT              NOT NULL,
    [TrafficCentreKey]       INT              NOT NULL,
    [UserKey]                INT              NOT NULL,
    [Is Started Filling In]  VARCHAR (3)      NULL,
    [Unique ID]              UNIQUEIDENTIFIER NULL,
    [_VehicleCount]          INT              NULL
);

