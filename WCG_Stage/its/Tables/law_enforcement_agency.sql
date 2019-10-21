CREATE TABLE [its].[law_enforcement_agency] (
    [id]                          UNIQUEIDENTIFIER NULL,
    [type]                        NVARCHAR (MAX)   NULL,
    [updated_at]                  NVARCHAR (MAX)   NULL,
    [display]                     NVARCHAR (MAX)   NULL,
    [operation_id]                UNIQUEIDENTIFIER NULL,
    [archived_key]                VARCHAR (MAX)    NULL,
    [archived_display]            VARCHAR (MAX)    NULL,
    [contact_number]              VARCHAR (MAX)    NULL,
    [enforcement_type_key]        VARCHAR (MAX)    NULL,
    [enforcement_type_display]    VARCHAR (MAX)    NULL,
    [operation_cancelled_key]     VARCHAR (MAX)    NULL,
    [operation_cancelled_display] VARCHAR (MAX)    NULL,
    [person_name_and_surname]     VARCHAR (MAX)    NULL,
    [staff_allocated]             VARCHAR (MAX)    NULL,
    [staff_reported]              VARCHAR (MAX)    NULL,
    [DeltaLogKey]                 INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]                 INT              DEFAULT ((-1)) NOT NULL
);

