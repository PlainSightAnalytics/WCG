CREATE TABLE [sampleitis].[charge_code_subcategory] (
    [id]                      UNIQUEIDENTIFIER NULL,
    [type]                    NVARCHAR (MAX)   NULL,
    [updated_at]              NVARCHAR (MAX)   NULL,
    [display]                 NVARCHAR (MAX)   NULL,
    [charge_code_category_id] UNIQUEIDENTIFIER NULL,
    [name]                    VARCHAR (MAX)    NULL,
    [order_in_list]           VARCHAR (MAX)    NULL,
    [DeltaLogKey]             INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                INT              DEFAULT ((-1)) NOT NULL
);

