CREATE TABLE [model].[Device] (
    [DeviceKey]        INT              NOT NULL,
    [CurrentUserKey]   INT              NOT NULL,
    [TrafficCentreKey] INT              NOT NULL,
    [Device]           VARCHAR (50)     NOT NULL,
    [Device ID]        UNIQUEIDENTIFIER NULL,
    [Device Type]      VARCHAR (50)     NOT NULL
);

