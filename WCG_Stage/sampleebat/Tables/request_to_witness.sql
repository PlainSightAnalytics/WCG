CREATE TABLE [sampleebat].[request_to_witness] (
    [id]              UNIQUEIDENTIFIER NULL,
    [type]            NVARCHAR (MAX)   NULL,
    [updated_at]      NVARCHAR (MAX)   NULL,
    [display]         NVARCHAR (MAX)   NULL,
    [court_detail_id] UNIQUEIDENTIFIER NULL,
    [ebat_report_id]  UNIQUEIDENTIFIER NULL,
    [operator_id]     UNIQUEIDENTIFIER NULL,
    [accused]         VARCHAR (MAX)    NULL,
    [cas_no]          VARCHAR (MAX)    NULL,
    [court]           VARCHAR (MAX)    NULL,
    [request_date]    VARCHAR (MAX)    NULL,
    [test_date]       VARCHAR (MAX)    NULL,
    [DeltaLogKey]     INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]        INT              DEFAULT ((-1)) NOT NULL
);

