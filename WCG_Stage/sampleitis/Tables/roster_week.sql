CREATE TABLE [sampleitis].[roster_week] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [archived_key]     VARCHAR (MAX)    NULL,
    [archived_display] VARCHAR (MAX)    NULL,
    [deleted_key]      VARCHAR (MAX)    NULL,
    [deleted_display]  VARCHAR (MAX)    NULL,
    [monday_date]      VARCHAR (MAX)    NULL,
    [sunday_date]      VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]         INT              DEFAULT ((-1)) NOT NULL
);

