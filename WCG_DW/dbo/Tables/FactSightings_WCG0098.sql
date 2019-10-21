CREATE TABLE [dbo].[FactSightings_WCG0098] (
    [CameraKey]         VARCHAR (50)    NULL,
    [GeoLocationKey]    VARCHAR (50)    NULL,
    [OperationsDateKey] VARCHAR (50)    NULL,
    [SightingDateKey]   NVARCHAR (4000) NULL,
    [SightingTimeKey]   INT             NULL,
    [TrafficCentreKey]  VARCHAR (50)    NULL,
    [VehicleKey]        INT             NOT NULL,
    [PartyKey]          INT             NULL,
    [SightingRecordId]  INT             NULL,
    [InsertAuditKey]    INT             NOT NULL,
    [UpdateAuditKey]    INT             NOT NULL,
    [DeltaLogKey]       INT             NOT NULL,
    [ExceptionRowKey]   INT             NOT NULL,
    [DeletedFlag]       INT             NOT NULL
);

