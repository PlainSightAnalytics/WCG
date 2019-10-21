﻿CREATE TABLE [its].[device] (
    [id]                                      UNIQUEIDENTIFIER NULL,
    [type]                                    NVARCHAR (MAX)   NULL,
    [updated_at]                              NVARCHAR (MAX)   NULL,
    [display]                                 NVARCHAR (MAX)   NULL,
    [current_actvity_id]                      UNIQUEIDENTIFIER NULL,
    [current_potential_violation_id]          UNIQUEIDENTIFIER NULL,
    [current_shift_statistic_id]              UNIQUEIDENTIFIER NULL,
    [current_user_id]                         UNIQUEIDENTIFIER NULL,
    [traffic_centre_id]                       UNIQUEIDENTIFIER NULL,
    [alert_violation_key]                     VARCHAR (MAX)    NULL,
    [alert_violation_display]                 VARCHAR (MAX)    NULL,
    [asset_number]                            VARCHAR (MAX)    NULL,
    [deleted_vehicle_or_driver_key]           VARCHAR (MAX)    NULL,
    [deleted_vehicle_or_driver_display]       VARCHAR (MAX)    NULL,
    [device_sect_56_begin]                    VARCHAR (MAX)    NULL,
    [device_sect_56_end]                      VARCHAR (MAX)    NULL,
    [device_sect_56_last_used]                VARCHAR (MAX)    NULL,
    [device_sect_56_nn]                       VARCHAR (MAX)    NULL,
    [device_sect_56_nnn]                      VARCHAR (MAX)    NULL,
    [immediate_stop_and_approach_key]         VARCHAR (MAX)    NULL,
    [immediate_stop_and_approach_display]     VARCHAR (MAX)    NULL,
    [last_app_version]                        VARCHAR (MAX)    NULL,
    [last_authentication_timestamp]           VARCHAR (MAX)    NULL,
    [last_known_location_latitude]            VARCHAR (MAX)    NULL,
    [last_known_location_longitude]           VARCHAR (MAX)    NULL,
    [last_known_location_altitude]            VARCHAR (MAX)    NULL,
    [last_known_location_horizontal_accuracy] VARCHAR (MAX)    NULL,
    [last_known_location_vertical_accuracy]   VARCHAR (MAX)    NULL,
    [last_known_location_timestamp]           VARCHAR (MAX)    NULL,
    [make_and_model]                          VARCHAR (MAX)    NULL,
    [mobile_number]                           VARCHAR (MAX)    NULL,
    [name]                                    VARCHAR (MAX)    NULL,
    [number]                                  VARCHAR (MAX)    NULL,
    [pin_number]                              VARCHAR (MAX)    NULL,
    [provider]                                VARCHAR (MAX)    NULL,
    [puk_number]                              VARCHAR (MAX)    NULL,
    [sect_56_device_identifier]               VARCHAR (MAX)    NULL,
    [sect_56_nn]                              VARCHAR (MAX)    NULL,
    [sect_56_nnn]                             VARCHAR (MAX)    NULL,
    [serial_number]                           VARCHAR (MAX)    NULL,
    [sim_card_number]                         VARCHAR (MAX)    NULL,
    [vehicle_device_key]                      VARCHAR (MAX)    NULL,
    [vehicle_device_display]                  VARCHAR (MAX)    NULL,
    [widget_url]                              VARCHAR (MAX)    NULL,
    [DeltaLogKey]                             INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]                             INT              DEFAULT ((-1)) NOT NULL
);
