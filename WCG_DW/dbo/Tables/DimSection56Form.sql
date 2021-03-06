﻿CREATE TABLE [dbo].[DimSection56Form] (
    [Section56FormKey]       INT              IDENTITY (1, 1) NOT NULL,
    [CourtCode]              VARCHAR (10)     DEFAULT ('Unknown') NOT NULL,
    [CourtName]              VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [GeneratedDateTime]      DATETIME         NULL,
    [IsManualEntry]          VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [LicenceCode]            VARCHAR (100)    DEFAULT ('Unknown') NOT NULL,
    [Section56FormGUID]      UNIQUEIDENTIFIER NULL,
    [Section56Number]        VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [SubjectAge]             INT              DEFAULT ((0)) NOT NULL,
    [SubjectFirstNames]      VARCHAR (50)     NULL,
    [SubjectGender]          VARCHAR (10)     DEFAULT ('Unknown') NOT NULL,
    [SubjectIDNumber]        VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [SubjectIDNumberForeign] VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [SubjectNationality]     VARCHAR (30)     DEFAULT ('Unknown') NOT NULL,
    [SubjectSurname]         VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]           CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]          CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]           DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]             DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]        VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]         INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]         INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]            INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]        INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimSection56Form] PRIMARY KEY CLUSTERED ([Section56FormKey] ASC),
    CONSTRAINT [FK_dbo_DimSection56Form_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimSection56Form_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

