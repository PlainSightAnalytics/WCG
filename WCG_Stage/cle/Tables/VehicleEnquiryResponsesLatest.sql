CREATE TABLE [cle].[VehicleEnquiryResponsesLatest] (
    [VehicleEnquiryResponseRecordId] INT                NOT NULL,
    [Timestamp]                      DATETIMEOFFSET (7) NULL,
    [LicenceNumber]                  NVARCHAR (20)      NULL,
    [VehicleUsageCode]               NVARCHAR (5)       NULL,
    [CategoryCode]                   NVARCHAR (5)       NULL
);

