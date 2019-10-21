CREATE TABLE [dbo].[DimDevice] (
    [DeviceKey]        INT              IDENTITY (1, 1) NOT NULL,
    [CurrentUserKey]   INT              DEFAULT ((-1)) NOT NULL,
    [TrafficCentreKey] INT              DEFAULT ((-1)) NOT NULL,
    [Device]           VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [DeviceID]         UNIQUEIDENTIFIER NULL,
    [DeviceType]       VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]     CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]    CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]     DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]       DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]  VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]   INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]   INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]  INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimDevice] PRIMARY KEY CLUSTERED ([DeviceKey] ASC),
    CONSTRAINT [FK_dbo_DimDevice_CurrentUserKey] FOREIGN KEY ([CurrentUserKey]) REFERENCES [dbo].[DimUser] ([UserKey]),
    CONSTRAINT [FK_dbo_DimDevice_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimDevice_TrafficCentreKey] FOREIGN KEY ([TrafficCentreKey]) REFERENCES [dbo].[DimTrafficCentre] ([TrafficCentreKey]),
    CONSTRAINT [FK_dbo_DimDevice_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

