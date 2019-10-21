CREATE TABLE [its].[quaterly_app_actual_pdf] (
    [id]                UNIQUEIDENTIFIER NULL,
    [type]              NVARCHAR (MAX)   NULL,
    [updated_at]        NVARCHAR (MAX)   NULL,
    [display]           NVARCHAR (MAX)   NULL,
    [calendar_year_id]  UNIQUEIDENTIFIER NULL,
    [traffic_centre_id] UNIQUEIDENTIFIER NULL,
    [created_at]        VARCHAR (MAX)    NULL,
    [pdf]               VARCHAR (MAX)    NULL,
    [quater_key]        VARCHAR (MAX)    NULL,
    [quater_display]    VARCHAR (MAX)    NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]       INT              DEFAULT ((-1)) NOT NULL
);

