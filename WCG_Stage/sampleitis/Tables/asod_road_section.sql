CREATE TABLE [sampleitis].[asod_road_section] (
    [id]                   UNIQUEIDENTIFIER NULL,
    [type]                 NVARCHAR (MAX)   NULL,
    [updated_at]           NVARCHAR (MAX)   NULL,
    [display]              NVARCHAR (MAX)   NULL,
    [magistrates_court_id] UNIQUEIDENTIFIER NULL,
    [operational_area_id]  UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]    UNIQUEIDENTIFIER NULL,
    [asod_distance]        VARCHAR (MAX)    NULL,
    [displayed_name]       VARCHAR (MAX)    NULL,
    [name]                 VARCHAR (MAX)    NULL,
    [DeltaLogKey]          INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]             INT              DEFAULT ((-1)) NOT NULL
);

