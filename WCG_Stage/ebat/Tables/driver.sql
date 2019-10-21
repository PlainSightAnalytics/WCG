﻿CREATE TABLE [ebat].[driver] (
    [id]                                       UNIQUEIDENTIFIER NULL,
    [type]                                     NVARCHAR (MAX)   NULL,
    [updated_at]                               NVARCHAR (MAX)   NULL,
    [display]                                  NVARCHAR (MAX)   NULL,
    [device_id]                                UNIQUEIDENTIFIER NULL,
    [ebat_report_id]                           UNIQUEIDENTIFIER NULL,
    [user_id]                                  UNIQUEIDENTIFIER NULL,
    [age]                                      VARCHAR (MAX)    NULL,
    [alternative_id_number_captured]           VARCHAR (MAX)    NULL,
    [archived_key]                             VARCHAR (MAX)    NULL,
    [archived_display]                         VARCHAR (MAX)    NULL,
    [code_a1_date_of_first_issue]              VARCHAR (MAX)    NULL,
    [code_a1_has_license_key]                  VARCHAR (MAX)    NULL,
    [code_a1_has_license_display]              VARCHAR (MAX)    NULL,
    [code_a1_license_restriction_description]  VARCHAR (MAX)    NULL,
    [code_a_date_of_first_issue]               VARCHAR (MAX)    NULL,
    [code_a_has_license_key]                   VARCHAR (MAX)    NULL,
    [code_a_has_license_display]               VARCHAR (MAX)    NULL,
    [code_a_license_restriction_description]   VARCHAR (MAX)    NULL,
    [code_b_date_of_first_issue]               VARCHAR (MAX)    NULL,
    [code_b_has_license_key]                   VARCHAR (MAX)    NULL,
    [code_b_has_license_display]               VARCHAR (MAX)    NULL,
    [code_b_license_restriction_description]   VARCHAR (MAX)    NULL,
    [code_c1_date_of_first_issue]              VARCHAR (MAX)    NULL,
    [code_c1_has_license_key]                  VARCHAR (MAX)    NULL,
    [code_c1_has_license_display]              VARCHAR (MAX)    NULL,
    [code_c1_license_restriction_description]  VARCHAR (MAX)    NULL,
    [code_c_date_of_first_issue]               VARCHAR (MAX)    NULL,
    [code_c_has_license_key]                   VARCHAR (MAX)    NULL,
    [code_c_has_license_display]               VARCHAR (MAX)    NULL,
    [code_c_license_restriction_description]   VARCHAR (MAX)    NULL,
    [code_eb_date_of_first_issue]              VARCHAR (MAX)    NULL,
    [code_eb_has_license_key]                  VARCHAR (MAX)    NULL,
    [code_eb_has_license_display]              VARCHAR (MAX)    NULL,
    [code_eb_license_restriction_description]  VARCHAR (MAX)    NULL,
    [code_ec1_date_of_first_issue]             VARCHAR (MAX)    NULL,
    [code_ec1_has_license_key]                 VARCHAR (MAX)    NULL,
    [code_ec1_has_license_display]             VARCHAR (MAX)    NULL,
    [code_ec1_license_restriction_description] VARCHAR (MAX)    NULL,
    [code_ec_date_of_first_issue]              VARCHAR (MAX)    NULL,
    [code_ec_has_license_key]                  VARCHAR (MAX)    NULL,
    [code_ec_has_license_display]              VARCHAR (MAX)    NULL,
    [code_ec_license_restriction_description]  VARCHAR (MAX)    NULL,
    [country]                                  VARCHAR (MAX)    NULL,
    [date_of_birth]                            VARCHAR (MAX)    NULL,
    [enatis_id_document_number]                VARCHAR (MAX)    NULL,
    [enatis_id_document_type]                  VARCHAR (MAX)    NULL,
    [enatis_summary]                           VARCHAR (MAX)    NULL,
    [enatis_time_updated]                      VARCHAR (MAX)    NULL,
    [have_checked_enatis_key]                  VARCHAR (MAX)    NULL,
    [have_checked_enatis_display]              VARCHAR (MAX)    NULL,
    [id_number_captured]                       VARCHAR (MAX)    NULL,
    [initials]                                 VARCHAR (MAX)    NULL,
    [initials_captured]                        VARCHAR (MAX)    NULL,
    [learner_certificate_number]               VARCHAR (MAX)    NULL,
    [learner_license_status_description]       VARCHAR (MAX)    NULL,
    [learner_license_type_description]         VARCHAR (MAX)    NULL,
    [learner_license_valid_from]               VARCHAR (MAX)    NULL,
    [license_authorisation_date]               VARCHAR (MAX)    NULL,
    [license_date_of_first_issue]              VARCHAR (MAX)    NULL,
    [license_expiry_date]                      VARCHAR (MAX)    NULL,
    [license_expiry_date_captured]             VARCHAR (MAX)    NULL,
    [license_present_captured_key]             VARCHAR (MAX)    NULL,
    [license_present_captured_display]         VARCHAR (MAX)    NULL,
    [license_restriction]                      VARCHAR (MAX)    NULL,
    [license_restriction_captured]             VARCHAR (MAX)    NULL,
    [license_restriction_description]          VARCHAR (MAX)    NULL,
    [license_type_code]                        VARCHAR (MAX)    NULL,
    [license_type_code_captured]               VARCHAR (MAX)    NULL,
    [license_type_description]                 VARCHAR (MAX)    NULL,
    [license_vehicle_restrictions]             VARCHAR (MAX)    NULL,
    [license_vehicle_restrictions_captured]    VARCHAR (MAX)    NULL,
    [prdp_code]                                VARCHAR (MAX)    NULL,
    [prdp_code_captured]                       VARCHAR (MAX)    NULL,
    [prdp_dangerous_goods_flag_key]            VARCHAR (MAX)    NULL,
    [prdp_dangerous_goods_flag_display]        VARCHAR (MAX)    NULL,
    [prdp_date_authorised]                     VARCHAR (MAX)    NULL,
    [prdp_expiry_date]                         VARCHAR (MAX)    NULL,
    [prdp_expiry_date_captured]                VARCHAR (MAX)    NULL,
    [prdp_goods_flag_key]                      VARCHAR (MAX)    NULL,
    [prdp_goods_flag_display]                  VARCHAR (MAX)    NULL,
    [prdp_passenger_flag_key]                  VARCHAR (MAX)    NULL,
    [prdp_passenger_flag_display]              VARCHAR (MAX)    NULL,
    [sex]                                      VARCHAR (MAX)    NULL,
    [sex_captured_key]                         VARCHAR (MAX)    NULL,
    [sex_captured_display]                     VARCHAR (MAX)    NULL,
    [status_key]                               VARCHAR (MAX)    NULL,
    [status_display]                           VARCHAR (MAX)    NULL,
    [surname]                                  VARCHAR (MAX)    NULL,
    [surname_captured]                         VARCHAR (MAX)    NULL,
    [timestamp_captured]                       VARCHAR (MAX)    NULL,
    [voluntary_lookup_key]                     VARCHAR (MAX)    NULL,
    [voluntary_lookup_display]                 VARCHAR (MAX)    NULL,
    [DeltaLogKey]                              INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                                 INT              DEFAULT ((-1)) NOT NULL
);

