CREATE TABLE [cle].[SightingsLatest] (
    [SightingRecordId] INT                NOT NULL,
    [ProviderId]       NVARCHAR (50)      NOT NULL,
    [CameraId]         NVARCHAR (50)      NOT NULL,
    [Timestamp]        DATETIMEOFFSET (7) NOT NULL,
    [LaneID]           INT                NOT NULL,
    [XCoord]           FLOAT (53)         NULL,
    [YCoord]           FLOAT (53)         NULL,
    [VRN]              NVARCHAR (10)      NULL
);

