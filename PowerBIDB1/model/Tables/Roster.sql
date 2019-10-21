CREATE TABLE [model].[Roster] (
    [RosterKey]                INT              NOT NULL,
    [Is Archived]              VARCHAR (3)      NOT NULL,
    [Is Deleted]               VARCHAR (3)      NOT NULL,
    [Is Revised]               VARCHAR (3)      NOT NULL,
    [Roster]                   VARCHAR (50)     NOT NULL,
    [Roster Group]             VARCHAR (50)     NOT NULL,
    [Roster Group Description] VARCHAR (100)    NOT NULL,
    [Roster Group PPI]         VARCHAR (100)    NOT NULL,
    [Roster Group Reports To]  VARCHAR (100)    NOT NULL,
    [Roster Group SPI]         VARCHAR (100)    NOT NULL,
    [Roster GUID]              UNIQUEIDENTIFIER NULL,
    [Roster Status]            VARCHAR (50)     NOT NULL
);

