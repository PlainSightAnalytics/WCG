CREATE TABLE [model].[Script] (
    [ScriptKey]          INT           IDENTITY (1, 1) NOT NULL,
    [Is Parent Script]   VARCHAR (3)   NOT NULL,
    [Parent Script Name] VARCHAR (100) NOT NULL,
    [Script Name]        VARCHAR (100) NOT NULL,
    [Script Order]       INT           NOT NULL
);

