CREATE TABLE [its].[charge_code_category] (
    [id]            UNIQUEIDENTIFIER NULL,
    [type]          NVARCHAR (MAX)   NULL,
    [updated_at]    NVARCHAR (MAX)   NULL,
    [display]       NVARCHAR (MAX)   NULL,
    [name]          VARCHAR (MAX)    NULL,
    [order_in_list] VARCHAR (MAX)    NULL,
    [DeltaLogKey]   INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]   INT              DEFAULT ((-1)) NOT NULL
);

