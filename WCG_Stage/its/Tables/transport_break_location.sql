CREATE TABLE [its].[transport_break_location] (
    [id]              UNIQUEIDENTIFIER NULL,
    [type]            NVARCHAR (MAX)   NULL,
    [updated_at]      NVARCHAR (MAX)   NULL,
    [display]         NVARCHAR (MAX)   NULL,
    [municipality_id] UNIQUEIDENTIFIER NULL,
    [description]     VARCHAR (MAX)    NULL,
    [DeltaLogKey]     INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]     INT              DEFAULT ((-1)) NOT NULL
);

