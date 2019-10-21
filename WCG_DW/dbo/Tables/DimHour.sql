CREATE TABLE [dbo].[DimHour] (
    [HourKey]         INT           IDENTITY (1, 1) NOT NULL,
    [AMPMIndicator]   VARCHAR (2)   DEFAULT ('AM') NOT NULL,
    [Hour24]          INT           DEFAULT ((0)) NOT NULL,
    [HourBand]        VARCHAR (15)  DEFAULT ('Unknown') NOT NULL,
    [HourShiftSort]   INT           DEFAULT ((0)) NOT NULL,
    [Is6amTo8pm]      VARCHAR (3)   DEFAULT ('No') NOT NULL,
    [PeriodOfDay]     VARCHAR (10)  DEFAULT ('Unknown') NOT NULL,
    [Shift]           VARCHAR (10)  DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]    CHAR (1)      DEFAULT ('Y') NOT NULL,
    [RowIsInferred]   CHAR (1)      DEFAULT ('N') NOT NULL,
    [RowStartDate]    DATETIME      DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]      DATETIME      DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason] VARCHAR (200) DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]  INT           DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]  INT           DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]     INT           DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey] INT           DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimHour] PRIMARY KEY CLUSTERED ([HourKey] ASC),
    CONSTRAINT [FK_dbo_DimHour_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimHour_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

