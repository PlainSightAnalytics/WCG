CREATE TABLE [model].[Month] (
    [CalendarYearMonthKey]    INT          NULL,
    [Calendar Year]           SMALLINT     NOT NULL,
    [Month Display]           VARCHAR (3)  NOT NULL,
    [Month Year Name]         VARCHAR (15) NOT NULL,
    [Financial Month Display] VARCHAR (7)  NOT NULL,
    [Financial Month Number]  INT          NULL,
    [Financial Year Display]  VARCHAR (12) NOT NULL,
    [Year]                    VARCHAR (41) NULL
);

