CREATE TABLE [sampleebat].[regional_area] (
    [id]           UNIQUEIDENTIFIER NULL,
    [type]         NVARCHAR (MAX)   NULL,
    [updated_at]   NVARCHAR (MAX)   NULL,
    [display]      NVARCHAR (MAX)   NULL,
    [authority_id] UNIQUEIDENTIFIER NULL,
    [name]         VARCHAR (MAX)    NULL,
    [DeltaLogKey]  INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]     INT              DEFAULT ((-1)) NOT NULL
);

