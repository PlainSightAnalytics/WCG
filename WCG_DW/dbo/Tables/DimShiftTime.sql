CREATE TABLE [dbo].[DimShiftTime] (
    [ShiftTimeKey]    INT              IDENTITY (1, 1) NOT NULL,
    [DurationHours]   NUMERIC (11, 2)  DEFAULT ((0)) NOT NULL,
    [EndTime]         TIME (7)         DEFAULT ('0:00') NOT NULL,
    [IsOffDuty]       VARCHAR (3)      DEFAULT ('Yes') NOT NULL,
    [ShiftTime]       VARCHAR (30)     DEFAULT ('Unknown') NOT NULL,
    [ShiftTimeGUID]   UNIQUEIDENTIFIER NULL,
    [ShiftTimeSort]   INT              DEFAULT ((0)) NOT NULL,
    [StartTime]       TIME (7)         DEFAULT ('0:00') NOT NULL,
    [TrafficCentre]   VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]    CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]   CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]    DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]      DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason] VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]  INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]  INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]     INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey] INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimShiftTime] PRIMARY KEY CLUSTERED ([ShiftTimeKey] ASC),
    CONSTRAINT [FK_dbo_DimShiftTime_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimShiftTime_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

