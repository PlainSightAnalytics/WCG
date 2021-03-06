﻿CREATE TABLE [itis].[operation] (
    [id]                           UNIQUEIDENTIFIER NULL,
    [type]                         NVARCHAR (MAX)   NULL,
    [updated_at]                   NVARCHAR (MAX)   NULL,
    [display]                      NVARCHAR (MAX)   NULL,
    [asod_road_section_id]         UNIQUEIDENTIFIER NULL,
    [briefing_done_by_id]          UNIQUEIDENTIFIER NULL,
    [debriefing_done_by_id]        UNIQUEIDENTIFIER NULL,
    [location_id]                  UNIQUEIDENTIFIER NULL,
    [operational_officer_id]       UNIQUEIDENTIFIER NULL,
    [planner_id]                   UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]            UNIQUEIDENTIFIER NULL,
    [vehicle_used_id]              UNIQUEIDENTIFIER NULL,
    [actual_operation_start_time]  VARCHAR (MAX)    NULL,
    [actual_operation_stop_time]   VARCHAR (MAX)    NULL,
    [approval_comment]             VARCHAR (MAX)    NULL,
    [approval_date]                VARCHAR (MAX)    NULL,
    [archived_key]                 VARCHAR (MAX)    NULL,
    [archived_display]             VARCHAR (MAX)    NULL,
    [asod_road_sections_text]      VARCHAR (MAX)    NULL,
    [authorization_comment]        VARCHAR (MAX)    NULL,
    [authorization_date]           VARCHAR (MAX)    NULL,
    [close_local_ob_number]        VARCHAR (MAX)    NULL,
    [compeltion_report]            VARCHAR (MAX)    NULL,
    [compeltion_report_photo]      VARCHAR (MAX)    NULL,
    [completion_comment]           VARCHAR (MAX)    NULL,
    [date_created]                 VARCHAR (MAX)    NULL,
    [description]                  VARCHAR (MAX)    NULL,
    [dsp_operation_key]            VARCHAR (MAX)    NULL,
    [dsp_operation_display]        VARCHAR (MAX)    NULL,
    [equipment_serial_number]      VARCHAR (MAX)    NULL,
    [general_type_key]             VARCHAR (MAX)    NULL,
    [general_type_display]         VARCHAR (MAX)    NULL,
    [has_non_object_location]      VARCHAR (MAX)    NULL,
    [last_updated]                 VARCHAR (MAX)    NULL,
    [location_object_names]        VARCHAR (MAX)    NULL,
    [open_local_ob_number]         VARCHAR (MAX)    NULL,
    [operation_document]           VARCHAR (MAX)    NULL,
    [other_location]               VARCHAR (MAX)    NULL,
    [reason_for_cancelation]       VARCHAR (MAX)    NULL,
    [roadblock_type_key]           VARCHAR (MAX)    NULL,
    [roadblock_type_display]       VARCHAR (MAX)    NULL,
    [rtqs_key]                     VARCHAR (MAX)    NULL,
    [rtqs_display]                 VARCHAR (MAX)    NULL,
    [speed_operation_type_key]     VARCHAR (MAX)    NULL,
    [speed_operation_type_display] VARCHAR (MAX)    NULL,
    [start_time]                   VARCHAR (MAX)    NULL,
    [status_key]                   VARCHAR (MAX)    NULL,
    [status_display]               VARCHAR (MAX)    NULL,
    [stop_time]                    VARCHAR (MAX)    NULL,
    [weigh_operation_type_key]     VARCHAR (MAX)    NULL,
    [weigh_operation_type_display] VARCHAR (MAX)    NULL,
    [DeltaLogKey]                  INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                     INT              DEFAULT ((-1)) NOT NULL
);



