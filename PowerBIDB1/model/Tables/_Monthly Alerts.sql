CREATE TABLE [model].[_Monthly Alerts] (
    [CameraKey]            INT NULL,
    [VehicleTypeKey]       INT NULL,
    [CalendarYearMonthKey] INT NULL,
    [AlertTypeKey]         INT NULL,
    [AllCameras]           INT NOT NULL,
    [AllVehicleTypes]      INT NOT NULL,
    [AllAlertTypes]        INT NOT NULL,
    [_AlertCount]          INT NULL,
    [_VehicleCount]        INT NULL
);

