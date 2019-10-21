CREATE TABLE [its].[app_target] (
    [id]              UNIQUEIDENTIFIER NULL,
    [type]            NVARCHAR (MAX)   NULL,
    [updated_at]      NVARCHAR (MAX)   NULL,
    [display]         NVARCHAR (MAX)   NULL,
    [description]     VARCHAR (MAX)    NULL,
    [sequence_number] VARCHAR (MAX)    NULL,
    [status_key]      VARCHAR (MAX)    NULL,
    [status_display]  VARCHAR (MAX)    NULL,
    [DeltaLogKey]     INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]     INT              DEFAULT ((-1)) NOT NULL
);

