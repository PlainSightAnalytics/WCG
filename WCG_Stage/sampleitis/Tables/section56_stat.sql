CREATE TABLE [sampleitis].[section56_stat] (
    [id]                   UNIQUEIDENTIFIER NULL,
    [type]                 NVARCHAR (MAX)   NULL,
    [updated_at]           NVARCHAR (MAX)   NULL,
    [display]              NVARCHAR (MAX)   NULL,
    [event_id]             UNIQUEIDENTIFIER NULL,
    [section56_form_id]    UNIQUEIDENTIFIER NULL,
    [shift_statistic_id]   UNIQUEIDENTIFIER NULL,
    [user_id]              UNIQUEIDENTIFIER NULL,
    [charge_code]          VARCHAR (MAX)    NULL,
    [charge_code_2]        VARCHAR (MAX)    NULL,
    [charge_code_3]        VARCHAR (MAX)    NULL,
    [number]               VARCHAR (MAX)    NULL,
    [vehicle_type_key]     VARCHAR (MAX)    NULL,
    [vehicle_type_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]          INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]             INT              DEFAULT ((-1)) NOT NULL
);

