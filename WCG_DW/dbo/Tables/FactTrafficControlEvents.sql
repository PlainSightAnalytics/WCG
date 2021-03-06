﻿CREATE TABLE [dbo].[FactTrafficControlEvents] (
    [AlertTypeKey]           INT              DEFAULT ((-1)) NOT NULL,
    [DeviceKey]              INT              DEFAULT ((-1)) NOT NULL,
    [DriverKey]              INT              DEFAULT ((-1)) NOT NULL,
    [MagistratesCourtKey]    INT              DEFAULT ((-1)) NOT NULL,
    [OpenDateKey]            INT              DEFAULT ((-1)) NOT NULL,
    [OpenTimeKey]            INT              DEFAULT ((-1)) NOT NULL,
    [OperationKey]           INT              DEFAULT ((-1)) NOT NULL,
    [OperationsDateKey]      INT              DEFAULT ((-1)) NOT NULL,
    [TrafficCentreKey]       INT              DEFAULT ((-1)) NOT NULL,
    [TrafficControlEventKey] INT              DEFAULT ((-1)) NOT NULL,
    [UpdatedDateKey]         INT              DEFAULT ((-1)) NOT NULL,
    [UpdatedTimeKey]         INT              DEFAULT ((-1)) NOT NULL,
    [UserKey]                INT              DEFAULT ((-1)) NOT NULL,
    [VehicleKey]             INT              DEFAULT ((-1)) NOT NULL,
    [VehicleTypeKey]         INT              DEFAULT ((-1)) NOT NULL,
    [UniqueAlertID]          UNIQUEIDENTIFIER NULL,
    [UniqueEventID]          UNIQUEIDENTIFIER NULL,
    [InsertAuditKey]         INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]         INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]            INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]        INT              DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]            INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_AlertTypeKey] FOREIGN KEY ([AlertTypeKey]) REFERENCES [dbo].[DimAlertType] ([AlertTypeKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_DeviceKey] FOREIGN KEY ([DeviceKey]) REFERENCES [dbo].[DimDevice] ([DeviceKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_DriverKey] FOREIGN KEY ([DriverKey]) REFERENCES [dbo].[DimDriver] ([DriverKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_MagistratesCourtKey] FOREIGN KEY ([MagistratesCourtKey]) REFERENCES [dbo].[DimMagistratesCourt] ([MagistratesCourtKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_OpenDateKey] FOREIGN KEY ([OpenDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_OpenTimeKey] FOREIGN KEY ([OpenTimeKey]) REFERENCES [dbo].[DimTime] ([TimeKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_OperationKey] FOREIGN KEY ([OperationKey]) REFERENCES [dbo].[DimOperation] ([OperationKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_OperationsDateKey] FOREIGN KEY ([OperationsDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_TrafficCentreKey] FOREIGN KEY ([TrafficCentreKey]) REFERENCES [dbo].[DimTrafficCentre] ([TrafficCentreKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_TrafficControlEventKey] FOREIGN KEY ([TrafficControlEventKey]) REFERENCES [dbo].[DimTrafficControlEvent] ([TrafficControlEventKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_UpdatedDateKey] FOREIGN KEY ([UpdatedDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_UpdatedTimeKey] FOREIGN KEY ([UpdatedTimeKey]) REFERENCES [dbo].[DimTime] ([TimeKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_UserKey] FOREIGN KEY ([UserKey]) REFERENCES [dbo].[DimUser] ([UserKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_VehicleKey] FOREIGN KEY ([VehicleKey]) REFERENCES [dbo].[DimVehicle] ([VehicleKey]),
    CONSTRAINT [FK_dbo_FactTrafficControlEvents_VehicleTypeKey] FOREIGN KEY ([VehicleTypeKey]) REFERENCES [dbo].[DimVehicleType] ([VehicleTypeKey])
);

