CREATE TABLE [sampleebat].[court_detail] (
    [id]                      UNIQUEIDENTIFIER NULL,
    [type]                    NVARCHAR (MAX)   NULL,
    [updated_at]              NVARCHAR (MAX)   NULL,
    [display]                 NVARCHAR (MAX)   NULL,
    [ebat_report_id]          UNIQUEIDENTIFIER NULL,
    [user_id]                 UNIQUEIDENTIFIER NULL,
    [action_required_key]     VARCHAR (MAX)    NULL,
    [action_required_display] VARCHAR (MAX)    NULL,
    [action_required_mult]    VARCHAR (MAX)    NULL,
    [archived_key]            VARCHAR (MAX)    NULL,
    [archived_display]        VARCHAR (MAX)    NULL,
    [court]                   VARCHAR (MAX)    NULL,
    [documentation]           VARCHAR (MAX)    NULL,
    [next_hearing_date]       VARCHAR (MAX)    NULL,
    [reason_withdrawn]        VARCHAR (MAX)    NULL,
    [status_key]              VARCHAR (MAX)    NULL,
    [status_display]          VARCHAR (MAX)    NULL,
    [DeltaLogKey]             INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                INT              DEFAULT ((-1)) NOT NULL
);

