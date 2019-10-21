CREATE TABLE [model].[_EBAT Report] (
    [DriverKey]           INT              NOT NULL,
    [EBATDeviceKey]       INT              NOT NULL,
    [EBATIncidentKey]     INT              NOT NULL,
    [MagistratesCourtKey] INT              NOT NULL,
    [OfficerKey]          INT              NOT NULL,
    [OperationsDateKey]   INT              NOT NULL,
    [OperatorKey]         INT              NOT NULL,
    [ReportDateKey]       INT              NOT NULL,
    [ReportTimeKey]       INT              NOT NULL,
    [VehicleKey]          INT              NOT NULL,
    [Unique Id]           UNIQUEIDENTIFIER NULL,
    [_NumberOfVehicles]   INT              NULL,
    [_ReadingResult]      NUMERIC (19, 2)  NULL
);

