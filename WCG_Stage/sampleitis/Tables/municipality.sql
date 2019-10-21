CREATE TABLE [sampleitis].[municipality] (
    [id]                 UNIQUEIDENTIFIER NULL,
    [type]               NVARCHAR (MAX)   NULL,
    [updated_at]         NVARCHAR (MAX)   NULL,
    [display]            NVARCHAR (MAX)   NULL,
    [district_id]        UNIQUEIDENTIFIER NULL,
    [electronic_payment] VARCHAR (MAX)    NULL,
    [name]               VARCHAR (MAX)    NULL,
    [place_of_payment]   VARCHAR (MAX)    NULL,
    [post_payment]       VARCHAR (MAX)    NULL,
    [DeltaLogKey]        INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]           INT              DEFAULT ((-1)) NOT NULL
);

