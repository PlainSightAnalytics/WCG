CREATE TABLE [dbo].[FactAPPTargets] (
    [APPTargetKey]     INT              DEFAULT ((-1)) NOT NULL,
    [TargetDateKey]    INT              DEFAULT ((-1)) NOT NULL,
    [TrafficCentreKey] INT              DEFAULT ((-1)) NOT NULL,
    [UniqueGUID]       UNIQUEIDENTIFIER NULL,
    [AdjustedTarget]   NUMERIC (19, 2)  NULL,
    [Target]           NUMERIC (19, 2)  NULL,
    [InsertAuditKey]   INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]   INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]  INT              DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]      INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactAPPTargets_APPTargetKey] FOREIGN KEY ([APPTargetKey]) REFERENCES [dbo].[DimAPPTarget] ([APPTargetKey]),
    CONSTRAINT [FK_dbo_FactAPPTargets_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactAPPTargets_TargetDateKey] FOREIGN KEY ([TargetDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactAPPTargets_TrafficCentreKey] FOREIGN KEY ([TrafficCentreKey]) REFERENCES [dbo].[DimTrafficCentre] ([TrafficCentreKey]),
    CONSTRAINT [FK_dbo_FactAPPTargets_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

