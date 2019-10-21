CREATE TABLE [model].[User] (
    [UserKey]               INT              NOT NULL,
    [Designation]           VARCHAR (50)     NOT NULL,
    [Infrastructure Number] VARCHAR (30)     NOT NULL,
    [Role]                  VARCHAR (50)     NOT NULL,
    [User]                  VARCHAR (100)    NOT NULL,
    [User ID]               UNIQUEIDENTIFIER NULL,
    [User Traffic Centre]   VARCHAR (50)     NOT NULL
);

