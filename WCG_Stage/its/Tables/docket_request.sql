CREATE TABLE [its].[docket_request] (
    [id]             UNIQUEIDENTIFIER NULL,
    [type]           NVARCHAR (MAX)   NULL,
    [updated_at]     NVARCHAR (MAX)   NULL,
    [display]        NVARCHAR (MAX)   NULL,
    [event_id]       UNIQUEIDENTIFIER NULL,
    [user_id]        UNIQUEIDENTIFIER NULL,
    [email]          VARCHAR (MAX)    NULL,
    [status_key]     VARCHAR (MAX)    NULL,
    [status_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]    INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]    INT              DEFAULT ((-1)) NOT NULL
);

