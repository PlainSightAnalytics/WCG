CREATE TABLE [dbo].[FactObjectListHistory] (
    [CreateDateKey]        INT         DEFAULT ((-1)) NOT NULL,
    [LastModifiedDateKey]  INT         DEFAULT ((-1)) NOT NULL,
    [ObjectKey]            INT         DEFAULT ((-1)) NOT NULL,
    [IsCurrent]            VARCHAR (3) NULL,
    [LastModifiedDateTime] DATETIME    NULL,
    [InsertAuditKey]       INT         DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]       INT         DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]          INT         DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]      INT         DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]          INT         DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactObjectListHistory_CreateDateKey] FOREIGN KEY ([CreateDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactObjectListHistory_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactObjectListHistory_LastModifiedDateKey] FOREIGN KEY ([LastModifiedDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactObjectListHistory_ObjectKey] FOREIGN KEY ([ObjectKey]) REFERENCES [dbo].[DimObject] ([ObjectKey]),
    CONSTRAINT [FK_dbo_FactObjectListHistory_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

