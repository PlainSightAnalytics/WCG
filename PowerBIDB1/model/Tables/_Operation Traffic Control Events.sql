CREATE TABLE [model].[_Operation Traffic Control Events] (
    [OperationDateKey]       INT             NOT NULL,
    [OperationKey]           INT             NOT NULL,
    [OperationsDateKey]      INT             NULL,
    [OpenTimeKey]            INT             NULL,
    [TrafficCentreKey]       INT             NOT NULL,
    [TrafficControlEventKey] INT             NOT NULL,
    [Section56FormKey]       INT             NOT NULL,
    [UserKey]                INT             NOT NULL,
    [ViolationChargeKey]     INT             NOT NULL,
    [EventDateTime]          DATETIME        NULL,
    [ChargeAmount]           NUMERIC (19, 2) NULL
);

