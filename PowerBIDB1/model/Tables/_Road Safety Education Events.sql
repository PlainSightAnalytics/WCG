CREATE TABLE [model].[_Road Safety Education Events] (
    [CreateTimeKey]          INT              NOT NULL,
    [DriverKey]              INT              NOT NULL,
    [CreateDateKey]          INT              NOT NULL,
    [OperationsDateKey]      INT              NOT NULL,
    [RoadSafetyTopicKey]     INT              NOT NULL,
    [TrafficCentreKey]       INT              NOT NULL,
    [TrafficControlEventKey] INT              NOT NULL,
    [UserKey]                INT              NOT NULL,
    [VehicleKey]             INT              NOT NULL,
    [Unique ID]              UNIQUEIDENTIFIER NULL,
    [NumberOfPassengers]     INT              NULL,
    [AverageTopics]          NUMERIC (26, 14) NULL
);

