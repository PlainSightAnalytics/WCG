CREATE TABLE [model].[_Traffic Control Events] (
    [AlertTypeKey]           INT              NOT NULL,
    [DeviceKey]              INT              NOT NULL,
    [DriverKey]              INT              NOT NULL,
    [MagistratesCourtKey]    INT              NOT NULL,
    [OpenDateKey]            INT              NOT NULL,
    [OpenTimeKey]            INT              NOT NULL,
    [OperationKey]           INT              NOT NULL,
    [OperationsDateKey]      INT              NOT NULL,
    [TrafficCentreKey]       INT              NOT NULL,
    [TrafficControlEventKey] INT              NOT NULL,
    [UpdatedDateKey]         INT              NOT NULL,
    [UpdatedTimeKey]         INT              NOT NULL,
    [UserKey]                INT              NOT NULL,
    [VehicleKey]             INT              NOT NULL,
    [VehicleTypeKey]         INT              NOT NULL,
    [Unique Alert ID]        UNIQUEIDENTIFIER NULL,
    [Unique Event ID]        UNIQUEIDENTIFIER NULL,
    [DeltaLogKey]            INT              NULL
);

