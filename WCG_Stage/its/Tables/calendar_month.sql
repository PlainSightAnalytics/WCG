CREATE TABLE [its].[calendar_month] (
    [id]                              UNIQUEIDENTIFIER NULL,
    [type]                            NVARCHAR (MAX)   NULL,
    [updated_at]                      NVARCHAR (MAX)   NULL,
    [display]                         NVARCHAR (MAX)   NULL,
    [calendar_year_id]                UNIQUEIDENTIFIER NULL,
    [quaterly_verification_report_id] UNIQUEIDENTIFIER NULL,
    [name]                            VARCHAR (MAX)    NULL,
    [number]                          VARCHAR (MAX)    NULL,
    [sequence_number]                 VARCHAR (MAX)    NULL,
    [start_date_utc]                  VARCHAR (MAX)    NULL,
    [year]                            VARCHAR (MAX)    NULL,
    [DeltaLogKey]                     INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]                     INT              DEFAULT ((-1)) NOT NULL
);

