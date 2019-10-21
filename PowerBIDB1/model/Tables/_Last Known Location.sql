CREATE TABLE [model].[_Last Known Location] (
    [DeviceKey]        INT             NULL,
    [UserKey]          INT             NULL,
    [TrafficCentreKey] INT             NULL,
    [UpdatedDateKey]   INT             NULL,
    [Latitude]         NUMERIC (19, 5) NULL,
    [Longitude]        NUMERIC (19, 5) NULL,
    [LastUsedDateTime] DATETIME        NULL
);

