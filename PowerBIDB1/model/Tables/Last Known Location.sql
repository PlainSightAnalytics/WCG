CREATE TABLE [model].[Last Known Location] (
    [DeviceId]                  UNIQUEIDENTIFIER NULL,
    [UserId]                    UNIQUEIDENTIFIER NULL,
    [ShiftId]                   UNIQUEIDENTIFIER NULL,
    [Device]                    VARCHAR (50)     NULL,
    [Latitude]                  NUMERIC (19, 2)  NULL,
    [Longitude]                 NUMERIC (19, 2)  NULL,
    [TrafficCentre]             VARCHAR (50)     NULL,
    [Officer]                   VARCHAR (100)    NULL,
    [LastKnownLocationDate]     DATETIME         NULL,
    [DeviceLastUsedDate]        DATETIME         NULL,
    [LastShiftStartTime]        DATETIME         NULL,
    [LastShiftEndTime]          DATETIME         NULL,
    [DurationSinceLastActivity] INT              NULL,
    [HasLocation]               VARCHAR (3)      NOT NULL,
    [HasEvents]                 VARCHAR (3)      NOT NULL,
    [Status]                    VARCHAR (5)      NULL,
    [DeviceKey]                 INT              NOT NULL,
    [TrafficCentreKey]          INT              NOT NULL,
    [UserKey]                   INT              NOT NULL,
    [ShiftKey]                  INT              NOT NULL,
    [LastKnownLocationDateKey]  NVARCHAR (4000)  NULL,
    [LastKnownLocationTimeKey]  NVARCHAR (4000)  NULL,
    [EventCountLast48Hours]     INT              NOT NULL
);



