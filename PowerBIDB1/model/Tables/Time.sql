CREATE TABLE [model].[Time] (
    [TimeKey]           INT          NOT NULL,
    [AM PM Indicator]   VARCHAR (2)  NOT NULL,
    [Full Time]         TIME (7)     NULL,
    [Half Hour Band]    VARCHAR (10) NOT NULL,
    [Hour 12]           INT          NOT NULL,
    [Hour 24]           INT          NOT NULL,
    [Hour Band]         VARCHAR (15) NOT NULL,
    [Hour Shift Sort]   INT          NOT NULL,
    [Is 6am To 8pm]     VARCHAR (3)  NOT NULL,
    [Minute Of Hour]    INT          NOT NULL,
    [Period Of Day]     VARCHAR (10) NOT NULL,
    [Quarter Hour Band] VARCHAR (10) NOT NULL,
    [Shift]             VARCHAR (10) NOT NULL,
    [Time Name]         VARCHAR (10) NOT NULL,
    [HourSort]          INT          NOT NULL
);

