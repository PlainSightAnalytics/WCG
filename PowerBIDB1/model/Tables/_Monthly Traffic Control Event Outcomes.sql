CREATE TABLE [model].[_Monthly Traffic Control Event Outcomes] (
    [CalendarYearMonthKey] INT             NULL,
    [TrafficCentreKey]     INT             NOT NULL,
    [EventSource]          VARCHAR (50)    NULL,
    [ViolationChargeKey]   INT             NOT NULL,
    [VehicleTypeKey]       INT             NOT NULL,
    [_ChargeAmount]        NUMERIC (38, 2) NULL,
    [_VehicleCount]        INT             NULL,
    [_EventCount]          INT             NULL
);

