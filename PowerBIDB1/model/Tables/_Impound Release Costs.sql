CREATE TABLE [model].[_Impound Release Costs] (
    [CreateDateKey]         INT              NOT NULL,
    [DriverKey]             INT              NOT NULL,
    [ImpoundInstructionKey] INT              NOT NULL,
    [ImpoundJourneyUserKey] INT              NOT NULL,
    [OperationsDateKey]     INT              NOT NULL,
    [PoundFacilityKey]      INT              NOT NULL,
    [TrafficCentreKey]      INT              NOT NULL,
    [VehicleKey]            INT              NOT NULL,
    [Release Description]   VARCHAR (100)    NULL,
    [Release Status]        VARCHAR (50)     NULL,
    [Unique ID]             UNIQUEIDENTIFIER NULL,
    [_AmountPaid]           NUMERIC (19, 2)  NULL
);

