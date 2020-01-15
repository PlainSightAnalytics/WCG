CREATE TABLE [model].[Object] (
    [ObjectKey]               INT           NOT NULL,
    [Create Date Time]        DATETIME      NULL,
    [Last Modified Date Time] DATETIME      NULL,
    [Object Full Name]        VARCHAR (100) NOT NULL,
    [Object Location]         VARCHAR (50)  NOT NULL,
    [Object Name]             VARCHAR (100) NOT NULL,
    [Object Type]             VARCHAR (50)  NOT NULL,
    [Object Type Order]       INT           NOT NULL,
    [Parent Object]           VARCHAR (100) NOT NULL,
    [Parent Object Order]     INT           NOT NULL,
    [Schema Name]             VARCHAR (10)  NOT NULL
);

