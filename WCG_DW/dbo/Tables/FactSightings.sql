﻿CREATE TABLE [dbo].[FactSightings] (
    [CameraKey]         INT          DEFAULT ((-1)) NOT NULL,
    [GeoLocationKey]    INT          DEFAULT ((-1)) NOT NULL,
    [OperationsDateKey] INT          DEFAULT ((-1)) NOT NULL,
    [SightingDateKey]   INT          DEFAULT ((-1)) NOT NULL,
    [SightingTimeKey]   INT          DEFAULT ((-1)) NOT NULL,
    [TrafficCentreKey]  INT          DEFAULT ((-1)) NOT NULL,
    [VehicleKey]        INT          DEFAULT ((-1)) NOT NULL,
    [PartyKey]          VARCHAR (30) NULL,
    [SightingRecordId]  VARCHAR (15) NULL,
    [InsertAuditKey]    INT          DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]    INT          DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]       INT          DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]   INT          DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]       INT          DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactSightings_CameraKey] FOREIGN KEY ([CameraKey]) REFERENCES [dbo].[DimCamera] ([CameraKey]),
    CONSTRAINT [FK_dbo_FactSightings_GeoLocationKey] FOREIGN KEY ([GeoLocationKey]) REFERENCES [dbo].[DimGeoLocation] ([GeoLocationKey]),
    CONSTRAINT [FK_dbo_FactSightings_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactSightings_OperationsDateKey] FOREIGN KEY ([OperationsDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactSightings_SightingDateKey] FOREIGN KEY ([SightingDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactSightings_SightingTimeKey] FOREIGN KEY ([SightingTimeKey]) REFERENCES [dbo].[DimTime] ([TimeKey]),
    CONSTRAINT [FK_dbo_FactSightings_TrafficCentreKey] FOREIGN KEY ([TrafficCentreKey]) REFERENCES [dbo].[DimTrafficCentre] ([TrafficCentreKey]),
    CONSTRAINT [FK_dbo_FactSightings_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactSightings_VehicleKey] FOREIGN KEY ([VehicleKey]) REFERENCES [dbo].[DimVehicle] ([VehicleKey])
);

