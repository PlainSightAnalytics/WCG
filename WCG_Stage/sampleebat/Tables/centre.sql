CREATE TABLE [sampleebat].[centre] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [municipality_id]  UNIQUEIDENTIFIER NULL,
    [regional_area_id] UNIQUEIDENTIFIER NULL,
    [email]            VARCHAR (MAX)    NULL,
    [name]             VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]         INT              DEFAULT ((-1)) NOT NULL
);

