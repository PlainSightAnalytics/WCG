CREATE TABLE [dbo].[FactOperationAssignments] (
    [OperationDateKey]  INT              DEFAULT ((-1)) NOT NULL,
    [OperationKey]      INT              DEFAULT ((-1)) NOT NULL,
    [OperationsDateKey] INT              DEFAULT ((-1)) NOT NULL,
    [TrafficCentreKey]  INT              DEFAULT ((-1)) NOT NULL,
    [UserKey]           INT              DEFAULT ((-1)) NOT NULL,
    [UniqueID]          UNIQUEIDENTIFIER NULL,
    [InsertAuditKey]    INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]    INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]   INT              DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]       INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactOperationAssignments_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactOperationAssignments_OperationDateKey] FOREIGN KEY ([OperationDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactOperationAssignments_OperationKey] FOREIGN KEY ([OperationKey]) REFERENCES [dbo].[DimOperation] ([OperationKey]),
    CONSTRAINT [FK_dbo_FactOperationAssignments_OperationsDateKey] FOREIGN KEY ([OperationsDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactOperationAssignments_TrafficCentreKey] FOREIGN KEY ([TrafficCentreKey]) REFERENCES [dbo].[DimTrafficCentre] ([TrafficCentreKey]),
    CONSTRAINT [FK_dbo_FactOperationAssignments_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactOperationAssignments_UserKey] FOREIGN KEY ([UserKey]) REFERENCES [dbo].[DimUser] ([UserKey])
);

