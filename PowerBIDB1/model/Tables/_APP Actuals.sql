CREATE TABLE [model].[_APP Actuals] (
    [ActualDateKey]      INT              NOT NULL,
    [APPTargetKey]       INT              NOT NULL,
    [TrafficCentreKey]   INT              NOT NULL,
    [Comments]           VARCHAR (1000)   NULL,
    [Unique GUID]        UNIQUEIDENTIFIER NULL,
    [_PreliminaryActual] NUMERIC (19, 2)  NULL,
    [_VerifiedActual]    NUMERIC (19, 2)  NULL
);

