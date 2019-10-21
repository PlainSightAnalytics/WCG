CREATE TABLE [dbo].[DimDeltaLog] (
    [DeltaLogKey]       INT          IDENTITY (1, 1) NOT NULL,
    [DeltaType]         VARCHAR (10) DEFAULT ('UNK') NOT NULL,
    [FileDate]          DATETIME     NULL,
    [ClientName]        VARCHAR (50) DEFAULT ('UNKNOWN') NOT NULL,
    [SchemaName]        VARCHAR (50) DEFAULT ('UNKNOWN') NOT NULL,
    [ObjectName]        VARCHAR (50) DEFAULT ('UNKNOWN') NOT NULL,
    [LoadFlag]          TINYINT      DEFAULT ((0)) NOT NULL,
    [LogDate]           DATETIME     NULL,
    [HighWaterDateTime] VARCHAR (20) NULL,
    [HighWaterMark]     VARCHAR (50) NULL,
    [RowCountError]     INT          DEFAULT ((0)) NOT NULL,
    [RowCountExcluded]  INT          DEFAULT ((0)) NOT NULL,
    [RowCountInsert]    INT          DEFAULT ((0)) NOT NULL,
    [RowCountSource]    INT          DEFAULT ((0)) NOT NULL,
    [RowCountStage]     INT          DEFAULT ((0)) NOT NULL,
    [RowCountUpdate]    INT          DEFAULT ((0)) NOT NULL,
    [UniqueIdentifier]  VARCHAR (50) DEFAULT ('UNKNOWN') NOT NULL,
    [InsertAuditKey]    INT          DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]    INT          DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimDeltaLog] PRIMARY KEY CLUSTERED ([DeltaLogKey] ASC)
);

