﻿CREATE TABLE [model].[Date] (
    [DateKey]                 INT          NOT NULL,
    [Full Date]               DATE         NULL,
    [Calendar Year]           SMALLINT     NOT NULL,
    [Year]                    VARCHAR (41) NULL,
    [Calendar Quarter]        TINYINT      NOT NULL,
    [Quarter]                 INT          NOT NULL,
    [Month]                   VARCHAR (3)  NOT NULL,
    [Calendar Month Number]   TINYINT      NOT NULL,
    [Financial Month Number]  INT          NULL,
    [Financial Year Display]  VARCHAR (12) NOT NULL,
    [Financial Month Display] VARCHAR (7)  NOT NULL,
    [Calendar Week]           TINYINT      NOT NULL,
    [Day Of Month]            TINYINT      NOT NULL,
    [Day Of Week Number]      TINYINT      NOT NULL,
    [Day Of Week]             VARCHAR (3)  NOT NULL,
    [Is Last Day Of Month]    VARCHAR (3)  NOT NULL,
    [Is Public Holiday]       VARCHAR (3)  NOT NULL,
    [Is Working Day]          VARCHAR (3)  NOT NULL,
    [Public Holiday Name]     VARCHAR (50) NOT NULL,
    [Year Display]            VARCHAR (41) NULL,
    [Month Display]           VARCHAR (3)  NOT NULL,
    [Month Year Name]         VARCHAR (15) NOT NULL,
    [CalendarYearMonthKey]    INT          NOT NULL
);
