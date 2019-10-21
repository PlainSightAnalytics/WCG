CREATE TABLE [dbo].[DimCriticalOutcomeType] (
    [CriticalOutcomeTypeKey]    INT           IDENTITY (1, 1) NOT NULL,
    [CriticalOutcomeMetric]     VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [CriticalOutcomeMetricCode] VARCHAR (10)  DEFAULT ('UNK') NOT NULL,
    [CriticalOutcomeType]       VARCHAR (10)  DEFAULT ('Unknown') NOT NULL,
    [CriticalOutcomeTypeCode]   VARCHAR (10)  DEFAULT ('UNK') NOT NULL,
    [IsSystemPopulated]         VARCHAR (3)   DEFAULT ('No') NOT NULL,
    [VehicleType]               VARCHAR (30)  DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]              CHAR (1)      DEFAULT ('Y') NOT NULL,
    [RowIsInferred]             CHAR (1)      DEFAULT ('N') NOT NULL,
    [RowStartDate]              DATETIME      DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]                DATETIME      DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]           VARCHAR (200) DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]            INT           DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]            INT           DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]               INT           DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]           INT           DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimCriticalOutcomeType] PRIMARY KEY CLUSTERED ([CriticalOutcomeTypeKey] ASC),
    CONSTRAINT [FK_dbo_DimCriticalOutcomeType_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimCriticalOutcomeType_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

