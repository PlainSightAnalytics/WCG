CREATE TABLE [sampleitis].[vehicle_enrichment_request] (
    [id]             UNIQUEIDENTIFIER NULL,
    [type]           NVARCHAR (MAX)   NULL,
    [updated_at]     NVARCHAR (MAX)   NULL,
    [display]        NVARCHAR (MAX)   NULL,
    [device_id]      UNIQUEIDENTIFIER NULL,
    [user_id]        UNIQUEIDENTIFIER NULL,
    [vehicle_id]     UNIQUEIDENTIFIER NULL,
    [field_type]     VARCHAR (MAX)    NULL,
    [query_value]    VARCHAR (MAX)    NULL,
    [status_key]     VARCHAR (MAX)    NULL,
    [status_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]    INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]       INT              DEFAULT ((-1)) NOT NULL
);

