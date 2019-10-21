CREATE TABLE [model].[_Public Transport Sightings] (
    [CameraKey]         INT             NOT NULL,
    [GeoLocationKey]    INT             NOT NULL,
    [OperationsDateKey] INT             NOT NULL,
    [SightingDateKey]   INT             NOT NULL,
    [SightingTimeKey]   INT             NOT NULL,
    [TrafficCentreKey]  INT             NOT NULL,
    [TripKey]           INT             NOT NULL,
    [VehicleKey]        INT             NOT NULL,
    [DurationSeconds]   INT             NULL,
    [Distance]          NUMERIC (11, 3) NULL
);

