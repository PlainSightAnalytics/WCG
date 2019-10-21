CREATE TABLE [itis].[site] (
    [id]                               UNIQUEIDENTIFIER NULL,
    [type]                             NVARCHAR (MAX)   NULL,
    [updated_at]                       NVARCHAR (MAX)   NULL,
    [display]                          NVARCHAR (MAX)   NULL,
    [traffic_centre_id]                UNIQUEIDENTIFIER NULL,
    [gps_location_latitude]            VARCHAR (MAX)    NULL,
    [gps_location_longitude]           VARCHAR (MAX)    NULL,
    [gps_location_altitude]            VARCHAR (MAX)    NULL,
    [gps_location_horizontal_accuracy] VARCHAR (MAX)    NULL,
    [gps_location_vertical_accuracy]   VARCHAR (MAX)    NULL,
    [gps_location_timestamp]           VARCHAR (MAX)    NULL,
    [kilometer_distance]               VARCHAR (MAX)    NULL,
    [location_description]             VARCHAR (MAX)    NULL,
    [location_name]                    VARCHAR (MAX)    NULL,
    [location_name_short]              VARCHAR (MAX)    NULL,
    [location_type_key]                VARCHAR (MAX)    NULL,
    [location_type_display]            VARCHAR (MAX)    NULL,
    [road_number]                      VARCHAR (MAX)    NULL,
    [road_section]                     VARCHAR (MAX)    NULL,
    [DeltaLogKey]                      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                         INT              DEFAULT ((-1)) NOT NULL
);

