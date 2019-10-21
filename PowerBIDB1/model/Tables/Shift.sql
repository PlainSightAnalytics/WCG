﻿CREATE TABLE [model].[Shift] (
    [ShiftKey]                INT              NOT NULL,
    [Duration Hours]          NUMERIC (5, 2)   NOT NULL,
    [End Time]                TIME (7)         NULL,
    [Is Off Duty]             VARCHAR (3)      NOT NULL,
    [Is User Shift]           VARCHAR (3)      NOT NULL,
    [Officer]                 VARCHAR (50)     NOT NULL,
    [Roster Group]            VARCHAR (50)     NOT NULL,
    [Roster Group PPI]        VARCHAR (100)    NOT NULL,
    [Roster Group Reports To] VARCHAR (100)    NOT NULL,
    [Roster Group SPI]        VARCHAR (100)    NOT NULL,
    [Roster Status]           VARCHAR (50)     NOT NULL,
    [Roster Week]             VARCHAR (50)     NOT NULL,
    [Shift]                   VARCHAR (100)    NOT NULL,
    [Shift Date]              DATE             NULL,
    [Shift ID]                UNIQUEIDENTIFIER NULL,
    [Shift Time]              VARCHAR (30)     NOT NULL,
    [Shift Time Sort]         INT              NOT NULL,
    [Start Time]              TIME (7)         NULL,
    [User Role]               VARCHAR (30)     NOT NULL,
    [Week Day]                VARCHAR (10)     NOT NULL,
    [Week End Date]           DATE             NULL,
    [Week Start Date]         DATE             NULL,
    [WeekDayOrder]            INT              NULL
);

