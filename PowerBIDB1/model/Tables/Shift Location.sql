CREATE TABLE [model].[Shift Location] (
    [ShiftLocationKey]  INT              NOT NULL,
    [Latitude]          NUMERIC (19, 2)  NOT NULL,
    [Location Type]     VARCHAR (20)     NOT NULL,
    [Longitude]         NUMERIC (19, 2)  NOT NULL,
    [Road Number]       VARCHAR (10)     NOT NULL,
    [Shift Location]    VARCHAR (50)     NOT NULL,
    [Shift Location ID] UNIQUEIDENTIFIER NULL,
    [Traffic Centre]    VARCHAR (50)     NOT NULL
);

