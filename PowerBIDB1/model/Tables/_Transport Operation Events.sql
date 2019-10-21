CREATE TABLE [model].[_Transport Operation Events] (
    [AlertTypeKey]            INT           NOT NULL,
    [DeviceKey]               INT           NOT NULL,
    [DriverKey]               INT           NOT NULL,
    [MagistratesCourtKey]     INT           NOT NULL,
    [OpenDateKey]             INT           NOT NULL,
    [OpenTimeKey]             INT           NOT NULL,
    [OperationKey]            INT           NOT NULL,
    [OperationsDateKey]       INT           NOT NULL,
    [TrafficCentreKey]        INT           NOT NULL,
    [TrafficControlEventKey]  INT           NOT NULL,
    [UpdatedDateKey]          INT           NOT NULL,
    [UpdatedTimeKey]          INT           NOT NULL,
    [UserKey]                 INT           NOT NULL,
    [VehicleKey]              INT           NOT NULL,
    [VehicleTypeKey]          INT           NOT NULL,
    [RelatedTrafficCentre]    VARCHAR (50)  NULL,
    [RelatedUser]             VARCHAR (100) NULL,
    [LandTransportSurveyFlag] VARCHAR (3)   NOT NULL,
    [EMSFlag]                 VARCHAR (3)   NOT NULL,
    [RoadSafetyFlag]          VARCHAR (3)   NOT NULL
);

