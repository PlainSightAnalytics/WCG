CREATE TABLE [dbo].[DimVehicle] (
    [VehicleKey]          INT           IDENTITY (1, 1) NOT NULL,
    [Colour]              VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [ColourCode]          VARCHAR (10)  DEFAULT ('UNK') NOT NULL,
    [Make]                VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [MakeCode]            VARCHAR (10)  DEFAULT ('UNK') NOT NULL,
    [Model]               VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [ModelCode]           VARCHAR (10)  DEFAULT ('UNK') NOT NULL,
    [RegistrationNo]      VARCHAR (20)  DEFAULT ('Unknown') NOT NULL,
    [VehicleCategory]     VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [VehicleCategoryCode] VARCHAR (10)  DEFAULT ('UNK') NOT NULL,
    [VehicleUsage]        VARCHAR (50)  DEFAULT ('Unknown') NOT NULL,
    [VehicleUsageCode]    VARCHAR (10)  DEFAULT ('UNK') NOT NULL,
    [RowIsCurrent]        CHAR (1)      DEFAULT ('Y') NOT NULL,
    [RowIsInferred]       CHAR (1)      DEFAULT ('N') NOT NULL,
    [RowStartDate]        DATETIME      DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]          DATETIME      DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]     VARCHAR (200) DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]      INT           DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]      INT           DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]         INT           DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]     INT           DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimVehicle] PRIMARY KEY CLUSTERED ([VehicleKey] ASC),
    CONSTRAINT [FK_dbo_DimVehicle_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimVehicle_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);


GO
CREATE UNIQUE NONCLUSTERED INDEX [idxRegistrationNo]
    ON [dbo].[DimVehicle]([RegistrationNo] ASC);

