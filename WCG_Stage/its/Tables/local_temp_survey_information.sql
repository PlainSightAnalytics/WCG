CREATE TABLE [its].[local_temp_survey_information] (
    [id]                          UNIQUEIDENTIFIER NULL,
    [type]                        NVARCHAR (MAX)   NULL,
    [updated_at]                  NVARCHAR (MAX)   NULL,
    [display]                     NVARCHAR (MAX)   NULL,
    [elapsed_time]                VARCHAR (MAX)    NULL,
    [recommended_travel_distance] VARCHAR (MAX)    NULL,
    [recommended_travel_duration] VARCHAR (MAX)    NULL,
    [DeltaLogKey]                 INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]                 INT              DEFAULT ((-1)) NOT NULL
);

