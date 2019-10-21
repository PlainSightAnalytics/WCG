CREATE TABLE [model].[_Alerts] (
    [AlertTypeKey]          INT          NOT NULL,
    [CameraKey]             INT          NOT NULL,
    [GeoLocationKey]        INT          NOT NULL,
    [OperationsDateKey]     INT          NOT NULL,
    [TrafficCentreKey]      INT          NOT NULL,
    [UpdatedDateKey]        INT          NOT NULL,
    [UpdatedTimeKey]        INT          NOT NULL,
    [VehicleKey]            INT          NOT NULL,
    [Alert Record ID]       VARCHAR (15) NULL,
    [Alert Status]          VARCHAR (50) NULL,
    [Source Alert ID]       VARCHAR (32) NULL,
    [Source System]         VARCHAR (50) NULL,
    [Speed Class Code]      VARCHAR (30) NULL,
    [Vehicle Category]      VARCHAR (50) NULL,
    [Vehicle Category Code] VARCHAR (30) NULL,
    [Vehicle Usage]         VARCHAR (50) NULL,
    [Vehicle Usage Code]    VARCHAR (30) NULL,
    [_AverageSpeed]         INT          NOT NULL,
    [_DurationAlert]        INT          NULL,
    [_DurationPrimary]      INT          NULL,
    [_SpeedLimit]           INT          NULL
);

