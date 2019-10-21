﻿CREATE TABLE [its].[alert] (
    [id]                                  UNIQUEIDENTIFIER NULL,
    [type]                                NVARCHAR (MAX)   NULL,
    [updated_at]                          NVARCHAR (MAX)   NULL,
    [display]                             NVARCHAR (MAX)   NULL,
    [asod_road_section_id]                UNIQUEIDENTIFIER NULL,
    [assigned_user_id]                    UNIQUEIDENTIFIER NULL,
    [camera_site_id]                      UNIQUEIDENTIFIER NULL,
    [control_room_selector_id]            UNIQUEIDENTIFIER NULL,
    [control_room_user_id]                UNIQUEIDENTIFIER NULL,
    [event_id]                            UNIQUEIDENTIFIER NULL,
    [operational_area_id]                 UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]                   UNIQUEIDENTIFIER NULL,
    [alert_id]                            VARCHAR (MAX)    NULL,
    [alert_status]                        VARCHAR (MAX)    NULL,
    [alert_status_description]            VARCHAR (MAX)    NULL,
    [alert_sub_type]                      VARCHAR (MAX)    NULL,
    [alert_sub_type_code]                 VARCHAR (MAX)    NULL,
    [alert_type]                          VARCHAR (MAX)    NULL,
    [alert_type_id_key]                   VARCHAR (MAX)    NULL,
    [alert_type_id_display]               VARCHAR (MAX)    NULL,
    [alert_type_id_short_key]             VARCHAR (MAX)    NULL,
    [alert_type_id_short_display]         VARCHAR (MAX)    NULL,
    [average_kmh]                         VARCHAR (MAX)    NULL,
    [comments_notes]                      VARCHAR (MAX)    NULL,
    [control_room_assigned_key]           VARCHAR (MAX)    NULL,
    [control_room_assigned_display]       VARCHAR (MAX)    NULL,
    [corrected_vrm]                       VARCHAR (MAX)    NULL,
    [correction_primary_reason_key]       VARCHAR (MAX)    NULL,
    [correction_primary_reason_display]   VARCHAR (MAX)    NULL,
    [correction_primary_reason_other]     VARCHAR (MAX)    NULL,
    [correction_secondary_reason_key]     VARCHAR (MAX)    NULL,
    [correction_secondary_reason_display] VARCHAR (MAX)    NULL,
    [correction_secondary_reason_other]   VARCHAR (MAX)    NULL,
    [device_id]                           VARCHAR (MAX)    NULL,
    [dismiss_reason_key]                  VARCHAR (MAX)    NULL,
    [dismiss_reason_display]              VARCHAR (MAX)    NULL,
    [dismiss_reason_other]                VARCHAR (MAX)    NULL,
    [images_cleared_key]                  VARCHAR (MAX)    NULL,
    [images_cleared_display]              VARCHAR (MAX)    NULL,
    [journey_status_key]                  VARCHAR (MAX)    NULL,
    [journey_status_display]              VARCHAR (MAX)    NULL,
    [lane]                                VARCHAR (MAX)    NULL,
    [lane_direction]                      VARCHAR (MAX)    NULL,
    [latittude]                           VARCHAR (MAX)    NULL,
    [license_number]                      VARCHAR (MAX)    NULL,
    [location_name]                       VARCHAR (MAX)    NULL,
    [location_name_short]                 VARCHAR (MAX)    NULL,
    [longitude]                           VARCHAR (MAX)    NULL,
    [previous_license_number]             VARCHAR (MAX)    NULL,
    [primary_ir_image]                    VARCHAR (MAX)    NULL,
    [primary_overview_image]              VARCHAR (MAX)    NULL,
    [primary_sighting_id]                 VARCHAR (MAX)    NULL,
    [primary_sighting_site_name]          VARCHAR (MAX)    NULL,
    [primary_timestamp]                   VARCHAR (MAX)    NULL,
    [primary_vrm]                         VARCHAR (MAX)    NULL,
    [priority_key]                        VARCHAR (MAX)    NULL,
    [priority_display]                    VARCHAR (MAX)    NULL,
    [processed_and_routed_key]            VARCHAR (MAX)    NULL,
    [processed_and_routed_display]        VARCHAR (MAX)    NULL,
    [reject_reason_key]                   VARCHAR (MAX)    NULL,
    [reject_reason_display]               VARCHAR (MAX)    NULL,
    [reject_reason_other]                 VARCHAR (MAX)    NULL,
    [road_section]                        VARCHAR (MAX)    NULL,
    [secondary_ir_image]                  VARCHAR (MAX)    NULL,
    [secondary_overview_image]            VARCHAR (MAX)    NULL,
    [secondary_sighting_id]               VARCHAR (MAX)    NULL,
    [secondary_sighting_site_name]        VARCHAR (MAX)    NULL,
    [secondary_timestamp]                 VARCHAR (MAX)    NULL,
    [secondary_vrm]                       VARCHAR (MAX)    NULL,
    [sighting_id]                         VARCHAR (MAX)    NULL,
    [source_system_id]                    VARCHAR (MAX)    NULL,
    [speed_class]                         VARCHAR (MAX)    NULL,
    [speed_class_code]                    VARCHAR (MAX)    NULL,
    [speed_limit]                         VARCHAR (MAX)    NULL,
    [timestamp]                           VARCHAR (MAX)    NULL,
    [time_string]                         VARCHAR (MAX)    NULL,
    [traffic_centre_name]                 VARCHAR (MAX)    NULL,
    [user_id]                             VARCHAR (MAX)    NULL,
    [vehicle_category]                    VARCHAR (MAX)    NULL,
    [vehicle_category_code]               VARCHAR (MAX)    NULL,
    [vehicle_colour]                      VARCHAR (MAX)    NULL,
    [vehicle_colour_code]                 VARCHAR (MAX)    NULL,
    [vehicle_direction]                   VARCHAR (MAX)    NULL,
    [vehicle_make]                        VARCHAR (MAX)    NULL,
    [vehicle_make_code]                   VARCHAR (MAX)    NULL,
    [vehicle_model]                       VARCHAR (MAX)    NULL,
    [vehicle_model_code]                  VARCHAR (MAX)    NULL,
    [vehicle_usage]                       VARCHAR (MAX)    NULL,
    [vehicle_usage_code]                  VARCHAR (MAX)    NULL,
    [vrm]                                 VARCHAR (MAX)    NULL,
    [DeltaLogKey]                         INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]                         INT              DEFAULT ((-1)) NOT NULL
);
