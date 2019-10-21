﻿CREATE TABLE [dbo].[DimViolationCharge] (
    [ViolationChargeKey]     INT              IDENTITY (1, 1) NOT NULL,
    [ChargeAmount]           NUMERIC (19, 2)  DEFAULT ((0)) NOT NULL,
    [ChargeCategory]         VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [ChargeCategoryOrder]    INT              DEFAULT ((0)) NOT NULL,
    [ChargeCode]             VARCHAR (10)     DEFAULT ('UNK') NOT NULL,
    [ChargeDescription]      VARCHAR (300)    DEFAULT ('Unknown') NOT NULL,
    [ChargeGUID]             UNIQUEIDENTIFIER NULL,
    [ChargeSubCategory]      VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [ChargeSubCategoryOrder] INT              DEFAULT ((0)) NOT NULL,
    [RegulationNumber]       VARCHAR (100)    DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]           CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]          CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]           DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]             DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]        VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]         INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]         INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]            INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]        INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimViolationCharge] PRIMARY KEY CLUSTERED ([ViolationChargeKey] ASC),
    CONSTRAINT [FK_dbo_DimViolationCharge_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimViolationCharge_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

