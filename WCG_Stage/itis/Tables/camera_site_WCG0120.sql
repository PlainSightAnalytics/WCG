CREATE TABLE [itis].[camera_site_WCG0120] (
    [id]                   UNIQUEIDENTIFIER NULL,
    [type]                 NVARCHAR (MAX)   NULL,
    [updated_at]           NVARCHAR (MAX)   NULL,
    [display]              NVARCHAR (MAX)   NULL,
    [operational_area_id]  UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]    UNIQUEIDENTIFIER NULL,
    [camera_id_number]     VARCHAR (MAX)    NULL,
    [lane_id_number]       VARCHAR (MAX)    NULL,
    [location_description] VARCHAR (MAX)    NULL,
    [location_name]        VARCHAR (MAX)    NULL,
    [location_name_short]  VARCHAR (MAX)    NULL,
    [site_id_number]       VARCHAR (MAX)    NULL,
    [DeltaLogKey]          INT              NOT NULL,
    [AuditKey]             INT              NOT NULL
);

