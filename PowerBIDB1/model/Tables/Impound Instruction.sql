﻿CREATE TABLE [model].[Impound Instruction] (
    [ImpoundInstructionKey]                   INT              NOT NULL,
    [Create Date]                             DATETIME         NULL,
    [Has Jack]                                VARCHAR (3)      NOT NULL,
    [Has Spanners]                            VARCHAR (3)      NOT NULL,
    [Has Wheel Brace]                         VARCHAR (3)      NOT NULL,
    [Impound Date]                            DATETIME         NULL,
    [Impound Instruction ID]                  UNIQUEIDENTIFIER NULL,
    [Impound Officer]                         VARCHAR (50)     NOT NULL,
    [Impound Status]                          VARCHAR (50)     NOT NULL,
    [Incoming Impound Officer Signature Date] DATETIME         NULL,
    [Incoming Vehicle Owner Signature Date]   DATETIME         NULL,
    [Is Released As Scrap]                    VARCHAR (3)      NOT NULL,
    [Location]                                VARCHAR (50)     NOT NULL,
    [Offence Count]                           INT              NOT NULL,
    [Offence Date]                            DATETIME         NULL,
    [Offence Fine]                            NUMERIC (19, 2)  NOT NULL,
    [Officer Comments]                        VARCHAR (1000)   NULL,
    [Outgoing Impound Officer Signature Date] DATETIME         NULL,
    [Outgoing Vehicle Owner Signature Date]   DATETIME         NULL,
    [Override Reason]                         VARCHAR (1000)   NULL,
    [Pound Facility]                          VARCHAR (50)     NOT NULL,
    [Release Date]                            DATETIME         NULL,
    [Scrap Reason]                            VARCHAR (1000)   NULL,
    [Traffic Officer]                         VARCHAR (50)     NOT NULL,
    [Violation Type]                          VARCHAR (50)     NOT NULL,
    [Written Notice Number]                   VARCHAR (50)     NOT NULL
);

