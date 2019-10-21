CREATE TABLE [its].[traffic_centre] (
    [id]                           UNIQUEIDENTIFIER NULL,
    [type]                         NVARCHAR (MAX)   NULL,
    [updated_at]                   NVARCHAR (MAX)   NULL,
    [display]                      NVARCHAR (MAX)   NULL,
    [current_section56_numbers_id] UNIQUEIDENTIFIER NULL,
    [magistrates_court_id]         UNIQUEIDENTIFIER NULL,
    [regional_area_id]             UNIQUEIDENTIFIER NULL,
    [email]                        VARCHAR (MAX)    NULL,
    [handle]                       VARCHAR (MAX)    NULL,
    [name]                         VARCHAR (MAX)    NULL,
    [power_bi_users]               VARCHAR (MAX)    NULL,
    [section_56_email]             VARCHAR (MAX)    NULL,
    [sect_56_begin]                VARCHAR (MAX)    NULL,
    [sect_56_end]                  VARCHAR (MAX)    NULL,
    [sect_56_last_used]            VARCHAR (MAX)    NULL,
    [telephone_number]             VARCHAR (MAX)    NULL,
    [DeltaLogKey]                  INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]                  INT              DEFAULT ((-1)) NOT NULL
);

