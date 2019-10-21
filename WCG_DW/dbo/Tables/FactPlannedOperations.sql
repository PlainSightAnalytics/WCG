CREATE TABLE [dbo].[FactPlannedOperations] (
    [OperationalOfficerUserKey] INT              DEFAULT ((-1)) NOT NULL,
    [OperationKey]              INT              DEFAULT ((-1)) NOT NULL,
    [OperationsDateKey]         INT              DEFAULT ((-1)) NOT NULL,
    [PlannedDateKey]            INT              DEFAULT ((-1)) NOT NULL,
    [PlannerUserKey]            INT              DEFAULT ((-1)) NOT NULL,
    [TrafficCentreKey]          INT              DEFAULT ((-1)) NOT NULL,
    [UniqueID]                  UNIQUEIDENTIFIER NULL,
    [InsertAuditKey]            INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]            INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]               INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]           INT              DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]               INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactPlannedOperations_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactPlannedOperations_OperationalOfficerUserKey] FOREIGN KEY ([OperationalOfficerUserKey]) REFERENCES [dbo].[DimUser] ([UserKey]),
    CONSTRAINT [FK_dbo_FactPlannedOperations_OperationKey] FOREIGN KEY ([OperationKey]) REFERENCES [dbo].[DimOperation] ([OperationKey]),
    CONSTRAINT [FK_dbo_FactPlannedOperations_OperationsDateKey] FOREIGN KEY ([OperationsDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactPlannedOperations_PlannedDateKey] FOREIGN KEY ([PlannedDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactPlannedOperations_PlannerUserKey] FOREIGN KEY ([PlannerUserKey]) REFERENCES [dbo].[DimUser] ([UserKey]),
    CONSTRAINT [FK_dbo_FactPlannedOperations_TrafficCentreKey] FOREIGN KEY ([TrafficCentreKey]) REFERENCES [dbo].[DimTrafficCentre] ([TrafficCentreKey]),
    CONSTRAINT [FK_dbo_FactPlannedOperations_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

