CREATE TABLE [model].[Shift Week] (
    [ShiftWeekKey]    INT              NOT NULL,
    [Is User Week]    VARCHAR (3)      NOT NULL,
    [Roster Week]     VARCHAR (50)     NOT NULL,
    [Shift Week]      VARCHAR (50)     NOT NULL,
    [Shift Week GUID] UNIQUEIDENTIFIER NULL,
    [User]            VARCHAR (50)     NOT NULL,
    [User Role]       VARCHAR (30)     NOT NULL,
    [Week End Date]   DATE             NULL,
    [Week Start Date] DATE             NULL
);

