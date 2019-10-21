CREATE TABLE [sampleebat].[cas_year_local] (
    [id]          UNIQUEIDENTIFIER NULL,
    [type]        NVARCHAR (MAX)   NULL,
    [updated_at]  NVARCHAR (MAX)   NULL,
    [display]     NVARCHAR (MAX)   NULL,
    [year]        VARCHAR (MAX)    NULL,
    [DeltaLogKey] INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]    INT              DEFAULT ((-1)) NOT NULL
);

