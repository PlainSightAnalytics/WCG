












CREATE VIEW [model].[Trip Freight] AS 
------------------------------------------------------------------------------------------
-- Author               :   Generated from Model
-- Date Created         :   29 Sep 2018 4:51:16 PM
-- Reason               :   Semantic View for dbo.FactVehicleTracking
-- Modified By          :
-- Modified ON          :
-- Reason               :
------------------------------------------------------------------------------------------


SELECT 
	 TripKey			 AS [TripKey]
	,Route				 AS [Route]
	,FromToCamera		 AS [From To Camera]
	,RegistrationNo		 AS [Registration No]
	,EndTime			 AS [End Time]
	,StartTime			 AS [Start Time]
	,TripDuration		 AS [Trip Duration]
	,TotalDistance		 AS [Total Distance]
	,AverageSpeed		 AS [Average Speed]
	,SpeedSectionCount	 AS [Speed Section Count]
	,PreviousEndTime	 AS [Previous End Time]
	,TurnaroundHours	 As [Turnaround Hours]
	,SpeedingFlag		 AS [Speeding Flag]
	,FatiqueFlag		 AS [Fatique Flag]
	,TurnaroundFlag		 AS [Turnaround Flag]
FROM WCG_DW.dbo.DimTripFreight  WITH (NOLOCK) 


