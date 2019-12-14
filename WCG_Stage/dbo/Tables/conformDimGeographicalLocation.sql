CREATE TABLE [dbo].[conformDimGeographicalLocation] (
    [LocationName]   VARCHAR (50)    NULL,
    [LocationType]   VARCHAR (20)    NULL,
    [Source]         VARCHAR (20)    NULL,
    [LatitudeRange]  NUMERIC (11, 2) NULL,
    [LongitudeRange] NUMERIC (11, 2) NULL,
    [Latitude]       NUMERIC (11, 6) NULL,
    [Longitude]      NUMERIC (11, 6) NULL,
    [DeltaLogKey]    INT             NULL
);

