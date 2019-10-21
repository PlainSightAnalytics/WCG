CREATE TABLE [model].[EBAT Device] (
    [EBATDeviceKey]             INT              NOT NULL,
    [Calibration Certificate]   VARCHAR (50)     NOT NULL,
    [Certificate Date Of Issue] DATE             NULL,
    [Certificate Number]        VARCHAR (50)     NOT NULL,
    [Created By]                VARCHAR (50)     NOT NULL,
    [Created Date]              DATE             NULL,
    [Date Of Next Calibration]  DATE             NULL,
    [Device Make]               VARCHAR (50)     NOT NULL,
    [Device Manufacturer]       VARCHAR (50)     NOT NULL,
    [Device Model]              VARCHAR (50)     NOT NULL,
    [Device Status]             VARCHAR (50)     NOT NULL,
    [EBAT Device]               VARCHAR (50)     NOT NULL,
    [EBAT Device ID]            UNIQUEIDENTIFIER NULL,
    [Serial Number]             VARCHAR (50)     NOT NULL
);

