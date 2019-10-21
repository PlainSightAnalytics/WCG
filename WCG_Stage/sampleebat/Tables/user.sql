CREATE TABLE [sampleebat].[user] (
    [id]                    UNIQUEIDENTIFIER NULL,
    [type]                  NVARCHAR (MAX)   NULL,
    [updated_at]            NVARCHAR (MAX)   NULL,
    [display]               NVARCHAR (MAX)   NULL,
    [centre_id]             UNIQUEIDENTIFIER NULL,
    [latest_shift_id]       UNIQUEIDENTIFIER NULL,
    [ebat_operator_key]     VARCHAR (MAX)    NULL,
    [ebat_operator_display] VARCHAR (MAX)    NULL,
    [id_number]             VARCHAR (MAX)    NULL,
    [infrastructure_number] VARCHAR (MAX)    NULL,
    [name]                  VARCHAR (MAX)    NULL,
    [operator_certificate]  VARCHAR (MAX)    NULL,
    [password]              VARCHAR (MAX)    NULL,
    [role_key]              VARCHAR (MAX)    NULL,
    [role_display]          VARCHAR (MAX)    NULL,
    [surname]               VARCHAR (MAX)    NULL,
    [DeltaLogKey]           INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]              INT              DEFAULT ((-1)) NOT NULL
);

