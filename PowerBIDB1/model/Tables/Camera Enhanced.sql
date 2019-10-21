CREATE TABLE [model].[Camera Enhanced] (
    [CameraKey]                 INT              NOT NULL,
    [Camera GUID]               UNIQUEIDENTIFIER NULL,
    [Camera ID]                 VARCHAR (30)     NOT NULL,
    [Camera Location]           VARCHAR (30)     NOT NULL,
    [Camera Name]               VARCHAR (30)     NOT NULL,
    [Is Counted In Report]      VARCHAR (3)      NOT NULL,
    [Is Mobile Camera]          VARCHAR (3)      NOT NULL,
    [Lane ID]                   VARCHAR (50)     NOT NULL,
    [Operational Area]          VARCHAR (50)     NOT NULL,
    [Operational Area GUID]     UNIQUEIDENTIFIER NULL,
    [Site ID]                   VARCHAR (50)     NOT NULL,
    [Speed Section]             VARCHAR (50)     NOT NULL,
    [Speed Section Description] VARCHAR (100)    NOT NULL,
    [Speed Section Point]       VARCHAR (10)     NOT NULL,
    [Traffic Centre]            VARCHAR (50)     NOT NULL,
    [Traffic Centre GUID]       UNIQUEIDENTIFIER NULL,
    [Travel Direction]          VARCHAR (15)     NOT NULL,
    [Distance]                  NUMERIC (5, 3)   NULL,
    [Route]                     VARCHAR (15)     NOT NULL,
    [Flow Direction]            VARCHAR (15)     NOT NULL,
    [Route Sequence]            INT              NOT NULL
);

