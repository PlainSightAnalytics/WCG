CREATE TABLE [sampleitis].[report_event] (
    [id]                          UNIQUEIDENTIFIER NULL,
    [type]                        NVARCHAR (MAX)   NULL,
    [updated_at]                  NVARCHAR (MAX)   NULL,
    [display]                     NVARCHAR (MAX)   NULL,
    [event_id]                    UNIQUEIDENTIFIER NULL,
    [primary_driver_id]           UNIQUEIDENTIFIER NULL,
    [primary_vehicle_id]          UNIQUEIDENTIFIER NULL,
    [tle006_request_id]           UNIQUEIDENTIFIER NULL,
    [alcohol_level]               VARCHAR (MAX)    NULL,
    [alcohol_screening]           VARCHAR (MAX)    NULL,
    [id_number]                   VARCHAR (MAX)    NULL,
    [time]                        VARCHAR (MAX)    NULL,
    [vehicle_registration_number] VARCHAR (MAX)    NULL,
    [vehicle_type_key]            VARCHAR (MAX)    NULL,
    [vehicle_type_display]        VARCHAR (MAX)    NULL,
    [DeltaLogKey]                 INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                    INT              DEFAULT ((-1)) NOT NULL
);

