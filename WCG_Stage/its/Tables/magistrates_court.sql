CREATE TABLE [its].[magistrates_court] (
    [id]                 UNIQUEIDENTIFIER NULL,
    [type]               NVARCHAR (MAX)   NULL,
    [updated_at]         NVARCHAR (MAX)   NULL,
    [display]            NVARCHAR (MAX)   NULL,
    [municipality_id]    UNIQUEIDENTIFIER NULL,
    [code]               VARCHAR (MAX)    NULL,
    [electronic_payment] VARCHAR (MAX)    NULL,
    [name]               VARCHAR (MAX)    NULL,
    [number]             VARCHAR (MAX)    NULL,
    [place_of_payment]   VARCHAR (MAX)    NULL,
    [post_payment]       VARCHAR (MAX)    NULL,
    [DeltaLogKey]        INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]        INT              DEFAULT ((-1)) NOT NULL
);

