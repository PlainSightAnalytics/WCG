CREATE TABLE [itis].[departure_point] (
    [id]          UNIQUEIDENTIFIER NULL,
    [type]        NVARCHAR (MAX)   NULL,
    [updated_at]  NVARCHAR (MAX)   NULL,
    [display]     NVARCHAR (MAX)   NULL,
    [description] VARCHAR (MAX)    NULL,
    [DeltaLogKey] INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]    INT              DEFAULT ((-1)) NOT NULL
);

