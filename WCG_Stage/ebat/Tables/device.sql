CREATE TABLE [ebat].[device] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             VARCHAR (MAX)    NULL,
    [updated_at]       VARCHAR (MAX)    NULL,
    [display]          VARCHAR (MAX)    NULL,
    [centre_id]        UNIQUEIDENTIFIER NULL,
    [user_id]          UNIQUEIDENTIFIER NULL,
    [last_app_version] VARCHAR (MAX)    NULL,
    [mobile_number]    VARCHAR (MAX)    NULL,
    [name]             VARCHAR (MAX)    NULL,
    [serial_number]    VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]         INT              DEFAULT ((-1)) NOT NULL
);

