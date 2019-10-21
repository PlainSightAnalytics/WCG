CREATE TABLE [its].[roster_assignment] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [roster_group_id]  UNIQUEIDENTIFIER NULL,
    [user_id]          UNIQUEIDENTIFIER NULL,
    [archived_key]     VARCHAR (MAX)    NULL,
    [archived_display] VARCHAR (MAX)    NULL,
    [historic_key]     VARCHAR (MAX)    NULL,
    [historic_display] VARCHAR (MAX)    NULL,
    [name]             VARCHAR (MAX)    NULL,
    [role_key]         VARCHAR (MAX)    NULL,
    [role_display]     VARCHAR (MAX)    NULL,
    [surname]          VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]      INT              DEFAULT ((-1)) NOT NULL
);

