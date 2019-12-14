CREATE TABLE [itis].[operation_location_join] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [operation_id]     UNIQUEIDENTIFIER NULL,
    [site_id]          UNIQUEIDENTIFIER NULL,
    [archived_key]     VARCHAR (MAX)    NULL,
    [archived_display] VARCHAR (MAX)    NULL,
    [created_at]       VARCHAR (MAX)    NULL,
    [location_name]    VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]         INT              DEFAULT ((-1)) NOT NULL
);

