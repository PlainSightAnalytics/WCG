CREATE TABLE [its].[public_vehicle] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [archived_key]     VARCHAR (MAX)    NULL,
    [archived_display] VARCHAR (MAX)    NULL,
    [capacity]         VARCHAR (MAX)    NULL,
    [chassis_no]       VARCHAR (MAX)    NULL,
    [created_at]       VARCHAR (MAX)    NULL,
    [id_number]        VARCHAR (MAX)    NULL,
    [id_type]          VARCHAR (MAX)    NULL,
    [make]             VARCHAR (MAX)    NULL,
    [name]             VARCHAR (MAX)    NULL,
    [operator_no]      VARCHAR (MAX)    NULL,
    [registration_no]  VARCHAR (MAX)    NULL,
    [status]           VARCHAR (MAX)    NULL,
    [trade_name]       VARCHAR (MAX)    NULL,
    [vehicle_type]     VARCHAR (MAX)    NULL,
    [year]             VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]      INT              DEFAULT ((-1)) NOT NULL
);

