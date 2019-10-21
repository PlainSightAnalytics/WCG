CREATE TABLE [pnd].[traffic_centre] (
    [id]               UNIQUEIDENTIFIER NULL,
    [type]             NVARCHAR (MAX)   NULL,
    [updated_at]       NVARCHAR (MAX)   NULL,
    [display]          NVARCHAR (MAX)   NULL,
    [email]            VARCHAR (MAX)    NULL,
    [handle]           VARCHAR (MAX)    NULL,
    [name]             VARCHAR (MAX)    NULL,
    [section_56_email] VARCHAR (MAX)    NULL,
    [telephone_number] VARCHAR (MAX)    NULL,
    [DeltaLogKey]      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]         INT              DEFAULT ((-1)) NOT NULL
);

