CREATE TABLE [model].[_Monthly Fatigue Alerts] (
    [CameraKey]            INT     NOT NULL,
    [VehicleTypeKey]       INT     NOT NULL,
    [CalendarYearMonthKey] INT     NOT NULL,
    [AllCameras]           TINYINT NOT NULL,
    [AlVehicleTypes]       TINYINT NOT NULL,
    [_SightingCount]       INT     NULL,
    [_VehicleCount]        INT     NULL
);

