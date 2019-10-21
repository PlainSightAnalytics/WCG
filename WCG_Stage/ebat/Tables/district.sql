CREATE TABLE [ebat].[district] (
    [id]          UNIQUEIDENTIFIER NULL,
    [type]        VARCHAR (MAX)    NULL,
    [updated_at]  VARCHAR (MAX)    NULL,
    [display]     VARCHAR (MAX)    NULL,
    [province_id] UNIQUEIDENTIFIER NULL,
    [name]        VARCHAR (MAX)    NULL,
    [DeltaLogKey] INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]    INT              DEFAULT ((-1)) NOT NULL
);

