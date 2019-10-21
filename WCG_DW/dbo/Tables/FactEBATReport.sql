﻿CREATE TABLE [dbo].[FactEBATReport] (
    [DriverKey]           INT              DEFAULT ((-1)) NOT NULL,
    [EBATDeviceKey]       INT              DEFAULT ((-1)) NOT NULL,
    [EBATIncidentKey]     INT              DEFAULT ((-1)) NOT NULL,
    [MagistratesCourtKey] INT              DEFAULT ((-1)) NOT NULL,
    [OfficerKey]          INT              DEFAULT ((-1)) NOT NULL,
    [OperationsDateKey]   INT              DEFAULT ((-1)) NOT NULL,
    [OperatorKey]         INT              DEFAULT ((-1)) NOT NULL,
    [ReportDateKey]       INT              DEFAULT ((-1)) NOT NULL,
    [ReportTimeKey]       INT              DEFAULT ((-1)) NOT NULL,
    [VehicleKey]          INT              DEFAULT ((-1)) NOT NULL,
    [UniqueId]            UNIQUEIDENTIFIER NULL,
    [NumberOfVehicles]    INT              NULL,
    [ReadingResult]       NUMERIC (19, 2)  NULL,
    [InsertAuditKey]      INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]      INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]         INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]     INT              DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]         INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactEBATReport_DriverKey] FOREIGN KEY ([DriverKey]) REFERENCES [dbo].[DimDriver] ([DriverKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_EBATDeviceKey] FOREIGN KEY ([EBATDeviceKey]) REFERENCES [dbo].[DimEBATDevice] ([EBATDeviceKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_EBATIncidentKey] FOREIGN KEY ([EBATIncidentKey]) REFERENCES [dbo].[DimEBATIncident] ([EBATIncidentKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_MagistratesCourtKey] FOREIGN KEY ([MagistratesCourtKey]) REFERENCES [dbo].[DimMagistratesCourt] ([MagistratesCourtKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_OfficerKey] FOREIGN KEY ([OfficerKey]) REFERENCES [dbo].[DimOfficer] ([OfficerKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_OperationsDateKey] FOREIGN KEY ([OperationsDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_OperatorKey] FOREIGN KEY ([OperatorKey]) REFERENCES [dbo].[DimOperator] ([OperatorKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_ReportDateKey] FOREIGN KEY ([ReportDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_ReportTimeKey] FOREIGN KEY ([ReportTimeKey]) REFERENCES [dbo].[DimTime] ([TimeKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactEBATReport_VehicleKey] FOREIGN KEY ([VehicleKey]) REFERENCES [dbo].[DimVehicle] ([VehicleKey])
);

