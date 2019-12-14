CREATE TABLE [dbo].[DimGeographicalLocation] (
    [GeographicalLocationKey] INT             IDENTITY (1, 1) NOT NULL,
    [Latitude]                NUMERIC (11, 6) DEFAULT ((0)) NOT NULL,
    [LatitudeRange]           NUMERIC (11, 2) DEFAULT ((0)) NOT NULL,
    [LocationName]            VARCHAR (50)    DEFAULT ('Unamed Location') NOT NULL,
    [LocationType]            VARCHAR (20)    DEFAULT ('Unknown') NOT NULL,
    [Longitude]               NUMERIC (11, 6) DEFAULT ((0)) NOT NULL,
    [LongitudeRange]          NUMERIC (11, 2) DEFAULT ((0)) NOT NULL,
    [Source]                  VARCHAR (20)    DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]            CHAR (1)        DEFAULT ('Y') NOT NULL,
    [RowIsInferred]           CHAR (1)        DEFAULT ('N') NOT NULL,
    [RowStartDate]            DATETIME        DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]              DATETIME        DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]         VARCHAR (200)   DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]          INT             DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]          INT             DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]             INT             DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]         INT             DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimGeographicalLocation] PRIMARY KEY CLUSTERED ([GeographicalLocationKey] ASC),
    CONSTRAINT [FK_dbo_DimGeographicalLocation_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimGeographicalLocation_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

