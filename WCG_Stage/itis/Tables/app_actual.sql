CREATE TABLE [itis].[app_actual] (
    [id]                 UNIQUEIDENTIFIER NULL,
    [type]               NVARCHAR (MAX)   NULL,
    [updated_at]         NVARCHAR (MAX)   NULL,
    [display]            NVARCHAR (MAX)   NULL,
    [app_target_id]      UNIQUEIDENTIFIER NULL,
    [calendar_month_id]  UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]  UNIQUEIDENTIFIER NULL,
    [adjusted_target]    VARCHAR (MAX)    NULL,
    [date_created]       VARCHAR (MAX)    NULL,
    [preliminary_actual] VARCHAR (MAX)    NULL,
    [target]             VARCHAR (MAX)    NULL,
    [tc_comment]         VARCHAR (MAX)    NULL,
    [verified_actual]    VARCHAR (MAX)    NULL,
    [verifier_comment]   VARCHAR (MAX)    NULL,
    [DeltaLogKey]        INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]           INT              DEFAULT ((-1)) NOT NULL
);

