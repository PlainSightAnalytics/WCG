CREATE TABLE [sampleitis].[tle006_request_email] (
    [id]                UNIQUEIDENTIFIER NULL,
    [type]              NVARCHAR (MAX)   NULL,
    [updated_at]        NVARCHAR (MAX)   NULL,
    [display]           NVARCHAR (MAX)   NULL,
    [tle006_request_id] UNIQUEIDENTIFIER NULL,
    [user_id]           UNIQUEIDENTIFIER NULL,
    [created_at]        VARCHAR (MAX)    NULL,
    [email]             VARCHAR (MAX)    NULL,
    [highest_alcohol]   VARCHAR (MAX)    NULL,
    [report_date]       VARCHAR (MAX)    NULL,
    [shift_end]         VARCHAR (MAX)    NULL,
    [shift_start]       VARCHAR (MAX)    NULL,
    [status_key]        VARCHAR (MAX)    NULL,
    [status_display]    VARCHAR (MAX)    NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]          INT              DEFAULT ((-1)) NOT NULL
);

