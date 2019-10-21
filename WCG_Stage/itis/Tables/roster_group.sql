CREATE TABLE [itis].[roster_group] (
    [id]                UNIQUEIDENTIFIER NULL,
    [type]              NVARCHAR (MAX)   NULL,
    [updated_at]        NVARCHAR (MAX)   NULL,
    [display]           NVARCHAR (MAX)   NULL,
    [created_by_id]     UNIQUEIDENTIFIER NULL,
    [reports_to_id]     UNIQUEIDENTIFIER NULL,
    [traffic_centre_id] UNIQUEIDENTIFIER NULL,
    [user_ppi_id]       UNIQUEIDENTIFIER NULL,
    [user_spi_id]       UNIQUEIDENTIFIER NULL,
    [archived_key]      VARCHAR (MAX)    NULL,
    [archived_display]  VARCHAR (MAX)    NULL,
    [deleted_key]       VARCHAR (MAX)    NULL,
    [deleted_display]   VARCHAR (MAX)    NULL,
    [name]              VARCHAR (MAX)    NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]          INT              DEFAULT ((-1)) NOT NULL
);

