CREATE TABLE [dbo].[FactAPPActuals] (
    [ActualDateKey]     INT              DEFAULT ((-1)) NOT NULL,
    [APPTargetKey]      INT              DEFAULT ((-1)) NOT NULL,
    [TrafficCentreKey]  INT              DEFAULT ((-1)) NOT NULL,
    [Comments]          VARCHAR (1000)   NULL,
    [UniqueGUID]        UNIQUEIDENTIFIER NULL,
    [PreliminaryActual] NUMERIC (19, 2)  NULL,
    [VerifiedActual]    NUMERIC (19, 2)  NULL,
    [InsertAuditKey]    INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]    INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]   INT              DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]       INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactAPPActuals_ActualDateKey] FOREIGN KEY ([ActualDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactAPPActuals_APPTargetKey] FOREIGN KEY ([APPTargetKey]) REFERENCES [dbo].[DimAPPTarget] ([APPTargetKey]),
    CONSTRAINT [FK_dbo_FactAPPActuals_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactAPPActuals_TrafficCentreKey] FOREIGN KEY ([TrafficCentreKey]) REFERENCES [dbo].[DimTrafficCentre] ([TrafficCentreKey]),
    CONSTRAINT [FK_dbo_FactAPPActuals_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

