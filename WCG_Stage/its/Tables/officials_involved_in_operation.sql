CREATE TABLE [its].[officials_involved_in_operation] (
    [id]                 UNIQUEIDENTIFIER NULL,
    [type]               NVARCHAR (MAX)   NULL,
    [updated_at]         NVARCHAR (MAX)   NULL,
    [display]            NVARCHAR (MAX)   NULL,
    [operation_id]       UNIQUEIDENTIFIER NULL,
    [user_id]            UNIQUEIDENTIFIER NULL,
    [is_vehicle_key]     VARCHAR (MAX)    NULL,
    [is_vehicle_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]        INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]        INT              DEFAULT ((-1)) NOT NULL
);

