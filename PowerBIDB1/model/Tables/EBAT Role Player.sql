CREATE TABLE [model].[EBAT Role Player] (
    [EBATRolePlayerKey]     INT              NOT NULL,
    [Authority]             VARCHAR (50)     NOT NULL,
    [Centre Or Station]     VARCHAR (50)     NOT NULL,
    [District]              VARCHAR (50)     NOT NULL,
    [EBAT Role Player ID]   UNIQUEIDENTIFIER NULL,
    [First Name]            VARCHAR (50)     NOT NULL,
    [ID Number]             VARCHAR (20)     NOT NULL,
    [Infrastructure Number] VARCHAR (50)     NOT NULL,
    [Is Operator]           VARCHAR (3)      NOT NULL,
    [Mobile Number]         VARCHAR (20)     NOT NULL,
    [Municipality]          VARCHAR (50)     NOT NULL,
    [Province]              VARCHAR (50)     NOT NULL,
    [Rank Or Role]          VARCHAR (50)     NOT NULL,
    [Surname]               VARCHAR (50)     NOT NULL
);

