﻿CREATE TABLE [pnd].[impound] (
    [id]                    UNIQUEIDENTIFIER NULL,
    [type]                  NVARCHAR (MAX)   NULL,
    [updated_at]            NVARCHAR (MAX)   NULL,
    [display]               NVARCHAR (MAX)   NULL,
    [local_municipality_id] UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]     UNIQUEIDENTIFIER NULL,
    [handle]                VARCHAR (MAX)    NULL,
    [name]                  VARCHAR (MAX)    NULL,
    [DeltaLogKey]           INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]              INT              DEFAULT ((-1)) NOT NULL
);

