CREATE TABLE [cle].[AlertsSlice] (
    [AlertRecordId]   INT                NOT NULL,
    [VRN]             NVARCHAR (50)      NULL,
    [AlertDateTime]   DATETIMEOFFSET (7) NULL,
    [AlertType]       NVARCHAR (50)      NULL,
    [AlertSubType]    NVARCHAR (50)      NULL,
    [Latitude]        FLOAT (53)         NULL,
    [Longitude]       FLOAT (53)         NULL,
    [SightingId]      NVARCHAR (100)     NULL,
    [AverageKmh]      INT                NULL,
    [DeviceId]        NVARCHAR (50)      NULL,
    [Lane]            NVARCHAR (5)       NULL,
    [LicenceNumber]   NVARCHAR (50)      NULL,
    [VehicleCategory] NVARCHAR (150)     NULL,
    [VehicleUsage]    NVARCHAR (50)      NULL,
    [DeltaLogKey]     INT                NULL
);

