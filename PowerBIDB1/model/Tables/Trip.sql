CREATE TABLE [model].[Trip] (
    [TripKey]             INT             NOT NULL,
    [Route]               VARCHAR (15)    NOT NULL,
    [From To Camera]      VARCHAR (100)   NOT NULL,
    [Registration No]     VARCHAR (20)    NULL,
    [End Time]            DATETIME        NULL,
    [Start Time]          DATETIME        NULL,
    [Trip Duration]       NUMERIC (38, 3) NULL,
    [Total Distance]      NUMERIC (38, 3) NULL,
    [Average Speed]       NUMERIC (38, 6) NULL,
    [Speed Section Count] INT             NULL,
    [Previous End Time]   DATETIME        NULL,
    [Turnaround Hours]    INT             NULL,
    [Speeding Flag]       VARCHAR (3)     NULL,
    [Fatique Flag]        VARCHAR (3)     NULL,
    [Turnaround Flag]     VARCHAR (3)     NULL
);

