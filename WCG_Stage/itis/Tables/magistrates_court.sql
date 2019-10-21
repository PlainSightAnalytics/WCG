CREATE TABLE [itis].[magistrates_court] (
    [id]              UNIQUEIDENTIFIER NULL,
    [type]            VARCHAR (MAX)    NULL,
    [updated_at]      VARCHAR (MAX)    NULL,
    [display]         VARCHAR (MAX)    NULL,
    [municipality_id] UNIQUEIDENTIFIER NULL,
    [code]            VARCHAR (MAX)    NULL,
    [name]            VARCHAR (MAX)    NULL,
    [number]          VARCHAR (MAX)    NULL,
    [DeltaLogKey]     INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]        INT              DEFAULT ((-1)) NOT NULL
);

