CREATE TABLE [dbo].[DimUser] (
    [UserKey]              INT              IDENTITY (1, 1) NOT NULL,
    [Designation]          VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [InfrastructureNumber] VARCHAR (30)     DEFAULT ('Unknown') NOT NULL,
    [Role]                 VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [User]                 VARCHAR (100)    DEFAULT ('Unknown') NOT NULL,
    [UserID]               UNIQUEIDENTIFIER NULL,
    [UserTrafficCentre]    VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]         CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]        CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]         DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]           DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]      VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]       INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]       INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]          INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]      INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimUser] PRIMARY KEY CLUSTERED ([UserKey] ASC),
    CONSTRAINT [FK_dbo_DimUser_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimUser_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

