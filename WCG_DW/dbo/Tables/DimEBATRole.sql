CREATE TABLE [dbo].[DimEBATRole] (
    [EBATRoleKey]     INT           IDENTITY (1, 1) NOT NULL,
    [EBATRole]        VARCHAR (20)  DEFAULT ('UNKNOWN') NOT NULL,
    [RowIsCurrent]    CHAR (1)      DEFAULT ('Y') NOT NULL,
    [RowIsInferred]   CHAR (1)      DEFAULT ('N') NOT NULL,
    [RowStartDate]    DATETIME      DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]      DATETIME      DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason] VARCHAR (200) DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]  INT           DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]  INT           DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]     INT           DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey] INT           DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimEBATRole] PRIMARY KEY CLUSTERED ([EBATRoleKey] ASC),
    CONSTRAINT [FK_dbo_DimEBATRole_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimEBATRole_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

