CREATE TABLE [model].[_Impound Requests] (
    [DriverKey]               INT              NOT NULL,
    [ImpoundInstructionKey]   INT              NOT NULL,
    [OperationsDateKey]       INT              NOT NULL,
    [PoundFacilityKey]        INT              NOT NULL,
    [TrafficCentreKey]        INT              NOT NULL,
    [TrafficControlEventKey]  INT              NOT NULL,
    [UpdateDateKey]           INT              NOT NULL,
    [UserKey]                 INT              NOT NULL,
    [VehicleKey]              INT              NOT NULL,
    [Impound Override Reason] VARCHAR (1000)   NULL,
    [Impound Request Status]  VARCHAR (10)     NULL,
    [Is Impound Overridden]   VARCHAR (3)      NULL,
    [Unique I D]              UNIQUEIDENTIFIER NULL
);

