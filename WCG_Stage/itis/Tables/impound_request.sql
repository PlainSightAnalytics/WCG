CREATE TABLE [itis].[impound_request] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [event_id]         UNIQUEIDENTIFIER NULL,
    [impound_id]       UNIQUEIDENTIFIER NULL,
    [error_message]    VARCHAR (MAX)    NULL,
    [override_key]     VARCHAR (MAX)    NULL,
    [override_display] VARCHAR (MAX)    NULL,
    [override_reason]  VARCHAR (MAX)    NULL,
    [status_key]       VARCHAR (MAX)    NULL,
    [status_display]   VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]         INT              DEFAULT ((-1)) NOT NULL
);

