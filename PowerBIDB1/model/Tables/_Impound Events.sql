CREATE TABLE [model].[_Impound Events] (
    [DriverKey]               INT              NOT NULL,
    [ImpoundEventDateKey]     INT              NOT NULL,
    [ImpoundEventTimeKey]     INT              NOT NULL,
    [ImpoundInstructionKey]   INT              NOT NULL,
    [ImpoundJourneyUserKey]   INT              NOT NULL,
    [OperationsDateKey]       INT              NOT NULL,
    [PoundFacilityKey]        INT              NOT NULL,
    [TrafficCentreKey]        INT              NOT NULL,
    [VehicleKey]              INT              NOT NULL,
    [Impound Event]           VARCHAR (10)     NULL,
    [Impound Event Date Time] DATETIME         NULL,
    [Unique ID]               UNIQUEIDENTIFIER NULL
);

