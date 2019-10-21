CREATE TABLE [model].[_Sightings Summary] (
    [CameraKey]                          INT NOT NULL,
    [GeoLocationKey]                     INT NOT NULL,
    [HourKey]                            INT NOT NULL,
    [OperationsDateKey]                  INT NOT NULL,
    [SightingDateKey]                    INT NOT NULL,
    [TrafficCentreKey]                   INT NOT NULL,
    [VehicleTypeKey]                     INT NOT NULL,
    [_SightingsCount]                    INT NULL,
    [_VehicleCountDay]                   INT NULL,
    [_VehicleCountDayCamera]             INT NULL,
    [_VehicleCountDayRegion]             INT NULL,
    [_VehicleCountDayTrafficCentre]      INT NULL,
    [_VehicleCountDayTrafficCentreHour]  INT NULL,
    [_VehicleCountDayTrafficCentreShift] INT NULL,
    [DeltaLogKey]                        INT NULL
);

