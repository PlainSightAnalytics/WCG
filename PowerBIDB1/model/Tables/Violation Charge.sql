CREATE TABLE [model].[Violation Charge] (
    [ViolationChargeKey]        INT              NOT NULL,
    [Charge Amount]             NUMERIC (19, 2)  NOT NULL,
    [Charge Category]           VARCHAR (50)     NOT NULL,
    [Charge Category Order]     INT              NOT NULL,
    [Charge Code]               VARCHAR (10)     NOT NULL,
    [Charge Description]        VARCHAR (300)    NOT NULL,
    [Charge GUID]               UNIQUEIDENTIFIER NULL,
    [Charge Sub Category]       VARCHAR (50)     NOT NULL,
    [Charge Sub Category Order] INT              NOT NULL,
    [Regulation Number]         VARCHAR (100)    NOT NULL
);

