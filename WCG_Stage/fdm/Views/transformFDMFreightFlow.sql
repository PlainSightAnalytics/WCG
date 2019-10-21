CREATE VIEW [fdm].[transformFDMFreightFlow] AS

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
SELECT DISTINCT
	 CONCAT([Origin Location Code],'-',[Destination Location Code]) AS [Freight Flow Code]
	,[National Road Allocated]
	--,[Trade]
	,[Rounded Distance]
	,[Freight Flow]
	,[Rail Friendly]
	,[Freight Flow Type]
	,[Distance Band]
	,[Distance Band Order]
	--,[Market Segmentation Code]
	--,[Market Segmentation]
	--,[Corridor Classification]
	,[Economic Corridor Classification Code]
	,[Economic Corridor Classification]
FROM fdm.transformWesternCapeFDMV1)

,CTE2 AS (
SELECT *
,ROW_NUMBER() OVER (PARTITION BY [Freight Flow Code] ORDER BY [Freight Flow Code]) AS RowSequence
FROM CTE)


SELECT *
FROM CTE2 
WHERE RowSequence = 1