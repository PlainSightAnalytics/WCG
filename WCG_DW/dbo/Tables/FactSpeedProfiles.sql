CREATE TABLE [dbo].[FactSpeedProfiles] (
    [CameraKey]             INT DEFAULT ((-1)) NOT NULL,
    [SightingDateKey]       INT DEFAULT ((-1)) NOT NULL,
    [SpeedProfileBucketKey] INT DEFAULT ((-1)) NOT NULL,
    [VehicleTypeKey]        INT DEFAULT ((-1)) NOT NULL,
    [AverageSpeed]          INT NULL,
    [MaximumSpeed]          INT NULL,
    [MinimumSpeed]          INT NULL,
    [VehicleCount]          INT NULL,
    [InsertAuditKey]        INT DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]        INT DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]           INT DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]       INT DEFAULT ((-1)) NOT NULL,
    [DeletedFlag]           INT DEFAULT ((0)) NOT NULL,
    CONSTRAINT [FK_dbo_FactSpeedProfiles_CameraKey] FOREIGN KEY ([CameraKey]) REFERENCES [dbo].[DimCamera] ([CameraKey]),
    CONSTRAINT [FK_dbo_FactSpeedProfiles_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactSpeedProfiles_SightingDateKey] FOREIGN KEY ([SightingDateKey]) REFERENCES [dbo].[DimDate] ([DateKey]),
    CONSTRAINT [FK_dbo_FactSpeedProfiles_SpeedProfileBucketKey] FOREIGN KEY ([SpeedProfileBucketKey]) REFERENCES [dbo].[DimSpeedProfileBucket] ([SpeedProfileBucketKey]),
    CONSTRAINT [FK_dbo_FactSpeedProfiles_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_FactSpeedProfiles_VehicleTypeKey] FOREIGN KEY ([VehicleTypeKey]) REFERENCES [dbo].[DimVehicleType] ([VehicleTypeKey])
);

