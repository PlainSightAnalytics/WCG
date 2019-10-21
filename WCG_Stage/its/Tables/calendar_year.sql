CREATE TABLE [its].[calendar_year] (
    [id]          UNIQUEIDENTIFIER NULL,
    [type]        NVARCHAR (MAX)   NULL,
    [updated_at]  NVARCHAR (MAX)   NULL,
    [display]     NVARCHAR (MAX)   NULL,
    [end_year]    VARCHAR (MAX)    NULL,
    [year]        VARCHAR (MAX)    NULL,
    [DeltaLogKey] INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey] INT              DEFAULT ((-1)) NOT NULL
);

