CREATE TABLE [dbo].[DimAudit] (
    [AuditKey]        INT          IDENTITY (1, 1) NOT NULL,
    [ParentAuditKey]  INT          DEFAULT ((-1)) NOT NULL,
    [ClientName]      VARCHAR (50) DEFAULT ('Unknown') NULL,
    [DateTimeStart]   DATETIME     NULL,
    [DateTimeStop]    DATETIME     NULL,
    [RowCountError]   INT          DEFAULT ((0)) NULL,
    [RowCountFinal]   INT          DEFAULT ((0)) NULL,
    [RowCountInitial] INT          DEFAULT ((0)) NULL,
    [RowCountInsert]  INT          DEFAULT ((0)) NULL,
    [RowCountUpdate]  INT          DEFAULT ((0)) NULL,
    [SchemaName]      VARCHAR (50) DEFAULT ('Unknown') NULL,
    [ScriptName]      VARCHAR (50) DEFAULT ('Unknown') NULL,
    [Successful]      CHAR (1)     DEFAULT ('N') NULL,
    [TableName]       VARCHAR (50) DEFAULT ('Unknown') NULL,
    CONSTRAINT [PK_dbo.DimAudit] PRIMARY KEY CLUSTERED ([AuditKey] ASC),
    CONSTRAINT [FK_wcg_DimAudit_ParentAuditKey] FOREIGN KEY ([ParentAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

