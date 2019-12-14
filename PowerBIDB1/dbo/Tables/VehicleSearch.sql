CREATE TABLE [dbo].[VehicleSearch] (
    [SightingRecordId] VARCHAR (15)    NULL,
    [TimeStamp]        DATETIME        NULL,
    [RegistrationNo]   VARCHAR (20)    NULL,
    [VehicleCategory]  VARCHAR (50)    NULL,
    [VehicleUsage]     VARCHAR (50)    NULL,
    [Latitude]         NUMERIC (19, 6) NULL,
    [Longitude]        NUMERIC (19, 6) NULL,
    [Route]            VARCHAR (20)    NULL,
    [SpeedSection]     VARCHAR (50)    NULL,
    [AlertRecordId]    VARCHAR (15)    NULL,
    [AlertCount]       INT             NOT NULL,
    [Alerts]           VARCHAR (8000)  NULL,
    [AverageSpeed]     INT             NULL,
    [DeltaLogKey]      INT             NULL
);


GO
CREATE CLUSTERED COLUMNSTORE INDEX [idxCCI]
    ON [dbo].[VehicleSearch];

