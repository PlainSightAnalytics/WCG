CREATE TABLE [model].[Operator] (
    [OperatorKey]           INT              NOT NULL,
    [Authority]             VARCHAR (50)     NOT NULL,
    [Centre]                VARCHAR (50)     NOT NULL,
    [District]              VARCHAR (50)     NOT NULL,
    [First Name]            VARCHAR (50)     NOT NULL,
    [ID Number]             VARCHAR (20)     NOT NULL,
    [Infrastructure Number] VARCHAR (50)     NOT NULL,
    [Is Operator]           VARCHAR (3)      NOT NULL,
    [Municipality]          VARCHAR (50)     NOT NULL,
    [Operator]              VARCHAR (50)     NOT NULL,
    [Operator Certificate]  VARCHAR (50)     NOT NULL,
    [Operator ID]           UNIQUEIDENTIFIER NULL,
    [Province]              VARCHAR (50)     NOT NULL,
    [Regional Area]         VARCHAR (50)     NOT NULL,
    [Role]                  VARCHAR (10)     NOT NULL,
    [Surname]               VARCHAR (50)     NOT NULL
);

