CREATE TABLE [its].[road_safety_topic] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [archived_key]     VARCHAR (MAX)    NULL,
    [archived_display] VARCHAR (MAX)    NULL,
    [date_created]     VARCHAR (MAX)    NULL,
    [sequence_number]  VARCHAR (MAX)    NULL,
    [topic]            VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]      INT              DEFAULT ((-1)) NOT NULL
);

