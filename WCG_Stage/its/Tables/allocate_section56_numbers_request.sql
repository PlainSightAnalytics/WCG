CREATE TABLE [its].[allocate_section56_numbers_request] (
    [id]             UNIQUEIDENTIFIER NULL,
    [type]           NVARCHAR (MAX)   NULL,
    [updated_at]     NVARCHAR (MAX)   NULL,
    [display]        NVARCHAR (MAX)   NULL,
    [user_id]        UNIQUEIDENTIFIER NULL,
    [error_message]  VARCHAR (MAX)    NULL,
    [status_key]     VARCHAR (MAX)    NULL,
    [status_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]    INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]    INT              DEFAULT ((-1)) NOT NULL
);

