CREATE VIEW [dbo].[vwVehicleSearch] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Toufiq Abrahams
-- Date Created			:	10-12-2019
-- Reason				:	Combine Vehicle Search and Vehicle Search Stage
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------
 
   SELECT  [Timestamp]
		  ,[Latitude]
		  ,[Longitude]
		  ,[RegistrationNo]
		  ,[VehicleCategory]
		  ,[VehicleUsage]
		  ,[Route]
		  ,[SpeedSection]
		  ,[AlertCount]
		  ,[Alerts]
		  ,[AverageSpeed]
	FROM [dbo].[VehicleSearch]
	UNION ALL
	SELECT [Timestamp]
		  ,[Latitude]
		  ,[Longitude]
		  ,[RegistrationNo]
		  ,[VehicleCategory]
		  ,[VehicleUsage]
		  ,[Route]
		  ,[SpeedSection]
		  ,[AlertCount]
		  ,[Alerts]
		  ,[AverageSpeed]
  FROM [dbo].[VehicleSearchStage]