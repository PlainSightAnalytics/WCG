﻿CREATE TABLE [dbo].[DimCamera] (
    [CameraKey]                  INT              IDENTITY (1, 1) NOT NULL,
    [CameraGUID]                 UNIQUEIDENTIFIER NULL,
    [CameraID]                   VARCHAR (20)     DEFAULT ('UNK') NOT NULL,
    [CameraLocation]             VARCHAR (30)     DEFAULT ('Unknown') NOT NULL,
    [CameraName]                 VARCHAR (30)     DEFAULT ('Unknown') NOT NULL,
    [DistanceFromPreviousCamera] NUMERIC (11, 3)  NULL,
    [IsCountedInReport]          VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [IsMobileCamera]             VARCHAR (3)      DEFAULT ('No') NOT NULL,
    [LaneID]                     VARCHAR (50)     DEFAULT ('UNK') NOT NULL,
    [OperationalArea]            VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [OperationalAreaGUID]        UNIQUEIDENTIFIER NULL,
    [Route]                      VARCHAR (20)     DEFAULT ('Unknown') NOT NULL,
    [RouteSequence]              INT              DEFAULT ((0)) NOT NULL,
    [SiteID]                     VARCHAR (50)     DEFAULT ('UNK') NOT NULL,
    [SpeedSection]               VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [SpeedSectionDescription]    VARCHAR (100)    DEFAULT ('Unknown') NOT NULL,
    [SpeedSectionDistance]       NUMERIC (11, 2)  DEFAULT ((0)) NOT NULL,
    [SpeedSectionPoint]          VARCHAR (10)     DEFAULT ('Unknown') NOT NULL,
    [TrafficCentre]              VARCHAR (50)     DEFAULT ('Unknown') NOT NULL,
    [TrafficCentreGUID]          UNIQUEIDENTIFIER NULL,
    [TravelDirection]            VARCHAR (10)     DEFAULT ('Unknown') NOT NULL,
    [RowIsCurrent]               CHAR (1)         DEFAULT ('Y') NOT NULL,
    [RowIsInferred]              CHAR (1)         DEFAULT ('N') NOT NULL,
    [RowStartDate]               DATETIME         DEFAULT ('1 Jan 1900') NOT NULL,
    [RowEndDate]                 DATETIME         DEFAULT ('31 Dec 9999') NOT NULL,
    [RowChangeReason]            VARCHAR (200)    DEFAULT ('New Row') NOT NULL,
    [InsertAuditKey]             INT              DEFAULT ((-1)) NOT NULL,
    [UpdateAuditKey]             INT              DEFAULT ((-1)) NOT NULL,
    [DeltaLogKey]                INT              DEFAULT ((-1)) NOT NULL,
    [ExceptionRowKey]            INT              DEFAULT ((-1)) NOT NULL,
    CONSTRAINT [PK_dbo.DimCamera] PRIMARY KEY CLUSTERED ([CameraKey] ASC),
    CONSTRAINT [FK_dbo_DimCamera_InsertAuditKey] FOREIGN KEY ([InsertAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey]),
    CONSTRAINT [FK_dbo_DimCamera_UpdateAuditKey] FOREIGN KEY ([UpdateAuditKey]) REFERENCES [dbo].[DimAudit] ([AuditKey])
);

