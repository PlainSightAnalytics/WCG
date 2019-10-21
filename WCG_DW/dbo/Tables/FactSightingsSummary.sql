﻿CREATE TABLE [dbo].[FactSightingsSummary] (
    [CameraKey]                         INT DEFAULT ((-1)) NOT NULL,
    [GeoLocationKey]                    INT DEFAULT ((-1)) NOT NULL,
    [HourKey]                           INT DEFAULT ((-1)) NOT NULL,
    [OperationsDateKey]                 INT DEFAULT ((-1)) NOT NULL,
    [SightingDateKey]                   INT DEFAULT ((-1)) NOT NULL,
    [TrafficCentreKey]                  INT DEFAULT ((-1)) NOT NULL,
    [VehicleTypeKey]                    INT DEFAULT ((-1)) NOT NULL,
    [SightingsCount]                    INT NULL,
    [VehicleCountDay]                   INT NULL,
    [VehicleCountDayCamera]             INT NULL,
    [VehicleCountDayRegion]             INT NULL,
    [VehicleCountDayTrafficCentre]      INT NULL,
    [VehicleCountDayTrafficCentreHour]  INT NULL,
    [VehicleCountDayTrafficCentreShift] INT NULL,
    [InsertAuditKey]                    INT DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]                    INT DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]                       INT DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]                   INT DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]                       INT DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactSightingsSummary_CameraKey] FOREIGN KEY ([CameraKey]) REFERENCES [dbo].[DimCamera] ([CameraKey]),
    CONSTRAINT [FK_dbo_FactSightingsSummary_GeoLocationKey] FOREIGN KEY ([GeoLocationKey]) REFERENCES [dbo].[DimGeoLocation] ([GeoLocationKey]),
    CONSTRAINT [FK_dbo_FactSightingsSummary_HourKey] FOREIGN KEY ([HourKey]) REFERENCES [dbo].[DimHour] ([HourKey]),
    CONSTRAINT [FK_dbo_FactSightingsSummary_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactSightingsSummary_OperationsDateKey] FOREIGN KEY ([OperationsDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactSightingsSummary_SightingDateKey] FOREIGN KEY ([SightingDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactSightingsSummary_TrafficCentreKey] FOREIGN KEY ([TrafficCentreKey]) REFERENCES [dbo].[DimTrafficCentre] ([TrafficCentreKey]),
    CONSTRAINT [FK_dbo_FactSightingsSummary_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactSightingsSummary_VehicleTypeKey] FOREIGN KEY ([VehicleTypeKey]) REFERENCES [dbo].[DimVehicleType] ([VehicleTypeKey])
);

