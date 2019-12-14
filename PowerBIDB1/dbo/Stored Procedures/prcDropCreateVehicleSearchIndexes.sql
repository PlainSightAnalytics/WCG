CREATE PROCEDURE [dbo].[prcDropCreateVehicleSearchIndexes]
--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	13-12-2019
-- Reason				:	Drops or Creates Clustered Column Index on Vehicle Search Tables
--------------------------------------------------------------------------------------------------------------------------------------
-- Inputs				:	@Action, @Table
-- Ouputs				:	None
-- Test					:	exec prcDropCreateVehicleSearchIndexes 'Create', 'VehicleSearchStage'
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By	:
-- Modified On	:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

@Action				VARCHAR(10),
@Table				VARCHAR(20)

AS

IF @Table = 'VehicleSearch' AND @Action = 'Drop'
	DROP INDEX IF EXISTS [idxCCI] ON [dbo].[VehicleSearch]

IF @Table = 'VehicleSearchStage' AND @Action = 'Drop'
	DROP INDEX IF EXISTS [idxCCI] ON [dbo].[VehicleSearchStage]

IF @Table = 'VehicleSearch' AND @Action = 'Create'
	IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VehicleSearch]') AND name = N'idxCCI')
CREATE CLUSTERED COLUMNSTORE INDEX [idxCCI] ON [dbo].[VehicleSearch] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]

IF @Table = 'VehicleSearchStage' AND @Action = 'Create'
	IF NOT EXISTS (SELECT * FROM sys.indexes WHERE object_id = OBJECT_ID(N'[dbo].[VehicleSearchStage]') AND name = N'idxCCI')
CREATE CLUSTERED COLUMNSTORE INDEX [idxCCI] ON [dbo].[VehicleSearchStage] WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0) ON [PRIMARY]