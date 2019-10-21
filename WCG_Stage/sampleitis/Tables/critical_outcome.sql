﻿CREATE TABLE [sampleitis].[critical_outcome] (
    [id]                               UNIQUEIDENTIFIER NULL,
    [type]                             NVARCHAR (MAX)   NULL,
    [updated_at]                       NVARCHAR (MAX)   NULL,
    [display]                          NVARCHAR (MAX)   NULL,
    [shift_statistic_id]               UNIQUEIDENTIFIER NULL,
    [bus_stopped]                      VARCHAR (MAX)    NULL,
    [description]                      VARCHAR (MAX)    NULL,
    [hmv_stopped]                      VARCHAR (MAX)    NULL,
    [ldv_stopped]                      VARCHAR (MAX)    NULL,
    [lmv_stopped]                      VARCHAR (MAX)    NULL,
    [midibus_stopped]                  VARCHAR (MAX)    NULL,
    [minibus_stopped]                  VARCHAR (MAX)    NULL,
    [motorcycle_stopped]               VARCHAR (MAX)    NULL,
    [mpv_stopped]                      VARCHAR (MAX)    NULL,
    [order]                            VARCHAR (MAX)    NULL,
    [other_stopped]                    VARCHAR (MAX)    NULL,
    [outcome_type_key]                 VARCHAR (MAX)    NULL,
    [outcome_type_display]             VARCHAR (MAX)    NULL,
    [started_filling_in_key]           VARCHAR (MAX)    NULL,
    [started_filling_in_display]       VARCHAR (MAX)    NULL,
    [system_populated_outcome_key]     VARCHAR (MAX)    NULL,
    [system_populated_outcome_display] VARCHAR (MAX)    NULL,
    [taxi_stopped]                     VARCHAR (MAX)    NULL,
    [DeltaLogKey]                      INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                         INT              DEFAULT ((-1)) NOT NULL
);

