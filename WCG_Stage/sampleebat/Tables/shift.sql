CREATE TABLE [sampleebat].[shift] (
    [id]                 UNIQUEIDENTIFIER NULL,
    [type]               NVARCHAR (MAX)   NULL,
    [updated_at]         NVARCHAR (MAX)   NULL,
    [display]            NVARCHAR (MAX)   NULL,
    [user_id]            UNIQUEIDENTIFIER NULL,
    [date]               VARCHAR (MAX)    NULL,
    [shift_time_key]     VARCHAR (MAX)    NULL,
    [shift_time_display] VARCHAR (MAX)    NULL,
    [testing_key]        VARCHAR (MAX)    NULL,
    [testing_display]    VARCHAR (MAX)    NULL,
    [DeltaLogKey]        INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]           INT              DEFAULT ((-1)) NOT NULL
);

