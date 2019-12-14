CREATE VIEW [man].[transformDimGeographicalLocationCameraLocation] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	30-11-2019
-- Reason				:	Transform view for DimGeographicalLocation from man.CameraLocation
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:	
-- Modified On			:	
-- Reason				:	
--------------------------------------------------------------------------------------------------------------------------------------

SELECT 
	 CAST(CONCAT([Camera Location], ' ASOD Site') AS VARCHAR(50))	AS LocationName
	,CAST('ASOD Site' AS VARCHAR(20))								AS LocationType
	,CAST('Manual' AS VARCHAR(20))									AS Source
	,CAST([Latitude Range] AS NUMERIC(11,2))						AS [LatitudeRange]
	,CAST([Longitude Range] AS NUMERIC(11,2))						AS [LongitudeRange]
	,CAST(Latitude AS NUMERIC(11,6))								AS [Latitude]
	,CAST(Longitude AS NUMERIC(11,6))								AS [Longitude]
FROM [WCG_Stage].[man].CameraLocations