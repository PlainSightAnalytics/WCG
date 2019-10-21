CREATE TABLE [model].[_Alerts Summary] (
    [AlertDateKey]                       INT NOT NULL,
    [AlertTypeKey]                       INT NOT NULL,
    [CameraKey]                          INT NOT NULL,
    [GeoLocationKey]                     INT NOT NULL,
    [HourKey]                            INT NOT NULL,
    [OperationsDateKey]                  INT NOT NULL,
    [TrafficCentreKey]                   INT NOT NULL,
    [VehicleTypeKey]                     INT NOT NULL,
    [_AlertsCount]                       INT NULL,
    [_AverageSpeed]                      INT NULL,
    [_MaximumSpeed]                      INT NULL,
    [_VehicleCountDay]                   INT NULL,
    [_VehicleCountDayCamera]             INT NULL,
    [_VehicleCountDayRegion]             INT NULL,
    [_VehicleCountDayTrafficCentre]      INT NULL,
    [_VehicleCountDayTrafficCentreHour]  INT NULL,
    [_VehicleCountDayTrafficCentreShift] INT NULL,
    [DeltaLogKey]                        INT NOT NULL
);

