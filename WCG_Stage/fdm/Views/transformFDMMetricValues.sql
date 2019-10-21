CREATE VIEW [fdm].[transformFDMMetricValues] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-03-2019
-- Reason				:	Transform view for FDMMetricValues
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

SELECT *
FROM   
   (SELECT 
	 [Commodity Code]
	,[Origin Location Code]
	,[Destination Location Code]
	,CONCAT([Destination Location Code],'-',[Origin Location Code]) AS [Freight Flow Code]
	,[Trade]
	,[Market Segmentation Code]
	,[Market Segmentation]
	,[Corridor Classification]
	,[Vehicle Classification Code]
	,AVERAGEDISTANCE
	,RAILTONS
	,RAILTONKMS
	,RAILCOST
	,ROADTONS
	,ROADTONKMS
	,PIPETONS
	,PIPETONKMS
	,PIPECOST
	,TOTALTONS
	,TOTALTONKMS
	,TOTALTONS6Y
	,TOTALTONKMS6Y
	,TOTALTONS30Y
	,TOTALTONKMS30Y
	,NUMBEROFTRIPS
	,NUMBEROFVEHICLES
	,TRIPCOST
	,COSTPERTON
	,DEPRECIATION
	,COSTOFCAP
	,LICENCE
	,TOLLFEES
	,INSURANCE
	,DRIVER
	,FUEL
	,[M&R]
	,TYRES
	,TOTALROADCOST
	,TOTALTRANSPORTCOSTS
	,ROADACCIDENTS
	,ROADCONGESTION
	,ROADEMISSIONS
	,ROADLANDWAY
	,ROADNOISE
	,ROADPOLICING
	,RAILACCIDENTS
	,RAILEMISSIONS
	,RAILLANDWAY
	,RAILNOISE
	,ACCIDENTS
	,CONGESTION
	,EMISSIONS
	,LANDWAY
	,NOISE
	,POLICING
	,TOTALEXTERNALITYCOSTS
FROM fdm.transformWesternCapeFDMV1) p  
UNPIVOT  
   ([Metric Value] FOR [Metric Code] IN   
      (
	 AVERAGEDISTANCE
	,RAILTONS
	,RAILTONKMS
	,RAILCOST
	,ROADTONS
	,ROADTONKMS
	,PIPETONS
	,PIPETONKMS
	,PIPECOST
	,TOTALTONS
	,TOTALTONKMS
	,TOTALTONS6Y
	,TOTALTONKMS6Y
	,TOTALTONS30Y
	,TOTALTONKMS30Y
	,NUMBEROFTRIPS
	,NUMBEROFVEHICLES
	,TRIPCOST
	,COSTPERTON
	,DEPRECIATION
	,COSTOFCAP
	,LICENCE
	,TOLLFEES
	,INSURANCE
	,DRIVER
	,FUEL
	,[M&R]
	,TYRES
	,TOTALROADCOST
	,TOTALTRANSPORTCOSTS
	,ROADACCIDENTS
	,ROADCONGESTION
	,ROADEMISSIONS
	,ROADLANDWAY
	,ROADNOISE
	,ROADPOLICING
	,RAILACCIDENTS
	,RAILEMISSIONS
	,RAILLANDWAY
	,RAILNOISE
	,ACCIDENTS
	,CONGESTION
	,EMISSIONS
	,LANDWAY
	,NOISE
	,POLICING
	,TOTALEXTERNALITYCOSTS)
)AS unpvt;  


