CREATE TABLE [itis].[operational_area] (
    [id]                   UNIQUEIDENTIFIER NULL,
    [type]                 VARCHAR (MAX)    NULL,
    [updated_at]           VARCHAR (MAX)    NULL,
    [display]              VARCHAR (MAX)    NULL,
    [magistrates_court_id] UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]    UNIQUEIDENTIFIER NULL,
    [name]                 VARCHAR (MAX)    NULL,
    [DeltaLogKey]          INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]             INT              DEFAULT ((-1)) NOT NULL
);

