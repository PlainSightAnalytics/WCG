CREATE TABLE [model].[_Traffic Control Event Outcomes] (
    [DeviceKey]                  INT              NULL,
    [DriverKey]                  INT              NULL,
    [MagistratesCourtKey]        INT              NULL,
    [OpenDateKey]                INT              NULL,
    [OpenTimeKey]                INT              NULL,
    [OperationKey]               INT              NULL,
    [OperationsDateKey]          INT              NULL,
    [Section56FormKey]           INT              NULL,
    [TrafficCentreKey]           INT              NULL,
    [TrafficControlEventKey]     INT              NULL,
    [UpdatedDateKey]             INT              NULL,
    [UpdatedTimeKey]             INT              NULL,
    [UserKey]                    INT              NULL,
    [VehicleKey]                 INT              NULL,
    [VehicleTypeKey]             INT              NULL,
    [ViolationChargeKey]         INT              NULL,
    [Unique Charge ID]           UNIQUEIDENTIFIER NULL,
    [Unique Section 5 6 Form ID] UNIQUEIDENTIFIER NULL,
    [_ChargeAmount]              NUMERIC (19, 2)  NULL,
    [DeltaLogKey]                INT              NULL
);

