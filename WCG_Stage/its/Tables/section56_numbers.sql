CREATE TABLE [its].[section56_numbers] (
    [id]                   UNIQUEIDENTIFIER NULL,
    [type]                 NVARCHAR (MAX)   NULL,
    [updated_at]           NVARCHAR (MAX)   NULL,
    [display]              NVARCHAR (MAX)   NULL,
    [section56_numbers_id] UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]    UNIQUEIDENTIFIER NULL,
    [user_id]              UNIQUEIDENTIFIER NULL,
    [begin]                VARCHAR (MAX)    NULL,
    [complete_key]         VARCHAR (MAX)    NULL,
    [complete_display]     VARCHAR (MAX)    NULL,
    [end]                  VARCHAR (MAX)    NULL,
    [last_used]            VARCHAR (MAX)    NULL,
    [numbers_remaining]    VARCHAR (MAX)    NULL,
    [DeltaLogKey]          INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]          INT              DEFAULT ((-1)) NOT NULL
);

