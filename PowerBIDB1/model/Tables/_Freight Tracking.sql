CREATE TABLE [model].[_Freight Tracking] (
    [CameraKey]         INT             NOT NULL,
    [DateKey]           INT             NOT NULL,
    [GeoLocationKey]    INT             NOT NULL,
    [OperationsDateKey] INT             NOT NULL,
    [TimeKey]           INT             NOT NULL,
    [TrafficCentreKey]  INT             NOT NULL,
    [TripKey]           INT             NOT NULL,
    [VehicleKey]        INT             NOT NULL,
    [Event]             VARCHAR (100)   NULL,
    [DurationSeconds]   INT             NULL,
    [Distance]          NUMERIC (11, 3) NULL
);

