CREATE TABLE [model].[_Persons For Reward Tracking] (
    [CameraKey]        INT             NOT NULL,
    [DateKey]          INT             NOT NULL,
    [GeoLocationKey]   INT             NOT NULL,
    [TimeKey]          INT             NOT NULL,
    [TrafficCentreKey] INT             NOT NULL,
    [TripKey]          INT             NULL,
    [VehicleKey]       INT             NOT NULL,
    [Event]            VARCHAR (100)   NOT NULL,
    [DurationSeconds]  INT             NULL,
    [Distance]         NUMERIC (11, 3) NULL
);

