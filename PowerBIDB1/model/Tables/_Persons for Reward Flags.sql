CREATE TABLE [model].[_Persons for Reward Flags] (
    [Route]          VARCHAR (15)    NULL,
    [VehicleKey]     INT             NOT NULL,
    [EndDateKey]     INT             NULL,
    [EndTimeKey]     INT             NULL,
    [EndTime]        DATETIME        NULL,
    [TripID]         VARCHAR (50)    NULL,
    [TripDuration]   INT             NULL,
    [TotalDistance]  NUMERIC (38, 3) NULL,
    [AverageSpeed]   NUMERIC (38, 6) NULL,
    [CameraCount]    INT             NULL,
    [SpeedingFlag]   VARCHAR (3)     NOT NULL,
    [FatiqueFlag]    VARCHAR (3)     NOT NULL,
    [TurnaroundFlag] VARCHAR (3)     NOT NULL
);

