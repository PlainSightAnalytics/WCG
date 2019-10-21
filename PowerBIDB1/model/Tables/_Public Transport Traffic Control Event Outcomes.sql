CREATE TABLE [model].[_Public Transport Traffic Control Event Outcomes] (
    [DriverKey]              INT             NOT NULL,
    [GeoLocationKey]         INT             NOT NULL,
    [OpenDateKey]            INT             NOT NULL,
    [OpenTimeKey]            INT             NOT NULL,
    [OperationsDateKey]      INT             NOT NULL,
    [Section56FormKey]       INT             NOT NULL,
    [TrafficCentreKey]       INT             NOT NULL,
    [TrafficControlEventKey] INT             NOT NULL,
    [TripKey]                INT             NOT NULL,
    [UserKey]                INT             NOT NULL,
    [VehicleKey]             INT             NOT NULL,
    [ViolationChargeKey]     INT             NOT NULL,
    [_ChargeAmount]          NUMERIC (19, 2) NULL
);

