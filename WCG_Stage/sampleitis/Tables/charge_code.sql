CREATE TABLE [sampleitis].[charge_code] (
    [id]                         UNIQUEIDENTIFIER NULL,
    [type]                       NVARCHAR (MAX)   NULL,
    [updated_at]                 NVARCHAR (MAX)   NULL,
    [display]                    NVARCHAR (MAX)   NULL,
    [charge_code_category_id]    UNIQUEIDENTIFIER NULL,
    [charge_code_subcategory_id] UNIQUEIDENTIFIER NULL,
    [ag_key]                     VARCHAR (MAX)    NULL,
    [ag_display]                 VARCHAR (MAX)    NULL,
    [alternative_charge_code]    VARCHAR (MAX)    NULL,
    [amount]                     VARCHAR (MAX)    NULL,
    [charge_code]                VARCHAR (MAX)    NULL,
    [charge_short_text]          VARCHAR (MAX)    NULL,
    [charge_text]                VARCHAR (MAX)    NULL,
    [prdp_key]                   VARCHAR (MAX)    NULL,
    [prdp_display]               VARCHAR (MAX)    NULL,
    [regulation_number]          VARCHAR (MAX)    NULL,
    [reporting_category]         VARCHAR (MAX)    NULL,
    [reporting_subcategory]      VARCHAR (MAX)    NULL,
    [DeltaLogKey]                INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                   INT              DEFAULT ((-1)) NOT NULL
);

