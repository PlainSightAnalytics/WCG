CREATE TABLE [its].[potential_violation] (
    [id]                             UNIQUEIDENTIFIER NULL,
    [type]                           NVARCHAR (MAX)   NULL,
    [updated_at]                     NVARCHAR (MAX)   NULL,
    [display]                        NVARCHAR (MAX)   NULL,
    [alert_id]                       UNIQUEIDENTIFIER NULL,
    [driver_id]                      UNIQUEIDENTIFIER NULL,
    [event_id]                       UNIQUEIDENTIFIER NULL,
    [vehicle_id]                     UNIQUEIDENTIFIER NULL,
    [action_key]                     VARCHAR (MAX)    NULL,
    [action_display]                 VARCHAR (MAX)    NULL,
    [actioned_key]                   VARCHAR (MAX)    NULL,
    [actioned_display]               VARCHAR (MAX)    NULL,
    [converted_to_violation_key]     VARCHAR (MAX)    NULL,
    [converted_to_violation_display] VARCHAR (MAX)    NULL,
    [description]                    VARCHAR (MAX)    NULL,
    [reason]                         VARCHAR (MAX)    NULL,
    [time_added]                     VARCHAR (MAX)    NULL,
    [DeltaLogKey]                    INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]                    INT              DEFAULT ((-1)) NOT NULL
);

