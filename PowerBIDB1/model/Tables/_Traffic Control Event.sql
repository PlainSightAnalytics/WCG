﻿CREATE TABLE [model].[_Traffic Control Event] (
    [DeviceKey]                    INT             NOT NULL,
    [TrafficCentreKey]             INT             NOT NULL,
    [UpdatedDateKey]               INT             NOT NULL,
    [UpdatedTimeKey]               INT             NOT NULL,
    [UserKey]                      INT             NOT NULL,
    [VehicleKey]                   INT             NOT NULL,
    [VehicleTypeKey]               INT             NOT NULL,
    [Action Taken]                 VARCHAR (50)    NULL,
    [Alcohol Level]                VARCHAR (10)    NULL,
    [Alcohol Screening]            VARCHAR (3)     NULL,
    [Event Source]                 VARCHAR (50)    NULL,
    [Forced Close Reason]          VARCHAR (50)    NULL,
    [Forced Close Type]            VARCHAR (50)    NULL,
    [Has Alcohol And Drugs]        VARCHAR (3)     NULL,
    [Has Disregarded Instructions] VARCHAR (3)     NULL,
    [Has Driving Violations]       VARCHAR (3)     NULL,
    [Has Moving Violations]        VARCHAR (3)     NULL,
    [Has No AG Violations]         VARCHAR (3)     NULL,
    [Has Regulatory Signs]         VARCHAR (3)     NULL,
    [Has Road Markings]            VARCHAR (3)     NULL,
    [Has Speed Violations]         VARCHAR (3)     NULL,
    [Has Violation]                VARCHAR (3)     NULL,
    [Is Enatis Feedback Reviewed]  VARCHAR (3)     NULL,
    [Is Section 56 Draft]          VARCHAR (3)     NULL,
    [Police Station]               VARCHAR (50)    NULL,
    [Section 561]                  VARCHAR (50)    NULL,
    [Section 562]                  VARCHAR (50)    NULL,
    [Section 563]                  VARCHAR (50)    NULL,
    [Status Code]                  VARCHAR (30)    NULL,
    [_EventDuration]               INT             NULL,
    [_FineTotal]                   NUMERIC (11, 2) NULL,
    [DeltaLogKey]                  INT             NULL
);

