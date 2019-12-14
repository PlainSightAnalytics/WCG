CREATE TABLE [model].[Last Known Location Shift Tasks] (
    [ShiftKey]             INT            NOT NULL,
    [Task End Time]        TIME (7)       NULL,
    [Task Start Time]      TIME (7)       NULL,
    [Tassk Duration Hours] NUMERIC (5, 2) NULL,
    [Location Type]        VARCHAR (20)   NOT NULL,
    [Shift Location]       VARCHAR (50)   NULL,
    [Shift Task]           VARCHAR (50)   NOT NULL,
    [Shift Task Type]      VARCHAR (30)   NOT NULL
);

