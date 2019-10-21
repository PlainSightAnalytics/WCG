CREATE TABLE [model].[_APP Targets] (
    [APPTargetKey]     INT              NOT NULL,
    [TargetDateKey]    INT              NOT NULL,
    [TrafficCentreKey] INT              NOT NULL,
    [Unique GUID]      UNIQUEIDENTIFIER NULL,
    [_AdjustedTarget]  NUMERIC (19, 2)  NULL,
    [_Target]          NUMERIC (19, 2)  NULL
);

