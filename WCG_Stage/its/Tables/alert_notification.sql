﻿CREATE TABLE [its].[alert_notification] (
    [id]             UNIQUEIDENTIFIER NULL,
    [type]           NVARCHAR (MAX)   NULL,
    [updated_at]     NVARCHAR (MAX)   NULL,
    [display]        NVARCHAR (MAX)   NULL,
    [alert_id]       UNIQUEIDENTIFIER NULL,
    [device_id]      UNIQUEIDENTIFIER NULL,
    [message]        VARCHAR (MAX)    NULL,
    [status_key]     VARCHAR (MAX)    NULL,
    [status_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]    INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]    INT              DEFAULT ((-1)) NOT NULL
);
