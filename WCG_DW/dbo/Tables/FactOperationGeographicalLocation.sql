CREATE TABLE [dbo].[FactOperationGeographicalLocation] (
    [GeographicalLocationKey] INT              DEFAULT ((-1)) NOT NULL,
    [OperationIDKey]          INT              DEFAULT ((-1)) NOT NULL,
    [UniqueID]                UNIQUEIDENTIFIER NULL,
    [InsertAuditKey]          INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]          INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]             INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]         INT              DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]             INT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactOperationGeographicalLocation_GeographicalLocationKey] FOREIGN KEY ([GeographicalLocationKey]) REFERENCES [dbo].[DimGeographicalLocation] ([GeographicalLocationKey]),
    CONSTRAINT [FK_dbo_FactOperationGeographicalLocation_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactOperationGeographicalLocation_OperationIDKey] FOREIGN KEY ([OperationIDKey]) REFERENCES [dbo].[DimOperation] ([OperationKey]),
    CONSTRAINT [FK_dbo_FactOperationGeographicalLocation_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

