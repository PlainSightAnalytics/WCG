﻿CREATE TABLE [dbo].[DimObject] (
    [ObjectKey]            INT           IDENTITY (1, 1) NOT NULL,
    [CreateDateTime]       DATETIME      NULL,
    [LastModifiedDateTime] DATETIME      NULL,
    [ObjectFullName]       VARCHAR (100) DEFAULT ('Unknown') NOT NULL,
    [ObjectLocation]       VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [ObjectName]           VARCHAR (100) DEFAULT ('Unknown') NOT NULL,
    [ObjectType]           VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [ObjectTypeOrder]      INT           DEFAULT ((0)) NOT NULL,
    [ParentObject]         VARCHAR (100) DEFAULT ('Unknown') NOT NULL,
    [ParentObjectOrder]    INT           DEFAULT ((0)) NOT NULL,
    [SchemaName]           VARCHAR (10)  DEFAULT ('UNK') NOT NULL,
    [RowIsCurrent]         CHAR (1)      DEFAULT ('Y') NOT NULL,
    [RowIsInferred]        CHAR (1)      DEFAULT ('N') NOT NULL,
    [RowStartDate]         DATETIME      DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]           DATETIME      DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]      VARCHAR (200) DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]       INT           DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]       INT           DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]          INT           DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]      INT           DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimObject] PRIMARY KEY CLUSTERED ([ObjectKey] ASC),
    CONSTRAINT [FK_dbo_DimObject_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimObject_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);
