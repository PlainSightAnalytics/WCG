﻿CREATE TABLE [itis].[province] (
    [id]          UNIQUEIDENTIFIER NULL,
    [type]        VARCHAR (MAX)    NULL,
    [updated_at]  VARCHAR (MAX)    NULL,
    [display]     VARCHAR (MAX)    NULL,
    [name]        VARCHAR (MAX)    NULL,
    [DeltaLogKey] INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]    INT              DEFAULT ((-1)) NOT NULL
);

