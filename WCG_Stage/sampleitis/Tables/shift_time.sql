CREATE TABLE [sampleitis].[shift_time] (
    [id]                UNIQUEIDENTIFIER NULL,
    [type]              NVARCHAR (MAX)   NULL,
    [updated_at]        NVARCHAR (MAX)   NULL,
    [display]           NVARCHAR (MAX)   NULL,
    [traffic_centre_id] UNIQUEIDENTIFIER NULL,
    [end_time]          VARCHAR (MAX)    NULL,
    [index]             VARCHAR (MAX)    NULL,
    [off_duty_key]      VARCHAR (MAX)    NULL,
    [off_duty_display]  VARCHAR (MAX)    NULL,
    [start_time]        VARCHAR (MAX)    NULL,
    [DeltaLogKey]       INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]          INT              DEFAULT ((-1)) NOT NULL
);

