﻿CREATE TABLE [dbo].[FactShiftOutcomes] (
    [CriticalOutcomeTypeKey] INT              DEFAULT ((-1)) NOT NULL,
    [OperationsDateKey]      INT              DEFAULT ((-1)) NOT NULL,
    [ShiftDateKey]           INT              DEFAULT ((-1)) NOT NULL,
    [ShiftKey]               INT              DEFAULT ((-1)) NOT NULL,
    [TrafficCentreKey]       INT              DEFAULT ((-1)) NOT NULL,
    [UserKey]                INT              DEFAULT ((-1)) NOT NULL,
    [IsStartedFillingIn]     VARCHAR (3)      NULL,
    [UniqueID]               UNIQUEIDENTIFIER NULL,
    [VehicleCount]           INT              NULL,
    [InsertAuditKey]         INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]         INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]            INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]        INT              DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]            INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactShiftOutcomes_CriticalOutcomeTypeKey] FOREIGN KEY ([CriticalOutcomeTypeKey]) REFERENCES [dbo].[DimCriticalOutcomeType] ([CriticalOutcomeTypeKey]),
    CONSTRAINT [FK_dbo_FactShiftOutcomes_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactShiftOutcomes_OperationsDateKey] FOREIGN KEY ([OperationsDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactShiftOutcomes_ShiftDateKey] FOREIGN KEY ([ShiftDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactShiftOutcomes_ShiftKey] FOREIGN KEY ([ShiftKey]) REFERENCES [dbo].[DimShift] ([ShiftKey]),
    CONSTRAINT [FK_dbo_FactShiftOutcomes_TrafficCentreKey] FOREIGN KEY ([TrafficCentreKey]) REFERENCES [dbo].[DimTrafficCentre] ([TrafficCentreKey]),
    CONSTRAINT [FK_dbo_FactShiftOutcomes_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactShiftOutcomes_UserKey] FOREIGN KEY ([UserKey]) REFERENCES [dbo].[DimUser] ([UserKey])
);
