CREATE TABLE [itis].[event_road_safety_topic] (
    [id]                   UNIQUEIDENTIFIER NULL,
    [type]                 NVARCHAR (MAX)   NULL,
    [updated_at]           NVARCHAR (MAX)   NULL,
    [display]              NVARCHAR (MAX)   NULL,
    [created_by_id]        UNIQUEIDENTIFIER NULL,
    [event_id]             UNIQUEIDENTIFIER NULL,
    [road_safety_topic_id] UNIQUEIDENTIFIER NULL,
    [archived_key]         VARCHAR (MAX)    NULL,
    [archived_display]     VARCHAR (MAX)    NULL,
    [date_created]         VARCHAR (MAX)    NULL,
    [DeltaLogKey]          INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]             INT              DEFAULT ((-1)) NOT NULL
);

