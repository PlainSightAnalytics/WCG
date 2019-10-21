CREATE TABLE [its].[tle006_request] (
    [id]              UNIQUEIDENTIFIER NULL,
    [type]            NVARCHAR (MAX)   NULL,
    [updated_at]      NVARCHAR (MAX)   NULL,
    [display]         NVARCHAR (MAX)   NULL,
    [user_id]         UNIQUEIDENTIFIER NULL,
    [comment]         VARCHAR (MAX)    NULL,
    [email]           VARCHAR (MAX)    NULL,
    [highest_alcohol] VARCHAR (MAX)    NULL,
    [query_end]       VARCHAR (MAX)    NULL,
    [query_start]     VARCHAR (MAX)    NULL,
    [report_date]     VARCHAR (MAX)    NULL,
    [shift]           VARCHAR (MAX)    NULL,
    [shift_end]       VARCHAR (MAX)    NULL,
    [shift_start]     VARCHAR (MAX)    NULL,
    [signature]       VARCHAR (MAX)    NULL,
    [signature_date]  VARCHAR (MAX)    NULL,
    [status_key]      VARCHAR (MAX)    NULL,
    [status_display]  VARCHAR (MAX)    NULL,
    [DeltaLogKey]     INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]     INT              DEFAULT ((-1)) NOT NULL
);

