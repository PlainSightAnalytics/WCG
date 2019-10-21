CREATE TABLE [itis].[roster] (
    [id]                UNIQUEIDENTIFIER NULL,
    [type]              NVARCHAR (MAX)   NULL,
    [updated_at]        NVARCHAR (MAX)   NULL,
    [display]           NVARCHAR (MAX)   NULL,
    [roster_group_id]   UNIQUEIDENTIFIER NULL,
    [roster_week_id]    UNIQUEIDENTIFIER NULL,
    [traffic_centre_id] UNIQUEIDENTIFIER NULL,
    [archived_key]      VARCHAR (MAX)    NULL,
    [archived_display]  VARCHAR (MAX)    NULL,
    [comment]           VARCHAR (MAX)    NULL,
    [deleted_key]       VARCHAR (MAX)    NULL,
    [deleted_display]   VARCHAR (MAX)    NULL,
    [monday_date]       VARCHAR (MAX)    NULL,
    [revised_key]       VARCHAR (MAX)    NULL,
    [revised_display]   VARCHAR (MAX)    NULL,
    [status_key]        VARCHAR (MAX)    NULL,
    [status_display]    VARCHAR (MAX)    NULL,
    [sunday_date]       VARCHAR (MAX)    NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]          INT              DEFAULT ((-1)) NOT NULL
);

