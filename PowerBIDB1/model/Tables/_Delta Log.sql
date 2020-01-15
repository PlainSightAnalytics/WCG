CREATE TABLE [model].[_Delta Log] (
    [LogDateKey]        NVARCHAR (4000) NULL,
    [LogTimeKey]        NVARCHAR (4000) NULL,
    [DeltaObjectKey]    INT             NOT NULL,
    [DeltaLogKey]       INT             NOT NULL,
    [LoadFlag]          TINYINT         NOT NULL,
    [HighWaterDateTime] VARCHAR (20)    NULL,
    [RowCountSource]    INT             NOT NULL,
    [RowCountStage]     INT             NOT NULL,
    [RowCountInsert]    INT             NOT NULL,
    [RowCountUpdate]    INT             NOT NULL,
    [RowCountError]     INT             NOT NULL,
    [RowCountExcluded]  INT             NOT NULL
);

