CREATE TABLE [its].[adhoc_section56_form_request] (
    [id]                UNIQUEIDENTIFIER NULL,
    [type]              NVARCHAR (MAX)   NULL,
    [updated_at]        NVARCHAR (MAX)   NULL,
    [display]           NVARCHAR (MAX)   NULL,
    [requested_by_id]   UNIQUEIDENTIFIER NULL,
    [traffic_centre_id] UNIQUEIDENTIFIER NULL,
    [email]             VARCHAR (MAX)    NULL,
    [error_message]     VARCHAR (MAX)    NULL,
    [requested_at]      VARCHAR (MAX)    NULL,
    [section56_number]  VARCHAR (MAX)    NULL,
    [status_key]        VARCHAR (MAX)    NULL,
    [status_display]    VARCHAR (MAX)    NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]       INT              DEFAULT ((-1)) NOT NULL
);

