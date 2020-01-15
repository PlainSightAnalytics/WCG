CREATE TABLE [dbo].[FactExecutionLog] (
    [ExecutionDateKey] INT           DEFAULT ((-1)) NOT NULL,
    [ExecutionHourKey] INT           DEFAULT ((-1)) NOT NULL,
    [ExecutionTimeKey] INT           DEFAULT ((-1)) NOT NULL,
    [ObjectKey]        INT           DEFAULT ((-1)) NOT NULL,
    [Exception]        VARCHAR (500) NULL,
    [ExecutionLogKey]  BIGINT        NULL,
    [Duration]         INT           NULL,
    [InsertAuditKey]   INT           DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]   INT           DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]      INT           DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]  INT           DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]      INT           DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactExecutionLog_ExecutionDateKey] FOREIGN KEY ([ExecutionDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactExecutionLog_ExecutionHourKey] FOREIGN KEY ([ExecutionHourKey]) REFERENCES [dbo].[DimHour] ([HourKey]),
    CONSTRAINT [FK_dbo_FactExecutionLog_ExecutionTimeKey] FOREIGN KEY ([ExecutionTimeKey]) REFERENCES [dbo].[DimTime] ([TimeKey]),
    CONSTRAINT [FK_dbo_FactExecutionLog_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactExecutionLog_ObjectKey] FOREIGN KEY ([ObjectKey]) REFERENCES [dbo].[DimObject] ([ObjectKey]),
    CONSTRAINT [FK_dbo_FactExecutionLog_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

