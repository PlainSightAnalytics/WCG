﻿CREATE TABLE [sampleitis].[shift_week] (
    [id]                        UNIQUEIDENTIFIER NULL,
    [type]                      NVARCHAR (MAX)   NULL,
    [updated_at]                NVARCHAR (MAX)   NULL,
    [display]                   NVARCHAR (MAX)   NULL,
    [friday_master_shift_id]    UNIQUEIDENTIFIER NULL,
    [master_shift_id]           UNIQUEIDENTIFIER NULL,
    [master_shift_week_id]      UNIQUEIDENTIFIER NULL,
    [monday_master_shift_id]    UNIQUEIDENTIFIER NULL,
    [roster_id]                 UNIQUEIDENTIFIER NULL,
    [roster_week_id]            UNIQUEIDENTIFIER NULL,
    [saturday_master_shift_id]  UNIQUEIDENTIFIER NULL,
    [selected_shift_id]         UNIQUEIDENTIFIER NULL,
    [sunday_master_shift_id]    UNIQUEIDENTIFIER NULL,
    [thursday_master_shift_id]  UNIQUEIDENTIFIER NULL,
    [tuesday_master_shift_id]   UNIQUEIDENTIFIER NULL,
    [user_id]                   UNIQUEIDENTIFIER NULL,
    [wednesday_master_shift_id] UNIQUEIDENTIFIER NULL,
    [archived_key]              VARCHAR (MAX)    NULL,
    [archived_display]          VARCHAR (MAX)    NULL,
    [deleted_key]               VARCHAR (MAX)    NULL,
    [deleted_display]           VARCHAR (MAX)    NULL,
    [user_role_key]             VARCHAR (MAX)    NULL,
    [user_role_display]         VARCHAR (MAX)    NULL,
    [user_week_key]             VARCHAR (MAX)    NULL,
    [user_week_display]         VARCHAR (MAX)    NULL,
    [DeltaLogKey]               INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                  INT              DEFAULT ((-1)) NOT NULL
);

