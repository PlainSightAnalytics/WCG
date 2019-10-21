CREATE TABLE [its].[prdp_error_data] (
    [id]                                UNIQUEIDENTIFIER NULL,
    [type]                              NVARCHAR (MAX)   NULL,
    [updated_at]                        NVARCHAR (MAX)   NULL,
    [display]                           NVARCHAR (MAX)   NULL,
    [event_id]                          UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]                 UNIQUEIDENTIFIER NULL,
    [user_id]                           UNIQUEIDENTIFIER NULL,
    [datetime_error_occured]            VARCHAR (MAX)    NULL,
    [decoded_data]                      VARCHAR (MAX)    NULL,
    [error_caught]                      VARCHAR (MAX)    NULL,
    [prdp_code_captured]                VARCHAR (MAX)    NULL,
    [prdp_expiry_date_captured]         VARCHAR (MAX)    NULL,
    [professional_driving_permit_codes] VARCHAR (MAX)    NULL,
    [DeltaLogKey]                       INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]                       INT              DEFAULT ((-1)) NOT NULL
);

