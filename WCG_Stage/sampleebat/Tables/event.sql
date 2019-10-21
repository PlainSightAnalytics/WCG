CREATE TABLE [sampleebat].[event] (
    [id]                               UNIQUEIDENTIFIER NULL,
    [type]                             NVARCHAR (MAX)   NULL,
    [updated_at]                       NVARCHAR (MAX)   NULL,
    [display]                          NVARCHAR (MAX)   NULL,
    [accepted_by_id]                   UNIQUEIDENTIFIER NULL,
    [ebat_device_id]                   UNIQUEIDENTIFIER NULL,
    [from_centre_id]                   UNIQUEIDENTIFIER NULL,
    [to_centre_id]                     UNIQUEIDENTIFIER NULL,
    [user_id]                          UNIQUEIDENTIFIER NULL,
    [description]                      VARCHAR (MAX)    NULL,
    [gps_location_latitude]            VARCHAR (MAX)    NULL,
    [gps_location_longitude]           VARCHAR (MAX)    NULL,
    [gps_location_altitude]            VARCHAR (MAX)    NULL,
    [gps_location_horizontal_accuracy] VARCHAR (MAX)    NULL,
    [gps_location_vertical_accuracy]   VARCHAR (MAX)    NULL,
    [gps_location_timestamp]           VARCHAR (MAX)    NULL,
    [second_signature]                 VARCHAR (MAX)    NULL,
    [signature]                        VARCHAR (MAX)    NULL,
    [timestamp]                        VARCHAR (MAX)    NULL,
    [DeltaLogKey]                      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                         INT              DEFAULT ((-1)) NOT NULL
);

