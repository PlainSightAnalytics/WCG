CREATE TABLE [model].[_Audit Log] (
    [StartDateKey]     NVARCHAR (4000) NULL,
    [StartTimeKey]     NVARCHAR (4000) NULL,
    [ExecuteObjectKey] INT             NOT NULL,
    [LoadObjectKey]    INT             NOT NULL,
    [AuditKey]         INT             NOT NULL,
    [DateTimeStart]    DATETIME        NULL,
    [DateTimeStop]     DATETIME        NULL,
    [RowCountInitial]  INT             NULL,
    [RowCountFinal]    INT             NULL,
    [RowCountInsert]   INT             NULL
);

