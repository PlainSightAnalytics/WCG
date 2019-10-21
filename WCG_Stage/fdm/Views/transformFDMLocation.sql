

CREATE VIEW [fdm].[transformFDMLocation] AS

--------------------------------------------------------------------------------------------------------------------------------------
-- Author				:	Trevor Howe
-- Date Created			:	17-03-2019
-- Reason				:	Transform view for FDMLocation
--------------------------------------------------------------------------------------------------------------------------------------
-- Modified By			:
-- Modified On			:
-- Reason				:
--------------------------------------------------------------------------------------------------------------------------------------

WITH CTE AS (
SELECT 
	 [Origin Location Code]					AS [Location Code]
	,[Origin Location]						AS [Location]
	,[Origin Location Area]					AS [Location Area]
	,[Origin Province]						AS [Location Province]
	,[Origin Density]						AS [Location Density]
 FROM fdm.transformWesternCapeFDMV1
 
 UNION ALL
 
 SELECT 
	 [Destination Location Code]
	,[Destination Location]
	,[Destination Location Area]
	,[Destination Province]
	,[Destination Density]
 FROM fdm.transformWesternCapeFDMV1
 )

SELECT DISTINCT 
	 [Location Code]
	,[Location]
	,[Location Area]
	,[Location Province]
	,[Location Density]
	,CONCAT([Location Area],', ',[Location Province]) AS [Map Location]
FROM CTE
WHERE NULLIF([Location Code],'') IS NOT NULL
