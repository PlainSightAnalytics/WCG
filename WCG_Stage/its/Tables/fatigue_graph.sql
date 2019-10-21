CREATE TABLE [its].[fatigue_graph] (
    [id]            UNIQUEIDENTIFIER NULL,
    [type]          NVARCHAR (MAX)   NULL,
    [updated_at]    NVARCHAR (MAX)   NULL,
    [display]       NVARCHAR (MAX)   NULL,
    [date_uploaded] VARCHAR (MAX)    NULL,
    [fatigue_graph] VARCHAR (MAX)    NULL,
    [DeltaLogKey]   INT              DEFAULT ((-1)) NOT NULL,
    [AuditLogKey]   INT              DEFAULT ((-1)) NOT NULL
);

