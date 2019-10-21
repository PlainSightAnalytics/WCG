CREATE TABLE [pnd].[violation] (
    [id]                     UNIQUEIDENTIFIER NULL,
    [type]                   NVARCHAR (MAX)   NULL,
    [updated_at]             NVARCHAR (MAX)   NULL,
    [display]                NVARCHAR (MAX)   NULL,
    [impound_instruction_id] UNIQUEIDENTIFIER NULL,
    [archived_key]           VARCHAR (MAX)    NULL,
    [archived_display]       VARCHAR (MAX)    NULL,
    [created_at]             VARCHAR (MAX)    NULL,
    [description]            VARCHAR (MAX)    NULL,
    [section_details]        VARCHAR (MAX)    NULL,
    [violation_code]         VARCHAR (MAX)    NULL,
    [violation_type_key]     VARCHAR (MAX)    NULL,
    [violation_type_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]            INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]               INT              DEFAULT ((-1)) NOT NULL
);

