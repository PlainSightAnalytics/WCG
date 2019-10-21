CREATE TABLE [sampleebat].[officer] (
    [id]                            UNIQUEIDENTIFIER NULL,
    [type]                          NVARCHAR (MAX)   NULL,
    [updated_at]                    NVARCHAR (MAX)   NULL,
    [display]                       NVARCHAR (MAX)   NULL,
    [authority_id]                  UNIQUEIDENTIFIER NULL,
    [rank_id]                       UNIQUEIDENTIFIER NULL,
    [station_id]                    UNIQUEIDENTIFIER NULL,
    [officer_full_name]             VARCHAR (MAX)    NULL,
    [officer_id_number]             VARCHAR (MAX)    NULL,
    [officer_infrastructure_number] VARCHAR (MAX)    NULL,
    [officer_initials]              VARCHAR (MAX)    NULL,
    [officer_mobile_number]         VARCHAR (MAX)    NULL,
    [officer_surname]               VARCHAR (MAX)    NULL,
    [other_authority]               VARCHAR (MAX)    NULL,
    [other_rank]                    VARCHAR (MAX)    NULL,
    [other_station]                 VARCHAR (MAX)    NULL,
    [DeltaLogKey]                   INT              DEFAULT ((-1)) NOT NULL,
    [AuditKey]                      INT              DEFAULT ((-1)) NOT NULL
);

