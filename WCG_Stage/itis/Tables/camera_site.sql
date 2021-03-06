﻿CREATE TABLE [itis].[camera_site] (
    [id]                   UNIQUEIDENTIFIER NULL,
    [type]                 NVARCHAR (MAX)   NULL,
    [updated_at]           NVARCHAR (MAX)   NULL,
    [display]              NVARCHAR (MAX)   NULL,
    [operational_area_id]  UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]    UNIQUEIDENTIFIER NULL,
    [asod_key]             VARCHAR (MAX)    NULL,
    [asod_display]         VARCHAR (MAX)    NULL,
    [camera_id_number]     VARCHAR (MAX)    NULL,
    [camera_type_key]      VARCHAR (MAX)    NULL,
    [camera_type_display]  VARCHAR (MAX)    NULL,
    [direction_key]        VARCHAR (MAX)    NULL,
    [direction_display]    VARCHAR (MAX)    NULL,
    [lane_id_number]       VARCHAR (MAX)    NULL,
    [location]             VARCHAR (MAX)    NULL,
    [location_description] VARCHAR (MAX)    NULL,
    [location_name]        VARCHAR (MAX)    NULL,
    [location_name_short]  VARCHAR (MAX)    NULL,
    [report_key]           VARCHAR (MAX)    NULL,
    [report_display]       VARCHAR (MAX)    NULL,
    [site_id_number]       VARCHAR (MAX)    NULL,
    [DeltaLogKey]          INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]             INT              DEFAULT ((-1)) NOT NULL
);



