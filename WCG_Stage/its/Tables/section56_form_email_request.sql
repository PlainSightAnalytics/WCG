CREATE TABLE [its].[section56_form_email_request] (
    [id]                             UNIQUEIDENTIFIER NULL,
    [type]                           NVARCHAR (MAX)   NULL,
    [updated_at]                     NVARCHAR (MAX)   NULL,
    [display]                        NVARCHAR (MAX)   NULL,
    [section56_form_id]              UNIQUEIDENTIFIER NULL,
    [email]                          VARCHAR (MAX)    NULL,
    [emailed_status_key]             VARCHAR (MAX)    NULL,
    [emailed_status_display]         VARCHAR (MAX)    NULL,
    [has_alternative_charge_key]     VARCHAR (MAX)    NULL,
    [has_alternative_charge_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]                    INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]                    INT              DEFAULT ((-1)) NOT NULL
);

