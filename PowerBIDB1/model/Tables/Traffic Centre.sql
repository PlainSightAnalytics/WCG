CREATE TABLE [model].[Traffic Centre] (
    [TrafficCentreKey]                    INT              NOT NULL,
    [Authority]                           VARCHAR (50)     NOT NULL,
    [District]                            VARCHAR (50)     NOT NULL,
    [Email Address]                       VARCHAR (50)     NOT NULL,
    [Magistrates Court]                   VARCHAR (50)     NOT NULL,
    [Magistrates Court Code]              VARCHAR (20)     NOT NULL,
    [Magistrates Court Number]            VARCHAR (20)     NOT NULL,
    [Municipality]                        VARCHAR (50)     NOT NULL,
    [Municipality Has Electronic Payment] VARCHAR (3)      NOT NULL,
    [Municipality Has Postal Payment]     VARCHAR (3)      NOT NULL,
    [Municipality Place Of Payment]       VARCHAR (100)    NOT NULL,
    [Province]                            VARCHAR (50)     NOT NULL,
    [Regional Area]                       VARCHAR (50)     NOT NULL,
    [Regional Director]                   VARCHAR (50)     NOT NULL,
    [TCC]                                 VARCHAR (50)     NOT NULL,
    [Telephone No]                        VARCHAR (20)     NOT NULL,
    [Traffic Centre]                      VARCHAR (50)     NOT NULL,
    [Traffic Centre Code]                 VARCHAR (50)     NOT NULL,
    [Traffic Centre ID]                   UNIQUEIDENTIFIER NULL
);

