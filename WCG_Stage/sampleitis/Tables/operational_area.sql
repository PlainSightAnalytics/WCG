CREATE TABLE [sampleitis].[operational_area] (
    [id]                            UNIQUEIDENTIFIER NULL,
    [type]                          NVARCHAR (MAX)   NULL,
    [updated_at]                    NVARCHAR (MAX)   NULL,
    [display]                       NVARCHAR (MAX)   NULL,
    [magistrates_court_id]          UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]             UNIQUEIDENTIFIER NULL,
    [is_default_key]                VARCHAR (MAX)    NULL,
    [is_default_display]            VARCHAR (MAX)    NULL,
    [name]                          VARCHAR (MAX)    NULL,
    [not_linked_to_cameras_key]     VARCHAR (MAX)    NULL,
    [not_linked_to_cameras_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]                   INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                      INT              DEFAULT ((-1)) NOT NULL
);

