﻿CREATE TABLE [dbo].[DimEBATIncident] (
    [EBATIncidentKey]             INT              IDENTITY (1, 1) NOT NULL,
    [AccidentIndicator]           VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [AccidentLocation]            VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [CaseNumber]                  VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [EBATReportId]                UNIQUEIDENTIFIER NULL,
    [EBATStatus]                  VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [NatureOfInjuries]            VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [NotSuccessfulReason]         VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [NumberOfVehicles]            INT              DEFAULT ((0)) NOT NULL,
    [ProtocolNumber]              VARCHAR (10)     DEFAULT ('Unknown') NOT NULL,
    [ReadingResult]               NUMERIC (19, 2)  DEFAULT ((0)) NULL,
    [ReadingResultCategory]       VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [RecordNumber]                VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [ReferredIndicator]           VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [ReferredLocation]            VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [ReferredType]                VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [RoadSideActivity]            VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [SubjectDateOfBirth]          DATE             NULL,
    [SubjectFirstName]            VARCHAR (50)     NULL,
    [SubjectGender]               VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [SubjectIdentificationNumber] VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [SubjectIdentificationType]   VARCHAR (30)     DEFAULT ('Unknown') NOT NULL,
    [SubjectInitials]             VARCHAR (10)     NULL,
    [SubjectOccupationSector]     VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [SubjectSurname]              VARCHAR (50)     NULL,
    [SubjectTelephoneNumber]      VARCHAR (15)     DEFAULT ('Unknown') NOT NULL,
    [VehicleColour]               VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [VehicleMake]                 VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [VehicleRegistrationNumber]   VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [VehicleType]                 VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]                CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]               CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]                DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]                  DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]             VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]              INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]              INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]                 INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]             INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimEBATIncident] PRIMARY KEY CLUSTERED ([EBATIncidentKey] ASC),
    CONSTRAINT [FK_dbo_DimEBATIncident_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimEBATIncident_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

