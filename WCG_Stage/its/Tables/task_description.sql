CREATE TABLE [its].[task_description] (
    [id]                UNIQUEIDENTIFIER NULL,
    [type]              NVARCHAR (MAX)   NULL,
    [updated_at]        NVARCHAR (MAX)   NULL,
    [display]           NVARCHAR (MAX)   NULL,
    [description]       VARCHAR (MAX)    NULL,
    [measure]           VARCHAR (MAX)    NULL,
    [period]            VARCHAR (MAX)    NULL,
    [task_type_key]     VARCHAR (MAX)    NULL,
    [task_type_display] VARCHAR (MAX)    NULL,
    [unit]              VARCHAR (MAX)    NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]       INT              DEFAULT ((-1)) NOT NULL
);

