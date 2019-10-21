CREATE TABLE [its].[settings] (
    [id]             UNIQUEIDENTIFIER NULL,
    [type]           NVARCHAR (MAX)   NULL,
    [updated_at]     NVARCHAR (MAX)   NULL,
    [display]        NVARCHAR (MAX)   NULL,
    [android_link]   VARCHAR (MAX)    NULL,
    [ios_link]       VARCHAR (MAX)    NULL,
    [latest_version] VARCHAR (MAX)    NULL,
    [windows_link]   VARCHAR (MAX)    NULL,
    [DeltaLogKey]    INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]    INT              DEFAULT ((-1)) NOT NULL
);

