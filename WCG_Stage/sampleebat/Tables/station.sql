CREATE TABLE [sampleebat].[station] (
    [id]              UNIQUEIDENTIFIER NULL,
    [type]            NVARCHAR (MAX)   NULL,
    [updated_at]      NVARCHAR (MAX)   NULL,
    [display]         NVARCHAR (MAX)   NULL,
    [authority_id]    UNIQUEIDENTIFIER NULL,
    [municipality_id] UNIQUEIDENTIFIER NULL,
    [name]            VARCHAR (MAX)    NULL,
    [station_number]  VARCHAR (MAX)    NULL,
    [DeltaLogKey]     INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]        INT              DEFAULT ((-1)) NOT NULL
);

