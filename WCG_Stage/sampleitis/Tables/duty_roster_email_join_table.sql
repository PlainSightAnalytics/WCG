CREATE TABLE [sampleitis].[duty_roster_email_join_table] (
    [id]                           UNIQUEIDENTIFIER NULL,
    [type]                         NVARCHAR (MAX)   NULL,
    [updated_at]                   NVARCHAR (MAX)   NULL,
    [display]                      NVARCHAR (MAX)   NULL,
    [duty_roster_email_request_id] UNIQUEIDENTIFIER NULL,
    [roster_id]                    UNIQUEIDENTIFIER NULL,
    [DeltaLogKey]                  INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                     INT              DEFAULT ((-1)) NOT NULL
);

