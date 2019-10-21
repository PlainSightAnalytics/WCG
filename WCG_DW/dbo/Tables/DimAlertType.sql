CREATE TABLE [dbo].[DimAlertType] (
    [AlertTypeKey]         INT           IDENTITY (1, 1) NOT NULL,
    [AlertSubType]         VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [AlertSubTypeCode]     VARCHAR (20)  DEFAULT ('UNK') NOT NULL,
    [AlertType]            VARCHAR (30)  NOT NULL,
    [AlertTypeDescription] VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [AlertTypeId]          INT           DEFAULT ((0)) NOT NULL,
    [IsCountedInReport]    VARCHAR (3)   DEFAULT ('No') NOT NULL,
    [RowIsCurrent]         CHAR (1)      DEFAULT ('Y') NOT NULL,
    [RowIsInferred]        CHAR (1)      DEFAULT ('N') NOT NULL,
    [RowStartDate]         DATETIME      DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]           DATETIME      DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]      VARCHAR (200) DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]       INT           DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]       INT           DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]          INT           DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]      INT           DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimAlertType] PRIMARY KEY CLUSTERED ([AlertTypeKey] ASC),
    CONSTRAINT [FK_dbo_DimAlertType_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimAlertType_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

