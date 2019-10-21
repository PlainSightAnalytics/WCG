CREATE TABLE [its].[app_log] (
    [id]                  UNIQUEIDENTIFIER NULL,
    [type]                NVARCHAR (MAX)   NULL,
    [updated_at]          NVARCHAR (MAX)   NULL,
    [display]             NVARCHAR (MAX)   NULL,
    [alert_id]            UNIQUEIDENTIFIER NULL,
    [device_id]           UNIQUEIDENTIFIER NULL,
    [driver_id]           UNIQUEIDENTIFIER NULL,
    [event_id]            UNIQUEIDENTIFIER NULL,
    [operational_area_id] UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]   UNIQUEIDENTIFIER NULL,
    [user_id]             UNIQUEIDENTIFIER NULL,
    [vehicle_id]          UNIQUEIDENTIFIER NULL,
    [description]         VARCHAR (MAX)    NULL,
    [log]                 VARCHAR (MAX)    NULL,
    [timestamp]           VARCHAR (MAX)    NULL,
    [DeltaLogKey]         INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]         INT              DEFAULT ((-1)) NOT NULL
);

