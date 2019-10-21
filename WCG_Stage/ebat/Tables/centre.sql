CREATE TABLE [ebat].[centre] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             VARCHAR (MAX)    NULL,
    [updated_at]       VARCHAR (MAX)    NULL,
    [display]          VARCHAR (MAX)    NULL,
    [municipality_id]  UNIQUEIDENTIFIER NULL,
    [regional_area_id] UNIQUEIDENTIFIER NULL,
    [email]            VARCHAR (MAX)    NULL,
    [name]             VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]         INT              DEFAULT ((-1)) NOT NULL
);

