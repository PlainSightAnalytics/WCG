CREATE TABLE [its].[alert_response] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [alert_id]         UNIQUEIDENTIFIER NULL,
    [device_id]        UNIQUEIDENTIFIER NULL,
    [user_id]          UNIQUEIDENTIFIER NULL,
    [response_key]     VARCHAR (MAX)    NULL,
    [response_display] VARCHAR (MAX)    NULL,
    [timestamp]        VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]      INT              DEFAULT ((-1)) NOT NULL
);

