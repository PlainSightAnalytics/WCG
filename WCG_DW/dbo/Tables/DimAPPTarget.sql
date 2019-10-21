CREATE TABLE [dbo].[DimAPPTarget] (
    [APPTargetKey]     INT              IDENTITY (1, 1) NOT NULL,
    [APPTarget]        VARCHAR (100)    DEFAULT ('Unknown') NOT NULL,
    [APPTargetGUID]    UNIQUEIDENTIFIER NULL,
    [OpenClosedStatus] VARCHAR (10)     DEFAULT ('Closed') NOT NULL,
    [RowIsCurrent]     CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]    CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]     DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]       DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]  VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]   INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]   INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]  INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimAPPTarget] PRIMARY KEY CLUSTERED ([APPTargetKey] ASC),
    CONSTRAINT [FK_dbo_DimAPPTarget_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimAPPTarget_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

