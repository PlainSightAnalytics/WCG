CREATE TABLE [sampleebat].[device] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [centre_id]        UNIQUEIDENTIFIER NULL,
    [latest_shift_id]  UNIQUEIDENTIFIER NULL,
    [user_id]          UNIQUEIDENTIFIER NULL,
    [last_app_version] VARCHAR (MAX)    NULL,
    [mobile_number]    VARCHAR (MAX)    NULL,
    [name]             VARCHAR (MAX)    NULL,
    [role_key]         VARCHAR (MAX)    NULL,
    [role_display]     VARCHAR (MAX)    NULL,
    [serial_number]    VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]         INT              DEFAULT ((-1)) NOT NULL
);

