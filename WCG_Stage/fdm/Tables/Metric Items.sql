CREATE TABLE [fdm].[Metric Items] (
    [Item]        NVARCHAR (50)  NOT NULL,
    [Code]        NVARCHAR (50)  NOT NULL,
    [Parent Item] NVARCHAR (50)  NULL,
    [Type]        NVARCHAR (50)  NOT NULL,
    [Sub Type]    NVARCHAR (50)  NULL,
    [Level]       INT            NOT NULL,
    [Order]       INT            NOT NULL,
    [Calculation] NVARCHAR (100) NULL
);

