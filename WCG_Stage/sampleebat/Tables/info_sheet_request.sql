﻿CREATE TABLE [sampleebat].[info_sheet_request] (
    [id]             UNIQUEIDENTIFIER NULL,
    [type]           NVARCHAR (MAX)   NULL,
    [updated_at]     NVARCHAR (MAX)   NULL,
    [display]        NVARCHAR (MAX)   NULL,
    [ebat_report_id] UNIQUEIDENTIFIER NULL,
    [user_id]        UNIQUEIDENTIFIER NULL,
    [created_at]     VARCHAR (MAX)    NULL,
    [email]          VARCHAR (MAX)    NULL,
    [status_key]     VARCHAR (MAX)    NULL,
    [status_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]    INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]       INT              DEFAULT ((-1)) NOT NULL
);
