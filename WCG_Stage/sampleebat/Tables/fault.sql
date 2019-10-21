CREATE TABLE [sampleebat].[fault] (
    [id]                 UNIQUEIDENTIFIER NULL,
    [type]               NVARCHAR (MAX)   NULL,
    [updated_at]         NVARCHAR (MAX)   NULL,
    [display]            NVARCHAR (MAX)   NULL,
    [ebat_device_id]     UNIQUEIDENTIFIER NULL,
    [user_id]            UNIQUEIDENTIFIER NULL,
    [fault_text]         VARCHAR (MAX)    NULL,
    [fault_type_key]     VARCHAR (MAX)    NULL,
    [fault_type_display] VARCHAR (MAX)    NULL,
    [timestamp]          VARCHAR (MAX)    NULL,
    [DeltaLogKey]        INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]           INT              DEFAULT ((-1)) NOT NULL
);

