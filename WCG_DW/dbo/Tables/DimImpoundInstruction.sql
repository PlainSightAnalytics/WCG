﻿CREATE TABLE [dbo].[DimImpoundInstruction] (
    [ImpoundInstructionKey]               INT              IDENTITY (1, 1) NOT NULL,
    [CreateDate]                          DATETIME         NULL,
    [HasJack]                             VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [HasSpanners]                         VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [HasWheelBrace]                       VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [ImpoundDate]                         DATETIME         NULL,
    [ImpoundInstructionID]                UNIQUEIDENTIFIER NULL,
    [ImpoundOfficer]                      VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [ImpoundStatus]                       VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [IncomingImpoundOfficerSignatureDate] DATETIME         NULL,
    [IncomingVehicleOwnerSignatureDate]   DATETIME         NULL,
    [IsReleasedAsScrap]                   VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [Location]                            VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [OffenceCount]                        INT              DEFAULT ((0)) NOT NULL,
    [OffenceDate]                         DATETIME         NULL,
    [OffenceFine]                         NUMERIC (19, 2)  DEFAULT ((0)) NOT NULL,
    [OfficerComments]                     VARCHAR (1000)   NULL,
    [OutgoingImpoundOfficerSignatureDate] DATETIME         NULL,
    [OutgoingVehicleOwnerSignatureDate]   DATETIME         NULL,
    [OverrideReason]                      VARCHAR (1000)   NULL,
    [PoundFacility]                       VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [ReleaseDate]                         DATETIME         NULL,
    [ScrapReason]                         VARCHAR (1000)   NULL,
    [TrafficOfficer]                      VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [ViolationType]                       VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [WrittenNoticeNumber]                 VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]                        CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]                       CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]                        DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]                          DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]                     VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]                      INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]                      INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]                         INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]                     INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimImpoundInstruction] PRIMARY KEY CLUSTERED ([ImpoundInstructionKey] ASC),
    CONSTRAINT [FK_dbo_DimImpoundInstruction_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimImpoundInstruction_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

