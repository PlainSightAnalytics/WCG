CREATE TABLE [model].[Officer] (
    [OfficerKey]            INT              NOT NULL,
    [Authority]             VARCHAR (50)     NOT NULL,
    [District]              VARCHAR (50)     NOT NULL,
    [First Names]           VARCHAR (50)     NOT NULL,
    [Id Number]             VARCHAR (50)     NOT NULL,
    [Infrastructure Number] VARCHAR (20)     NOT NULL,
    [Initials]              VARCHAR (10)     NOT NULL,
    [Mobile Number]         VARCHAR (20)     NOT NULL,
    [Municipality]          VARCHAR (50)     NOT NULL,
    [Officer]               VARCHAR (50)     NOT NULL,
    [Officer Id]            UNIQUEIDENTIFIER NULL,
    [Other Authority]       VARCHAR (50)     NOT NULL,
    [Other Rank]            VARCHAR (50)     NOT NULL,
    [Other Station]         VARCHAR (50)     NOT NULL,
    [Province]              VARCHAR (50)     NOT NULL,
    [Rank]                  VARCHAR (50)     NOT NULL,
    [Station]               VARCHAR (50)     NOT NULL,
    [Surname]               VARCHAR (50)     NOT NULL
);

