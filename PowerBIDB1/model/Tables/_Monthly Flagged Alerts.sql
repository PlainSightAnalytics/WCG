CREATE TABLE [model].[_Monthly Flagged Alerts] (
    [CameraKey]            INT          NOT NULL,
    [VehicleTypeKey]       INT          NOT NULL,
    [CalendarYearMonthKey] INT          NOT NULL,
    [FlagType]             VARCHAR (30) NULL,
    [AllCameras]           INT          NULL,
    [AllVehicleTypes]      INT          NULL,
    [AllFlagTypes]         INT          NULL,
    [_SightingCount]       INT          NULL,
    [_VehicleCount]        INT          NULL
);

