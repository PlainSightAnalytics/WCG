CREATE TABLE [cle].[FlaggedVehicleAlertLog] (
    [RegistrationNo]        VARCHAR (20) NULL,
    [SightingRecordId]      INT          NULL,
    [FlagType]              VARCHAR (30) NULL,
    [TrafficCentreKey]      INT          NULL,
    [AlertDeliveryDateTime] DATETIME     NULL,
    [AuditKey]              INT          NULL
);

