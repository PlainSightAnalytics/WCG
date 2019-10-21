CREATE TABLE [its].[district] (
    [id]          UNIQUEIDENTIFIER NULL,
    [type]        NVARCHAR (MAX)   NULL,
    [updated_at]  NVARCHAR (MAX)   NULL,
    [display]     NVARCHAR (MAX)   NULL,
    [province_id] UNIQUEIDENTIFIER NULL,
    [name]        VARCHAR (MAX)    NULL,
    [DeltaLogKey] INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey] INT              DEFAULT ((-1)) NOT NULL
);

