CREATE TABLE [itis].[officials_involved_in_operation] (
    [id]           UNIQUEIDENTIFIER NULL,
    [type]         NVARCHAR (MAX)   NULL,
    [updated_at]   NVARCHAR (MAX)   NULL,
    [display]      NVARCHAR (MAX)   NULL,
    [operation_id] UNIQUEIDENTIFIER NULL,
    [user_id]      UNIQUEIDENTIFIER NULL,
    [DeltaLogKey]  INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]     INT              DEFAULT ((-1)) NOT NULL
);

