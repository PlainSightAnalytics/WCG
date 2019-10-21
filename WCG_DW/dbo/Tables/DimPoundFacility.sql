CREATE TABLE [dbo].[DimPoundFacility] (
    [PoundFacilityKey]  INT              IDENTITY (1, 1) NOT NULL,
    [LocalMunicipality] VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [PoundFacility]     VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [PoundFacilityID]   UNIQUEIDENTIFIER NULL,
    [TrafficCentre]     VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]      CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]     CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]      DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]        DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]   VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]    INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]    INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]   INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimPoundFacility] PRIMARY KEY CLUSTERED ([PoundFacilityKey] ASC),
    CONSTRAINT [FK_dbo_DimPoundFacility_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimPoundFacility_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

