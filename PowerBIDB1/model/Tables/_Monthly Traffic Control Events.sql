CREATE TABLE [model].[_Monthly Traffic Control Events] (
    [CalendarYearMonthKey] INT          NULL,
    [TrafficCentreKey]     INT          NOT NULL,
    [EventSource]          VARCHAR (50) NULL,
    [VehicleTypeKey]       INT          NOT NULL,
    [_VehicleCount]        INT          NULL,
    [_EventCount]          INT          NULL
);

