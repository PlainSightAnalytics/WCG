CREATE TABLE [model].[_Operation Sightings] (
    [CameraKey]         INT          NOT NULL,
    [GeoLocationKey]    INT          NOT NULL,
    [OperationsDateKey] INT          NOT NULL,
    [SightingDateKey]   INT          NOT NULL,
    [SightingTimeKey]   INT          NOT NULL,
    [TrafficCentreKey]  INT          NOT NULL,
    [VehicleKey]        INT          NOT NULL,
    [PartyKey]          VARCHAR (30) NULL,
    [SightingRecordId]  VARCHAR (15) NULL,
    [OperationKey]      INT          NOT NULL
);

