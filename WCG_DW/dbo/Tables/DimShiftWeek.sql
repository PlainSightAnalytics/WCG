CREATE TABLE [dbo].[DimShiftWeek] (
    [ShiftWeekKey]    INT              IDENTITY (1, 1) NOT NULL,
    [IsUserWeek]      VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [RosterWeek]      VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [ShiftWeek]       VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [ShiftWeekGUID]   UNIQUEIDENTIFIER NULL,
    [User]            VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [UserRole]        VARCHAR (30)     DEFAULT ('Unknown') NOT NULL,
    [WeekEndDate]     DATE             NULL,
    [WeekStartDate]   DATE             NULL,
    [RowIsCurrent]    CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]   CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]    DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]      DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason] VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]  INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]  INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]     INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey] INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimShiftWeek] PRIMARY KEY CLUSTERED ([ShiftWeekKey] ASC),
    CONSTRAINT [FK_dbo_DimShiftWeek_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimShiftWeek_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

