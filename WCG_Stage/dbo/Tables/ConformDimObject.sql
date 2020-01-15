CREATE TABLE [dbo].[ConformDimObject] (
    [CreateDateTime]       DATETIME      NULL,
    [LastModifiedDateTime] DATETIME      NULL,
    [LocationName]         VARCHAR (50)  NULL,
    [ObjectFullName]       VARCHAR (100) NULL,
    [ObjectName]           VARCHAR (100) NULL,
    [ObjectType]           VARCHAR (50)  NULL,
    [ObjectTypeOrder]      INT           NULL,
    [ParentObjectName]     VARCHAR (100) NULL,
    [ParentObjectOrder]    INT           NULL,
    [SchemaName]           VARCHAR (10)  NULL
);

