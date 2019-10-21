CREATE TABLE [pnd].[release_criteria] (
    [id]                     UNIQUEIDENTIFIER NULL,
    [type]                   NVARCHAR (MAX)   NULL,
    [updated_at]             NVARCHAR (MAX)   NULL,
    [display]                NVARCHAR (MAX)   NULL,
    [impound_instruction_id] UNIQUEIDENTIFIER NULL,
    [amount_paid]            VARCHAR (MAX)    NULL,
    [archived_key]           VARCHAR (MAX)    NULL,
    [archived_display]       VARCHAR (MAX)    NULL,
    [created_at]             VARCHAR (MAX)    NULL,
    [description]            VARCHAR (MAX)    NULL,
    [details]                VARCHAR (MAX)    NULL,
    [status_key]             VARCHAR (MAX)    NULL,
    [status_display]         VARCHAR (MAX)    NULL,
    [DeltaLogKey]            INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]               INT              DEFAULT ((-1)) NOT NULL
);

