CREATE TABLE [model].[Camera] (
    [CameraKey]                     INT              NOT NULL,
    [Camera GUID]                   UNIQUEIDENTIFIER NULL,
    [Camera ID]                     VARCHAR (30)     NULL,
    [Camera Location]               VARCHAR (30)     NULL,
    [Camera Name]                   VARCHAR (30)     NULL,
    [Distance From Previous Camera] NUMERIC (11, 3)  NULL,
    [Is Counted In Report]          VARCHAR (3)      NULL,
    [Is Mobile Camera]              VARCHAR (3)      NULL,
    [Lane ID]                       VARCHAR (50)     NULL,
    [Operational Area]              VARCHAR (50)     NULL,
    [Operational Area GUID]         UNIQUEIDENTIFIER NULL,
    [Route]                         VARCHAR (20)     NULL,
    [Route Sequence]                INT              NULL,
    [Site ID]                       VARCHAR (50)     NULL,
    [Speed Section]                 VARCHAR (50)     NULL,
    [Speed Section Description]     VARCHAR (100)    NULL,
    [Speed Section Distance]        NUMERIC (11, 2)  NULL,
    [Speed Section Point]           VARCHAR (10)     NULL,
    [Traffic Centre]                VARCHAR (50)     NULL,
    [Traffic Centre GUID]           UNIQUEIDENTIFIER NULL,
    [Travel Direction]              VARCHAR (10)     NULL
);

