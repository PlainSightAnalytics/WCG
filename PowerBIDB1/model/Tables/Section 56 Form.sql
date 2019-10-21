CREATE TABLE [model].[Section 56 Form] (
    [Section56FormKey]          INT              NOT NULL,
    [Court Code]                VARCHAR (10)     NOT NULL,
    [Court Name]                VARCHAR (50)     NOT NULL,
    [Generated Date Time]       DATETIME         NULL,
    [Is Manual Entry]           VARCHAR (3)      NOT NULL,
    [Licence Code]              VARCHAR (100)    NOT NULL,
    [Section 56 Form GUID]      UNIQUEIDENTIFIER NULL,
    [Section 56 Number]         VARCHAR (50)     NOT NULL,
    [Subject Age]               INT              NOT NULL,
    [Subject First Names]       VARCHAR (50)     NULL,
    [Subject Gender]            VARCHAR (10)     NOT NULL,
    [Subject ID Number]         VARCHAR (20)     NOT NULL,
    [Subject ID Number Foreign] VARCHAR (50)     NOT NULL,
    [Subject Nationality]       VARCHAR (30)     NOT NULL,
    [Subject Surname]           VARCHAR (50)     NOT NULL
);

