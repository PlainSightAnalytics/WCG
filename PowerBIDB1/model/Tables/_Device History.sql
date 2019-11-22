CREATE TABLE [model].[_Device History] (
    [DeviceEventKey]         INT           NOT NULL,
    [DeviceKey]              INT           NOT NULL,
    [EventDateKey]           INT           NOT NULL,
    [EventTimeKey]           INT           NOT NULL,
    [GeoLocationKey]         INT           NOT NULL,
    [OperationKey]           INT           NOT NULL,
    [ShiftKey]               INT           NOT NULL,
    [TrafficCentreKey]       INT           NOT NULL,
    [TrafficControlEventKey] INT           NOT NULL,
    [UserKey]                INT           NOT NULL,
    [EventDateTime]          DATETIME      NULL,
    [EventStatus]            VARCHAR (10)  NULL,
    [EventValue]             VARCHAR (100) NULL,
    [DeltaLogKey]            INT           NULL,
    [DurationSeconds]        INT           NULL
);

