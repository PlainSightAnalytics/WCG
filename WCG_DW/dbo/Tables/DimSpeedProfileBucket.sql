CREATE TABLE [dbo].[DimSpeedProfileBucket] (
    [SpeedProfileBucketKey] INT           IDENTITY (1, 1) NOT NULL,
    [FromSpeed]             INT           DEFAULT ((0)) NOT NULL,
    [SortOrder]             INT           DEFAULT ((0)) NOT NULL,
    [SpeedProfileBucket]    VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [ToSpeed]               INT           DEFAULT ((0)) NOT NULL,
    [RowIsCurrent]          CHAR (1)      DEFAULT ('Y') NOT NULL,
    [RowIsInferred]         CHAR (1)      DEFAULT ('N') NOT NULL,
    [RowStartDate]          DATETIME      DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]            DATETIME      DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]       VARCHAR (200) DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]        INT           DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]        INT           DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]           INT           DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]       INT           DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimSpeedProfileBucket] PRIMARY KEY CLUSTERED ([SpeedProfileBucketKey] ASC),
    CONSTRAINT [FK_dbo_DimSpeedProfileBucket_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimSpeedProfileBucket_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

