CREATE TABLE [model].[_Impound Violation Charges] (
    [CreateDateKey]         INT              NOT NULL,
    [DriverKey]             INT              NOT NULL,
    [ImpoundInstructionKey] INT              NOT NULL,
    [ImpoundJourneyUserKey] INT              NOT NULL,
    [OperationsDateKey]     INT              NOT NULL,
    [PoundFacilityKey]      INT              NOT NULL,
    [TrafficCentreKey]      INT              NOT NULL,
    [VehicleKey]            INT              NOT NULL,
    [ViolationChargeKey]    INT              NOT NULL,
    [Unique ID]             UNIQUEIDENTIFIER NULL
);

