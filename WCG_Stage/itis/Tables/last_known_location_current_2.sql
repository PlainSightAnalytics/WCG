﻿CREATE TABLE [itis].[last_known_location_current] (
    [id]                         UNIQUEIDENTIFIER NULL,
    [type]                       NVARCHAR (MAX)   NULL,
    [updated_at]                 NVARCHAR (MAX)   NULL,
    [display]                    NVARCHAR (MAX)   NULL,
    [device_id]                  UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]          UNIQUEIDENTIFIER NULL,
    [user_id]                    UNIQUEIDENTIFIER NULL,
    [device_name]                VARCHAR (MAX)    NULL,
    [device_number]              VARCHAR (MAX)    NULL,
    [latitude]                   VARCHAR (MAX)    NULL,
    [longitude]                  VARCHAR (MAX)    NULL,
    [sent_on]                    VARCHAR (MAX)    NULL,
    [status_key]                 VARCHAR (MAX)    NULL,
    [status_display]             VARCHAR (MAX)    NULL,
    [traffic_centre_name]        VARCHAR (MAX)    NULL,
    [user_event_date]            VARCHAR (MAX)    NULL,
    [user_event_id]              VARCHAR (MAX)    NULL,
    [user_event_information]     VARCHAR (MAX)    NULL,
    [user_event_source]          VARCHAR (MAX)    NULL,
    [user_event_subtype]         VARCHAR (MAX)    NULL,
    [user_event_type]            VARCHAR (MAX)    NULL,
    [user_infrastructure_number] VARCHAR (MAX)    NULL,
    [user_name]                  VARCHAR (MAX)    NULL,
    [user_rank]                  VARCHAR (MAX)    NULL,
    [user_surname]               VARCHAR (MAX)    NULL,
    [DeltaLogKey]                INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                   INT              DEFAULT ((-1)) NOT NULL
);

